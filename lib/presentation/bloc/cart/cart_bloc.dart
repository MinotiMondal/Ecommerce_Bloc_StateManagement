import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/cart_item.dart';
import '../../../domain/usecases/cart_usecases.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItems getCartItems;
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final UpdateCartItem updateCartItem;
  final ClearCart clearCart;

  CartBloc({
    required this.getCartItems,
    required this.addToCart,
    required this.removeFromCart,
    required this.updateCartItem,
    required this.clearCart,
  }) : super(CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartItemEvent>(_onUpdateCartItem);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());

    final result = await getCartItems();
    result.fold(
      (failure) => emit(CartError(_mapFailureToMessage(failure))),
      (items) => emit(_buildCartLoaded(items)),
    );
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final cartItem = CartItem(product: event.product, quantity: event.quantity);

    final result = await addToCart(cartItem);
    result.fold((failure) => emit(CartError(_mapFailureToMessage(failure))), (
      _,
    ) {
      emit(CartItemAdded('${event.product.title} added to cart'));
      add(LoadCartEvent()); // Reload cart to show updated state
    });
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await removeFromCart(event.productId);
    result.fold(
      (failure) => emit(CartError(_mapFailureToMessage(failure))),
      (_) => add(LoadCartEvent()), // Reload cart
    );
  }

  Future<void> _onUpdateCartItem(
    UpdateCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await updateCartItem(event.cartItem);
    result.fold(
      (failure) => emit(CartError(_mapFailureToMessage(failure))),
      (_) => add(LoadCartEvent()), // Reload cart
    );
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await clearCart();
    result.fold(
      (failure) => emit(CartError(_mapFailureToMessage(failure))),
      (_) => add(LoadCartEvent()), // Reload cart
    );
  }

  CartLoaded _buildCartLoaded(List<CartItem> items) {
    final totalAmount = items.fold<double>(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );

    final totalItems = items.fold<int>(0, (sum, item) => sum + item.quantity);

    return CartLoaded(
      items: items,
      totalAmount: totalAmount,
      totalItems: totalItems,
    );
  }

  String _mapFailureToMessage(failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return 'Failed to access cart data.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
