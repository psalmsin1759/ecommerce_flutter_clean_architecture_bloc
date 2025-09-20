import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/error/failures.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/injection.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCartUseCase
    extends UseCase<Either<Failure, Unit>, RemoveFromCartParams> {
  @override
  Future<Either<Failure, Unit>> call({RemoveFromCartParams? param}) async {
    try {
      await getIt<CartRepository>().removeFromCart(param!.productId);
      return Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}

class RemoveFromCartParams {
  final String productId;

  RemoveFromCartParams(this.productId);
}
