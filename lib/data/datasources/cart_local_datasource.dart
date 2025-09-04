import 'package:hive/hive.dart';
import '../../core/constants/app_constants.dart';
import '../../core/error/exceptions.dart';
import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> addToCart(CartItemModel item);
  Future<void> removeFromCart(int productId);
  Future<void> updateCartItem(CartItemModel item);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  @override
  Future<List<CartItemModel>> getCartItems() async {
    try {
      final box = await Hive.openBox<CartItemModel>(AppConstants.cartBoxName);
      return box.values.toList();
    } catch (e) {
      throw CacheException('Failed to get cart items: $e');
    }
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    try {
      final box = await Hive.openBox<CartItemModel>(AppConstants.cartBoxName);

      // Check if item already exists
      final existingItem = box.values.firstWhere(
        (cartItem) => cartItem.product.id == item.product.id,
        orElse: () => CartItemModel(product: item.product, quantity: 0),
      );

      if (existingItem.quantity > 0) {
        // Update existing item
        final updatedItem = existingItem.copyWith(
          quantity: existingItem.quantity + item.quantity,
        );
        await box.put(item.product.id, updatedItem);
      } else {
        // Add new item
        await box.put(item.product.id, item);
      }
    } catch (e) {
      throw CacheException('Failed to add item to cart: $e');
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    try {
      final box = await Hive.openBox<CartItemModel>(AppConstants.cartBoxName);
      await box.delete(productId);
    } catch (e) {
      throw CacheException('Failed to remove item from cart: $e');
    }
  }

  @override
  Future<void> updateCartItem(CartItemModel item) async {
    try {
      final box = await Hive.openBox<CartItemModel>(AppConstants.cartBoxName);
      if (item.quantity <= 0) {
        await box.delete(item.product.id);
      } else {
        await box.put(item.product.id, item);
      }
    } catch (e) {
      throw CacheException('Failed to update cart item: $e');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      final box = await Hive.openBox<CartItemModel>(AppConstants.cartBoxName);
      await box.clear();
    } catch (e) {
      throw CacheException('Failed to clear cart: $e');
    }
  }
}
