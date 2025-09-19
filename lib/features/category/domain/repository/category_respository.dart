import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/features/category/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<String, List<CategoryEntity>>> getCategories();
}
