import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/error/failures.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/product/domain/entities/product_entiity.dart';
import 'package:julybyoma_app/injection.dart';
import '../repositories/product_repository.dart';

class GetProductsByCategoryUseCase
    extends
        UseCase<
          Either<Failure, List<ProductEntity>>,
          GetProductsByCategoryParams
        > {
  @override
  Future<Either<Failure, List<ProductEntity>>> call({
    GetProductsByCategoryParams? param,
  }) {
    return getIt<ProductRepository>().getProductsByCategory(param!.categoryId);
  }
}

class GetProductsByCategoryParams {
  final String categoryId;

  GetProductsByCategoryParams({required this.categoryId});
}
