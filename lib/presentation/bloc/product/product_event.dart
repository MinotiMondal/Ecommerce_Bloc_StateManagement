import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends ProductEvent {}

class GetProductEvent extends ProductEvent {
  final int productId;

  const GetProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class RefreshProductsEvent extends ProductEvent {}
