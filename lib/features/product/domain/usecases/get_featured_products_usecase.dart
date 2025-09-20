import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/error/failures.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/product/domain/entities/product_entiity.dart';
import 'package:julybyoma_app/injection.dart';
import '../repositories/product_repository.dart';

class GetFeaturedProductsUseCase
    extends UseCase<Either<Failure, List<ProductEntity>>, NoParams> {
  @override
  Future<Either<Failure, List<ProductEntity>>> call({NoParams? param}) {
    return getIt<ProductRepository>().getProducts(isFeatured: true, limit: 8);
  }
}

class NoParams {}
