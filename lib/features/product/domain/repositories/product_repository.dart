import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/error/failures.dart';
import 'package:julybyoma_app/features/product/domain/entities/product_entiity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? search,
    bool? isFeatured,
  });

  Future<Either<Failure, ProductEntity>> getProductById(String id);

  Future<Either<Failure, ProductEntity>> addReview({
    required String productId,
    required Reviews review,
  });

  Future<Either<Failure, List<ProductEntity>>> getFeaturedProducts();

  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String categoryId,
  );
}
