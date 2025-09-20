import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:julybyoma_app/core/constants/api_urls.dart';
import 'package:julybyoma_app/core/network/dio_client.dart';
import 'package:julybyoma_app/injection.dart';
import 'package:julybyoma_app/features/product/data/models/product_model.dart';
import 'package:julybyoma_app/features/product/domain/entities/product_entiity.dart';

abstract class ProductRemoteDataSource {
  Future<Either> getProducts({
    int page,
    int limit,
    String? categoryId,
    String? search,
    bool? isFeatured,
  });

  Future<Either> getProductById(String id);

  Future<Either> addReview({
    required String productId,
    required Reviews review,
  });

  Future<Either> getFeaturedProducts();

  Future<Either> getProductsByCategory(String categoryId);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final DioClient client = getIt<DioClient>();

  @override
  Future<Either> getProducts({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? search,
    bool? isFeatured,
  }) async {
    try {
      final response = await client.get(
        ApiUrls.productsURL,
        queryParameters: {
          "page": page,
          "limit": limit,
          "categoryId": categoryId,
          "search": search,
          "isFeatured": isFeatured,
        }..removeWhere((key, value) => value == null),
      );

      final data = response.data;

      final List<ProductEntity> products = (data["items"] as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
      return Right(products);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unexpected error");
    }
  }

  @override
  Future<Either> getProductById(String id) async {
    try {
      final response = await client.get("${ApiUrls.productsURL}/$id");

      final product = ProductModel.fromJson(response as Map<String, dynamic>);

      return Right(product);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unexpected error");
    }
  }

  @override
  Future<Either> addReview({
    required String productId,
    required Reviews review,
  }) async {
    try {
      final response = await client.post(
        "${ApiUrls.productsURL}/$productId/reviews",
        data: review,
      );

      final product = ProductModel.fromJson(response as Map<String, dynamic>);

      return Right(product);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unexpected error");
    }
  }

  @override
  Future<Either> getFeaturedProducts() async {
    try {
      final response = await client.get("${ApiUrls.productsURL}/featured");

      final data = response.data;

      final List<ProductEntity> products = (data["items"] as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
      return Right(products);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unexpected error");
    }
  }

  @override
  Future<Either> getProductsByCategory(String categoryId) async {
    try {
      final response = await client.get(
        "${ApiUrls.productsURL}/category/$categoryId",
      );

      final data = response.data;

      final List<ProductEntity> products = (data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      return Right(products);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? "Unexpected error");
    }
  }
}
