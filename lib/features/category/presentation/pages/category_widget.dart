import 'package:flutter/material.dart';
import 'package:julybyoma_app/common/widget/header_widget.dart';
import 'package:julybyoma_app/features/category/domain/entities/category_entity.dart';

class CategoryWidget extends StatefulWidget {
  final CategoryEntity category;
  const CategoryWidget({super.key, required this.category});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                HeaderWidget(title: widget.category.name),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
