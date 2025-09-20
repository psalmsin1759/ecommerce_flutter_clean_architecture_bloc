import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/features/cart/domain/usecases/add_to_cart_use_case.dart';
import 'package:julybyoma_app/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:julybyoma_app/features/cart/domain/usecases/get_cart_use_case.dart';
import 'package:julybyoma_app/features/cart/domain/usecases/remove_from_cart_use_case.dart';
import 'package:julybyoma_app/features/cart/domain/usecases/update_quantity_use_case.dart';
import 'package:julybyoma_app/features/cart/presentation/bloc/cart_event.dart';
import 'package:julybyoma_app/features/cart/presentation/bloc/cart_state.dart';
import 'package:julybyoma_app/injection.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCart = getIt<GetCartUseCase>();
  final AddToCartUseCase addToCart = getIt<AddToCartUseCase>();
  final RemoveFromCartUseCase removeFromCart = getIt<RemoveFromCartUseCase>();
  final UpdateQuantityUseCase updateQuantity = getIt<UpdateQuantityUseCase>();
  final ClearCartUseCase clearCart = getIt<ClearCartUseCase>();

  CartBloc() : super(CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartQuantityEvent>(_onUpdateQuantity);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final result = await getCart();
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (items) => emit(CartLoaded(items)),
    );
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await addToCart(param: AddToCartParams(event.item));

    await result.fold(
      (failure) async {
        emit(CartError(failure.message));
      },
      (_) async {
        final refreshed = await getCart();
        refreshed.fold(
          (failure) => emit(CartError(failure.message)),
          (items) => emit(CartLoaded(items)),
        );
      },
    );
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await removeFromCart(
      param: RemoveFromCartParams(event.productId),
    );

    await result.fold(
      (failure) async {
        emit(CartError(failure.message));
      },
      (_) async {
        final refreshed = await getCart();
        refreshed.fold(
          (failure) => emit(CartError(failure.message)),
          (items) => emit(CartLoaded(items)),
        );
      },
    );
  }

  Future<void> _onUpdateQuantity(
    UpdateCartQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await updateQuantity(
      param: UpdateQuantityParams(event.productId, event.quantity),
    );
    result.fold((failure) => emit(CartError(failure.message)), (_) async {
      final refreshed = await getCart();
      refreshed.fold(
        (failure) => emit(CartError(failure.message)),
        (items) => emit(CartLoaded(items)),
      );
    });
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await clearCart();
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (_) => emit(CartLoaded([])),
    );
  }
}
