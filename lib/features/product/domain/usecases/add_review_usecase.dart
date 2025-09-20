import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/error/failures.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/product/domain/entities/product_entiity.dart';
import 'package:julybyoma_app/injection.dart';
import '../repositories/product_repository.dart';

class AddReviewUseCase
    extends UseCase<Either<Failure, ProductEntity>, AddReviewParams> {
  @override
  Future<Either<Failure, ProductEntity>> call({AddReviewParams? param}) {
    return getIt<ProductRepository>().addReview(
      productId: param!.productId,
      review: param.review,
    );
  }
}

class AddReviewParams {
  final String productId;
  final Reviews review;

  AddReviewParams({required this.productId, required this.review});
}
