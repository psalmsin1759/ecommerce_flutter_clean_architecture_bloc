import 'package:flutter/material.dart';
import 'package:julybyoma_app/common/widget/header_widget.dart';
import 'package:julybyoma_app/features/category/presentation/widgets/category_vertical_widget.dart';

class AllCategoriesWidget extends StatelessWidget {
  const AllCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                HeaderWidget(title: "Categories"),
                SizedBox(height: 30),
                CategoryVerticalListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
