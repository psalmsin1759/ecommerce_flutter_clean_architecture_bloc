import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/features/category/domain/usecase/get_category_usecase.dart';
import 'package:julybyoma_app/features/category/presentation/bloc/category_bloc.dart';
import 'package:julybyoma_app/features/category/presentation/bloc/category_event.dart';
import 'package:julybyoma_app/features/category/presentation/bloc/category_state.dart';
import 'package:julybyoma_app/features/category/presentation/pages/category_widget.dart';
import 'package:shimmer/shimmer.dart';

class CategoryVerticalListWidget extends StatelessWidget {
  const CategoryVerticalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CategoryBloc(getCategoryUsecase: GetCategoryUsecase())
            ..add(GetCategoryEvent()),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    color: Colors.grey,
                  ),
                );
              },
            );
          } else if (state is CategoryLoaded) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.categories.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryWidget(category: category),
                    ),
                  ),
                  leading: const Icon(Icons.category, color: Colors.blueAccent),
                  title: Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                );
              },
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
