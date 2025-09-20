import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/error/failures.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:julybyoma_app/injection.dart';
import '../repositories/cart_repository.dart';

class GetCartUseCase
    extends UseCase<Either<Failure, List<CartItemEntity>>, NoParams> {
  @override
  Future<Either<Failure, List<CartItemEntity>>> call({NoParams? param}) async {
    try {
      final cart = await getIt<CartRepository>().getCart();
      return Right(cart);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}

class NoParams {}
