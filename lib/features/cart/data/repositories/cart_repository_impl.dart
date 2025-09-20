import 'package:julybyoma_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:julybyoma_app/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final List<CartItemEntity> _cart = [];

  @override
  Future<List<CartItemEntity>> getCart() async {
    return List<CartItemEntity>.from(_cart);
  }

  @override
  Future<void> addToCart(CartItemEntity item) async {
    final index = _cart.indexWhere((c) => c.productId == item.productId);
    if (index >= 0) {
      _cart[index] = _cart[index].copyWith(
        quantity: _cart[index].quantity + item.quantity,
      );
    } else {
      _cart.add(item);
    }
  }

  @override
  Future<void> removeFromCart(String productId) async {
    _cart.removeWhere((c) => c.productId == productId);
  }

  @override
  Future<void> updateQuantity(String productId, int quantity) async {
    final index = _cart.indexWhere((c) => c.productId == productId);
    if (index >= 0) {
      _cart[index] = _cart[index].copyWith(quantity: quantity);
    }
  }

  @override
  Future<void> clearCart() async {
    _cart.clear();
  }
}
