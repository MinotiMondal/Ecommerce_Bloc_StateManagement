import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/error/failures.dart';
import '../../../domain/usecases/get_product.dart';
import '../../../domain/usecases/get_products.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final GetProduct getProduct;

  ProductBloc({required this.getProducts, required this.getProduct})
    : super(ProductInitial()) {
    on<GetProductsEvent>(_onGetProducts);
    on<GetProductEvent>(_onGetProduct);
    on<RefreshProductsEvent>(_onRefreshProducts);
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await getProducts();
    result.fold(
      (failure) => emit(ProductError(_mapFailureToMessage(failure))),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _onGetProduct(
    GetProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await getProduct(event.productId);
    result.fold(
      (failure) => emit(ProductError(_mapFailureToMessage(failure))),
      (product) => emit(ProductLoaded(product)),
    );
  }

  Future<void> _onRefreshProducts(
    RefreshProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    // Don't emit loading for refresh to avoid UI flicker
    final result = await getProducts();
    result.fold(
      (failure) => emit(ProductError(_mapFailureToMessage(failure))),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  String _mapFailureToMessage(failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred. Please try again.';
      case NetworkFailure:
        return 'Please check your internet connection.';
      case CacheFailure:
        return 'No cached data available.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
