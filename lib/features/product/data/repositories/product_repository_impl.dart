import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/error/failures.dart';
import 'package:julybyoma_app/core/network/network_info.dart';
import 'package:julybyoma_app/features/product/data/models/product_model.dart';
import 'package:julybyoma_app/features/product/data/sources/product_local_data_source.dart';
import 'package:julybyoma_app/features/product/data/sources/product_remote_data_source.dart';
import 'package:julybyoma_app/features/product/domain/entities/product_entiity.dart';
import 'package:julybyoma_app/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? search,
    bool? isFeatured,
  }) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.getProducts(
        page: page,
        limit: limit,
        categoryId: categoryId,
        search: search,
        isFeatured: isFeatured,
      );

      return response.fold((error) => Left(ServerFailure(error.toString())), (
        products,
      ) async {
        // cache locally
        await localDataSource.cacheProducts(products as List<ProductModel>);
        return Right(products);
      });
    } else {
      try {
        final localProducts = await localDataSource.getCachedProducts();
        return Right(localProducts);
      } catch (e) {
        return Left(CacheFailure('No cached products available'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.getProductById(id);

      return response.fold((error) => Left(ServerFailure(error.toString())), (
        product,
      ) async {
        await localDataSource.cacheProduct(product as ProductModel);
        return Right(product);
      });
    } else {
      try {
        final localProduct = await localDataSource.getCachedProductById(id);
        if (localProduct != null) {
          return Right(localProduct);
        } else {
          return Left(CacheFailure('Product not found in cache'));
        }
      } catch (e) {
        return Left(CacheFailure('Failed to load cached product'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> addReview({
    required String productId,
    required Reviews review,
  }) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.addReview(
        productId: productId,
        review: review,
      );

      return response.fold((error) => Left(ServerFailure(error.toString())), (
        product,
      ) async {
        await localDataSource.cacheProduct(product as ProductModel);
        return Right(product);
      });
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getFeaturedProducts() async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.getFeaturedProducts();

      return response.fold((error) => Left(ServerFailure(error.toString())), (
        products,
      ) async {
        await localDataSource.cacheProducts(
          products.map((p) => p as ProductModel).toList(),
        );
        return Right(products);
      });
    } else {
      try {
        final localProducts = await localDataSource.getCachedProducts();
        final featured = localProducts
            .where((p) => p.isFeatured == true)
            .toList();
        return Right(featured);
      } catch (e) {
        return Left(CacheFailure('No cached featured products available'));
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String categoryId,
  ) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.getProductsByCategory(categoryId);

      return response.fold((error) => Left(ServerFailure(error.toString())), (
        products,
      ) async {
        await localDataSource.cacheProducts(products as List<ProductModel>);
        return Right(products);
      });
    } else {
      try {
        final localProducts = await localDataSource.getCachedProducts();
        final filtered = localProducts
            .where((p) => p.categories?.contains(categoryId) ?? false)
            .toList();
        return Right(filtered);
      } catch (e) {
        return Left(CacheFailure('No cached products for this category'));
      }
    }
  }
}
