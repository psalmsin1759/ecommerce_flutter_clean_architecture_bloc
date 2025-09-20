import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/error/failures.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/product/domain/entities/product_entiity.dart';
import 'package:julybyoma_app/injection.dart';
import '../repositories/product_repository.dart';

class GetProductByIdUseCase
    extends UseCase<Either<Failure, ProductEntity>, GetProductByIdParams> {
  @override
  Future<Either<Failure, ProductEntity>> call({GetProductByIdParams? param}) {
    return getIt<ProductRepository>().getProductById(param!.id);
  }
}

class GetProductByIdParams {
  final String id;

  GetProductByIdParams({required this.id});
}
