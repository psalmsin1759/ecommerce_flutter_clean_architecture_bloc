class CartItemEntity {
  final String productId;
  final String name;
  final double price;
  final String? image;
  final int quantity;

  CartItemEntity({
    required this.productId,
    required this.name,
    required this.price,
    this.image,
    this.quantity = 1,
  });

  CartItemEntity copyWith({
    String? productId,
    String? name,
    double? price,
    String? image,
    int? quantity,
  }) {
    return CartItemEntity(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }
}
