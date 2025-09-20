import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:julybyoma_app/core/error/failures.dart';
import 'package:julybyoma_app/features/product/domain/entities/product_entiity.dart';
import 'package:julybyoma_app/features/product/domain/usecases/get_featured_products_usecase.dart';
import 'package:julybyoma_app/features/product/domain/usecases/get_product_by_id_usecase.dart';
import 'package:julybyoma_app/features/product/domain/usecases/get_product_usecase.dart';
import 'package:julybyoma_app/features/product/domain/usecases/get_products_by_category_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetFeaturedProductsUseCase getFeaturedProducts;
  final GetProductByIdUseCase getProductById;
  final GetProductsUseCase getProducts;
  final GetProductsByCategoryUseCase getProductsByCategory;

  ProductBloc({
    required this.getFeaturedProducts,
    required this.getProductById,
    required this.getProducts,
    required this.getProductsByCategory,
  }) : super(ProductInitial()) {
    on<GetFeaturedProductsEvent>(_onGetFeaturedProducts);
    on<GetProductByIdEvent>(_onGetProductById);
    on<GetProductsEvent>(_onGetProducts);
    on<GetProductsByCategoryEvent>(_onGetProductsByCategory);
  }

  Future<void> _onGetFeaturedProducts(
    GetFeaturedProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final Either<Failure, List<ProductEntity>> result =
        await getFeaturedProducts(param: NoParams());

    result.fold(
      (failure) => emit(ProductError(_mapFailureToMessage(failure))),
      (products) => emit(ProductLoaded(products)),
    );
  }

  Future<void> _onGetProductById(
    GetProductByIdEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await getProductById(
      param: GetProductByIdParams(id: event.id),
    );

    result.fold(
      (failure) => emit(ProductError(_mapFailureToMessage(failure))),
      (product) => emit(SingleProductLoaded(product)),
    );
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await getProducts(
      param: GetProductsParams(
        page: event.page,
        limit: event.limit,
        categoryId: event.categoryId,
        search: event.search,
        isFeatured: event.isFeatured,
      ),
    );

    result.fold(
      (failure) => emit(ProductError(_mapFailureToMessage(failure))),
      (products) => emit(ProductLoaded(products)),
    );
  }

  Future<void> _onGetProductsByCategory(
    GetProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await getProductsByCategory(
      param: GetProductsByCategoryParams(categoryId: event.categoryId),
    );

    result.fold(
      (failure) => emit(ProductError(_mapFailureToMessage(failure))),
      (products) => emit(ProductLoaded(products)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.toString();
  }
}
