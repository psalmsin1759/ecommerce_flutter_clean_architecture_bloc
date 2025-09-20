import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:julybyoma_app/features/product/presentation/bloc/product_event.dart';
import 'package:julybyoma_app/features/product/presentation/bloc/product_state.dart';
import 'package:julybyoma_app/features/product/presentation/pages/product_detail.dart';
import 'package:julybyoma_app/features/product/presentation/widgets/product_card.dart';
import 'package:julybyoma_app/injection.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedProductsWidget extends StatelessWidget {
  const FeaturedProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductBloc>()..add(GetFeaturedProductsEvent()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image placeholder
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        // Text placeholders
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 14,
                            width: 80,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            height: 12,
                            width: 40,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4,
                          ),
                          child: Container(
                            height: 14,
                            width: 60,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ProductLoaded) {
            if (state.products.isEmpty) {
              return const Center(child: Text("No featured products found"));
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailWidget(product: product),
                    ),
                  ),
                  child: ProductCard(product: product),
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
