import 'package:julybyoma_app/features/category/domain/entities/category_entity.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;

  CategoryLoaded({required this.categories});
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError({required this.message});
}
