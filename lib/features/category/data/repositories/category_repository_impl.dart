import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:julybyoma_app/core/constants/api_urls.dart';
import 'package:julybyoma_app/core/network/dio_client.dart';
import 'package:julybyoma_app/features/category/domain/entities/category_entity.dart';
import 'package:julybyoma_app/features/category/domain/repository/category_respository.dart';
import 'package:julybyoma_app/injection.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  @override
  Future<Either<String, List<CategoryEntity>>> getCategories() async {
    try {
      final response = await getIt<DioClient>().get(ApiUrls.categoryURL);

      final List data = response.data as List;
      final categories = data
          .map((json) => CategoryEntity.fromJson(json))
          .toList();

      return Right(categories);
    } on DioException catch (e) {
      return Left(e.response?.data["error"] ?? e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
