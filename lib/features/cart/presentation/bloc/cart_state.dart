import 'package:julybyoma_app/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> items;
  final double total;

  CartLoaded(this.items)
    : total = items.fold(0, (sum, item) => sum + item.price * item.quantity);

  int get count => items.fold(0, (sum, item) => sum + item.quantity);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
