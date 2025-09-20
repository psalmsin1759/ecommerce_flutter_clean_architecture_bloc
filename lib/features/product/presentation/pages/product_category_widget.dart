import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/common/widget/header_widget.dart';
import 'package:julybyoma_app/features/category/domain/entities/category_entity.dart';
import 'package:julybyoma_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:julybyoma_app/features/product/presentation/bloc/product_event.dart';
import 'package:julybyoma_app/features/product/presentation/bloc/product_state.dart';
import 'package:julybyoma_app/features/product/presentation/pages/product_detail.dart';
import 'package:julybyoma_app/features/product/presentation/widgets/product_card.dart';
import 'package:julybyoma_app/injection.dart';
import 'package:shimmer/shimmer.dart';

class ProductByCategoryWidget extends StatefulWidget {
  final CategoryEntity category;
  const ProductByCategoryWidget({super.key, required this.category});

  @override
  State<ProductByCategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<ProductByCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) =>
              getIt<ProductBloc>()
                ..add(GetProductsByCategoryEvent(widget.category.id)),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  // --- Pinned header ---
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _HeaderDelegate(
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                        alignment: Alignment.centerLeft,
                        child: HeaderWidget(title: widget.category.name),
                      ),
                      minHeight: 72,
                      maxHeight: 72,
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    sliver: _buildProductSliver(state),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductSliver(ProductState state) {
    if (state is ProductLoading) {
      return SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
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
        }, childCount: 6),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
      );
    } else if (state is ProductLoaded) {
      if (state.products.isEmpty) {
        return const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: Text("No products found")),
        );
      }

      return SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          final product = state.products[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailWidget(product: product),
              ),
            ),
            child: ProductCard(product: product),
          );
        }, childCount: state.products.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
      );
    } else if (state is ProductError) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: Text("Error: ${state.message}")),
      );
    }

    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  _HeaderDelegate({
    required this.child,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(covariant _HeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight;
  }
}
