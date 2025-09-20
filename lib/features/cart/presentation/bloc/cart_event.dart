import 'package:julybyoma_app/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartEvent {}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final CartItemEntity item;
  AddToCartEvent(this.item);
}

class RemoveFromCartEvent extends CartEvent {
  final String productId;
  RemoveFromCartEvent(this.productId);
}

class UpdateCartQuantityEvent extends CartEvent {
  final String productId;
  final int quantity;
  UpdateCartQuantityEvent(this.productId, this.quantity);
}

class ClearCartEvent extends CartEvent {}
