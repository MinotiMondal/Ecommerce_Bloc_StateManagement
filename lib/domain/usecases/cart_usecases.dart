import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class GetCartItems {
  final CartRepository repository;

  GetCartItems(this.repository);

  Future<Either<Failure, List<CartItem>>> call() async {
    return await repository.getCartItems();
  }
}

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<Either<Failure, void>> call(CartItem item) async {
    return await repository.addToCart(item);
  }
}

class RemoveFromCart {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  Future<Either<Failure, void>> call(int productId) async {
    return await repository.removeFromCart(productId);
  }
}

class UpdateCartItem {
  final CartRepository repository;

  UpdateCartItem(this.repository);

  Future<Either<Failure, void>> call(CartItem item) async {
    return await repository.updateCartItem(item);
  }
}

class ClearCart {
  final CartRepository repository;

  ClearCart(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.clearCart();
  }
}
