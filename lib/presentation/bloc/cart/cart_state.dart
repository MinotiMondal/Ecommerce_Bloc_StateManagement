import 'package:equatable/equatable.dart';
import '../../../domain/entities/cart_item.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final double totalAmount;
  final int totalItems;

  const CartLoaded({
    required this.items,
    required this.totalAmount,
    required this.totalItems,
  });

  @override
  List<Object> get props => [items, totalAmount, totalItems];

  CartLoaded copyWith({
    List<CartItem>? items,
    double? totalAmount,
    int? totalItems,
  }) {
    return CartLoaded(
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      totalItems: totalItems ?? this.totalItems,
    );
  }
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}

class CartItemAdded extends CartState {
  final String message;

  const CartItemAdded(this.message);

  @override
  List<Object> get props => [message];
}
