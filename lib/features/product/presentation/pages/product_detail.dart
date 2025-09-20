import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/common/widget/header_widget.dart';
import 'package:julybyoma_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:julybyoma_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:julybyoma_app/features/cart/presentation/bloc/cart_event.dart';
import 'package:julybyoma_app/features/product/domain/entities/product_entiity.dart';
import 'package:julybyoma_app/features/product/presentation/widgets/product_card.dart';

class ProductDetailWidget extends StatefulWidget {
  final ProductEntity product;
  final List<ProductEntity>? relatedProducts;

  const ProductDetailWidget({
    super.key,
    required this.product,
    this.relatedProducts,
  });

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  int _quantity = 1;
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              HeaderWidget(title: "Product Details"),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImageSection(product),

                      const SizedBox(height: 16),

                      Text(
                        product.name ?? "",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "₦${product.salePrice ?? product.price ?? 0}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (product.salePrice != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "₦${product.price}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                          const Spacer(),
                          Icon(
                            product.isInStock == true
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: product.isInStock == true
                                ? Colors.green
                                : Colors.red,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            product.isInStock == true
                                ? "In Stock"
                                : "Out of Stock",
                            style: TextStyle(
                              color: product.isInStock == true
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            "${product.averageRating?.toStringAsFixed(1) ?? "0"} "
                            "(${product.reviewCount ?? 0} reviews)",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Text(
                        product.description ?? "No description available.",
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          const Text(
                            "Quantity:",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    if (_quantity > 1) {
                                      setState(() => _quantity--);
                                    }
                                  },
                                ),
                                Text(
                                  "$_quantity",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() => _quantity++);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            onPressed: product.isInStock == true
                                ? () {
                                    final cartItem = CartItemEntity(
                                      productId: product.sId ?? "",
                                      name: product.name ?? "",
                                      price:
                                          product.salePrice ??
                                          product.price ??
                                          0,
                                      quantity: _quantity,
                                      image: product.images?.isNotEmpty == true
                                          ? product.images!.first.url
                                          : null,
                                    );

                                    context.read<CartBloc>().add(
                                      AddToCartEvent(cartItem),
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Added to cart!"),
                                      ),
                                    );
                                  }
                                : null,
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Add to Cart",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // --- Reviews ---
                      _buildReviewSection(product),

                      const SizedBox(height: 24),

                      // --- Related Products ---
                      if (widget.relatedProducts != null &&
                          widget.relatedProducts!.isNotEmpty) ...[
                        const Text(
                          "Related Products",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 280,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.relatedProducts!.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final related = widget.relatedProducts![index];
                              return SizedBox(
                                width: 160,
                                child: ProductCard(product: related),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Product image with thumbnails ---
  Widget _buildImageSection(ProductEntity product) {
    final images = product.images ?? [];

    if (images.isEmpty) {
      return Container(
        height: 300,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.image, size: 80, color: Colors.grey),
        ),
      );
    }

    return Column(
      children: [
        // Main image
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              images[_selectedImageIndex].url ?? "",
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 80),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Thumbnails
        SizedBox(
          height: 70,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final img = images[index];
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedImageIndex = index);
                },
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedImageIndex == index
                          ? Colors.blue
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      img.url ?? "",
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- Reviews section ---
  Widget _buildReviewSection(ProductEntity product) {
    final reviews = product.reviews ?? [];

    if (reviews.isEmpty) {
      return const Text(
        "No reviews yet.",
        style: TextStyle(fontSize: 14, color: Colors.black54),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Reviews",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...reviews.map((review) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text("${review.rating?.toStringAsFixed(1) ?? "0"}"),
                    const Spacer(),
                    Text(
                      review.userName ?? "Anonymous",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(review.comment ?? ""),
                const SizedBox(height: 6),
                Text(
                  review.createdAt ?? "",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
