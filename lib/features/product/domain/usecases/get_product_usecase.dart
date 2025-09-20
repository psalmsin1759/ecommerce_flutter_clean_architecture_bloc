import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/error/failures.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/product/domain/entities/product_entiity.dart';
import 'package:julybyoma_app/injection.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase
    extends UseCase<Either<Failure, List<ProductEntity>>, GetProductsParams> {
  @override
  Future<Either<Failure, List<ProductEntity>>> call({
    GetProductsParams? param,
  }) {
    return getIt<ProductRepository>().getProducts(
      page: param?.page ?? 1,
      limit: param?.limit ?? 20,
      categoryId: param?.categoryId,
      search: param?.search,
      isFeatured: param?.isFeatured,
    );
  }
}

class GetProductsParams {
  final int page;
  final int limit;
  final String? categoryId;
  final String? search;
  final bool? isFeatured;

  GetProductsParams({
    this.page = 1,
    this.limit = 20,
    this.categoryId,
    this.search,
    this.isFeatured,
  });
}
