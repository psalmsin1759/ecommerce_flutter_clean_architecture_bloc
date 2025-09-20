import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:julybyoma_app/features/product/domain/entities/product_entiity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 160,
            width: double.infinity,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: (product.images != null && product.images!.isNotEmpty)
                      ? CachedNetworkImage(
                          imageUrl:
                              "https://cdn.dummyjson.com/product-images/fragrances/dior-j'adore/1.webp",
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                        )
                      : Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.image, size: 80),
                          ),
                        ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${product.name} added to wishlist"),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white70,
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.star, size: 16, color: Colors.orange[400]),
                const SizedBox(width: 4),
                Text(
                  product.averageRating?.toStringAsFixed(1) ?? "0.0",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
