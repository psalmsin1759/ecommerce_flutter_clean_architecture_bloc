import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetFeaturedProductsEvent extends ProductEvent {}

class GetProductByIdEvent extends ProductEvent {
  final String id;

  const GetProductByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetProductsEvent extends ProductEvent {
  final int page;
  final int limit;
  final String? categoryId;
  final String? search;
  final bool? isFeatured;

  const GetProductsEvent({
    this.page = 1,
    this.limit = 20,
    this.categoryId,
    this.search,
    this.isFeatured,
  });

  @override
  List<Object?> get props => [page, limit, categoryId, search, isFeatured];
}

class GetProductsByCategoryEvent extends ProductEvent {
  final String categoryId;

  const GetProductsByCategoryEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
