import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/error/failures.dart';
import 'package:julybyoma_app/core/usecase/usecase.dart';
import 'package:julybyoma_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:julybyoma_app/injection.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase extends UseCase<Either<Failure, void>, AddToCartParams> {
  @override
  Future<Either<Failure, Unit>> call({AddToCartParams? param}) async {
    try {
      await getIt<CartRepository>().addToCart(param!.item);
      return Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}

class AddToCartParams {
  final CartItemEntity item;

  AddToCartParams(this.item);
}
