import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/category/domain/entities/category_entity.dart';
import 'package:julybyoma_app/features/category/domain/repository/category_respository.dart';
import 'package:julybyoma_app/injection.dart';

class GetCategoryUsecase
    extends UseCase<Either<String, List<CategoryEntity>>, void> {
  @override
  Future<Either<String, List<CategoryEntity>>> call({void param}) {
    return getIt<CategoryRepository>().getCategories();
  }
}
