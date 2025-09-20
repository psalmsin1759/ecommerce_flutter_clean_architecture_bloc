import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/error/failures.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/injection.dart';
import '../repositories/cart_repository.dart';

class UpdateQuantityUseCase
    extends UseCase<Either<Failure, Unit>, UpdateQuantityParams> {
  @override
  Future<Either<Failure, Unit>> call({UpdateQuantityParams? param}) async {
    try {
      await getIt<CartRepository>().updateQuantity(
        param!.productId,
        param.quantity,
      );
      return Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}

class UpdateQuantityParams {
  final String productId;
  final int quantity;

  UpdateQuantityParams(this.productId, this.quantity);
}
