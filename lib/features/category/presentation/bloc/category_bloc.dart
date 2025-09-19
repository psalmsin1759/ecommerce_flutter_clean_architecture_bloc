import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/features/category/domain/usecase/get_category_usecase.dart';
import 'package:julybyoma_app/features/category/presentation/bloc/category_event.dart';
import 'package:julybyoma_app/features/category/presentation/bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryUsecase getCategoryUsecase;

  CategoryBloc({required this.getCategoryUsecase})
    : super(CategoryInitialState()) {
    on<GetCategoryEvent>(onGetCategoryEvent);
  }

  Future<void> onGetCategoryEvent(
    GetCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final result = await getCategoryUsecase();

    result.fold(
      (error) => emit(CategoryError(message: error.toString())),
      (categories) => emit(CategoryLoaded(categories: categories)),
    );
  }
}
