import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/features/category/domain/usecase/get_category_usecase.dart';
import 'package:julybyoma_app/features/category/presentation/bloc/category_bloc.dart';
import 'package:julybyoma_app/features/category/presentation/bloc/category_state.dart';
import 'package:julybyoma_app/features/category/presentation/bloc/category_event.dart';
import 'package:julybyoma_app/features/category/presentation/pages/category_widget.dart';
import 'package:julybyoma_app/features/category/presentation/widgets/category_card.dart';
import 'package:shimmer/shimmer.dart';

class CategoryHorizontalListWidget extends StatelessWidget {
  const CategoryHorizontalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CategoryBloc(getCategoryUsecase: GetCategoryUsecase())
            ..add(GetCategoryEvent()),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 100,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(""),
                    ),
                  );
                },
              ),
            );
          } else if (state is CategoryLoaded) {
            return SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryWidget(category: category),
                      ),
                    ),
                    child: CategoryCard(category: category),
                  );
                },
              ),
            );
          } else if (state is CategoryError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            context.read<CategoryBloc>().add(GetCategoryEvent());
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
