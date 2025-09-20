import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/error/failures.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/injection.dart';
import '../repositories/cart_repository.dart';

class ClearCartUseCase extends UseCase<Either<Failure, Unit>, NoParams> {
  @override
  Future<Either<Failure, Unit>> call({NoParams? param}) async {
    try {
      await getIt<CartRepository>().clearCart();
      return Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}

class NoParams {}
