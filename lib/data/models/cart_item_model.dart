import 'package:hive/hive.dart';
import '../../domain/entities/cart_item.dart';
import 'product_model.dart';

// part 'cart_item_model.g.dart'; // Uncomment after running build_runner

@HiveType(typeId: 2)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final ProductModel product;

  @HiveField(1)
  final int quantity;

  CartItemModel({required this.product, required this.quantity});

  CartItem toEntity() {
    return CartItem(product: product.toEntity(), quantity: quantity);
  }

  factory CartItemModel.fromEntity(CartItem cartItem) {
    return CartItemModel(
      product: ProductModel.fromEntity(cartItem.product),
      quantity: cartItem.quantity,
    );
  }

  CartItemModel copyWith({ProductModel? product, int? quantity}) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
