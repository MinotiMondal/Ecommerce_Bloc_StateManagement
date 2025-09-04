import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mini_ecommerce_app/core/error/failures.dart';
import 'package:mini_ecommerce_app/domain/entities/cart_item.dart';
import 'package:mini_ecommerce_app/domain/entities/product.dart';
import 'package:mini_ecommerce_app/domain/usecases/cart_usecases.dart';
import 'package:mini_ecommerce_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:mini_ecommerce_app/presentation/bloc/cart/cart_event.dart';
import 'package:mini_ecommerce_app/presentation/bloc/cart/cart_state.dart';

class MockGetCartItems extends Mock implements GetCartItems {}

class MockAddToCart extends Mock implements AddToCart {}

class MockRemoveFromCart extends Mock implements RemoveFromCart {}

class MockUpdateCartItem extends Mock implements UpdateCartItem {}

class MockClearCart extends Mock implements ClearCart {}

void main() {
  late CartBloc bloc;
  late MockGetCartItems mockGetCartItems;
  late MockAddToCart mockAddToCart;
  late MockRemoveFromCart mockRemoveFromCart;
  late MockUpdateCartItem mockUpdateCartItem;
  late MockClearCart mockClearCart;

  setUp(() {
    mockGetCartItems = MockGetCartItems();
    mockAddToCart = MockAddToCart();
    mockRemoveFromCart = MockRemoveFromCart();
    mockUpdateCartItem = MockUpdateCartItem();
    mockClearCart = MockClearCart();

    bloc = CartBloc(
      getCartItems: mockGetCartItems,
      addToCart: mockAddToCart,
      removeFromCart: mockRemoveFromCart,
      updateCartItem: mockUpdateCartItem,
      clearCart: mockClearCart,
    );
  });

  tearDown(() {
    bloc.close();
  });

  const tProduct = Product(
    id: 1,
    title: 'Test Product',
    price: 29.99,
    description: 'Test description',
    category: 'electronics',
    image: 'https://test.com/image.jpg',
    rating: Rating(rate: 4.5, count: 100),
  );

  const tCartItem = CartItem(product: tProduct, quantity: 2);

  final tCartItems = [tCartItem];

  setUpAll(() {
    registerFallbackValue(tCartItem);
  });

  test('initial state should be CartInitial', () {
    expect(bloc.state, CartInitial());
  });

  group('LoadCartEvent', () {
    blocTest<CartBloc, CartState>(
      'emits [CartLoading, CartLoaded] when LoadCartEvent is successful',
      build: () {
        when(
          () => mockGetCartItems(),
        ).thenAnswer((_) async => Right(tCartItems));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadCartEvent()),
      expect: () => [
        CartLoading(),
        const CartLoaded(
          items: tCartItems,
          totalAmount: 59.98, // 29.99 * 2
          totalItems: 2,
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoading, CartError] when LoadCartEvent fails',
      build: () {
        when(
          () => mockGetCartItems(),
        ).thenAnswer((_) async => const Left(CacheFailure('Cache error')));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadCartEvent()),
      expect: () => [
        CartLoading(),
        const CartError('Failed to access cart data.'),
      ],
    );
  });

  group('AddToCartEvent', () {
    blocTest<CartBloc, CartState>(
      'emits [CartItemAdded] and triggers LoadCartEvent when AddToCartEvent is successful',
      build: () {
        when(
          () => mockAddToCart(any()),
        ).thenAnswer((_) async => const Right(null));
        when(
          () => mockGetCartItems(),
        ).thenAnswer((_) async => Right(tCartItems));
        return bloc;
      },
      act: (bloc) => bloc.add(const AddToCartEvent(tProduct, quantity: 2)),
      expect: () => [
        const CartItemAdded('Test Product added to cart'),
        CartLoading(),
        const CartLoaded(items: tCartItems, totalAmount: 59.98, totalItems: 2),
      ],
    );
  });

  group('Price calculation', () {
    test('should calculate total amount correctly', () {
      const cartItems = [
        CartItem(
          product: Product(
            id: 1,
            title: 'Product 1',
            price: 10.0,
            description: 'Description 1',
            category: 'category1',
            image: 'image1.jpg',
            rating: Rating(rate: 4.0, count: 10),
          ),
          quantity: 2,
        ),
        CartItem(
          product: Product(
            id: 2,
            title: 'Product 2',
            price: 15.0,
            description: 'Description 2',
            category: 'category2',
            image: 'image2.jpg',
            rating: Rating(rate: 4.5, count: 20),
          ),
          quantity: 3,
        ),
      ];

      final totalAmount = cartItems.fold<double>(
        0.0,
        (sum, item) => sum + item.totalPrice,
      );

      expect(totalAmount, 65.0); // (10.0 * 2) + (15.0 * 3) = 20 + 45 = 65
    });

    test('should calculate total items correctly', () {
      const cartItems = [
        CartItem(
          product: Product(
            id: 1,
            title: 'Product 1',
            price: 10.0,
            description: 'Description 1',
            category: 'category1',
            image: 'image1.jpg',
            rating: Rating(rate: 4.0, count: 10),
          ),
          quantity: 2,
        ),
        CartItem(
          product: Product(
            id: 2,
            title: 'Product 2',
            price: 15.0,
            description: 'Description 2',
            category: 'category2',
            image: 'image2.jpg',
            rating: Rating(rate: 4.5, count: 20),
          ),
          quantity: 3,
        ),
      ];

      final totalItems = cartItems.fold<int>(
        0,
        (sum, item) => sum + item.quantity,
      );

      expect(totalItems, 5); // 2 + 3 = 5
    });
  });
}
