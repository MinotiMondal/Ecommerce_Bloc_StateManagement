import 'package:equatable/equatable.dart';
import '../../../domain/entities/cart_item.dart';
import '../../../domain/entities/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final Product product;
  final int quantity;

  const AddToCartEvent(this.product, {this.quantity = 1});

  @override
  List<Object> get props => [product, quantity];
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;

  const RemoveFromCartEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class UpdateCartItemEvent extends CartEvent {
  final CartItem cartItem;

  const UpdateCartItemEvent(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

class ClearCartEvent extends CartEvent {}
