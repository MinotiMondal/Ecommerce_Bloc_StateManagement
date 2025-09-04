import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mini_ecommerce_app/core/error/failures.dart';
import 'package:mini_ecommerce_app/domain/entities/product.dart';
import 'package:mini_ecommerce_app/domain/repositories/product_repository.dart';
import 'package:mini_ecommerce_app/domain/usecases/get_products.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProducts usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = GetProducts(mockProductRepository);
  });

  const tProducts = [
    Product(
      id: 1,
      title: 'Test Product 1',
      price: 29.99,
      description: 'Test description 1',
      category: 'electronics',
      image: 'https://test.com/image1.jpg',
      rating: Rating(rate: 4.5, count: 100),
    ),
    Product(
      id: 2,
      title: 'Test Product 2',
      price: 19.99,
      description: 'Test description 2',
      category: 'clothing',
      image: 'https://test.com/image2.jpg',
      rating: Rating(rate: 4.0, count: 50),
    ),
  ];

  test('should get products from the repository', () async {
    // arrange
    when(
      () => mockProductRepository.getProducts(),
    ).thenAnswer((_) async => const Right(tProducts));

    // act
    final result = await usecase();

    // assert
    expect(result, const Right(tProducts));
    verify(() => mockProductRepository.getProducts());
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return failure when repository fails', () async {
    // arrange
    const tFailure = ServerFailure('Server error');
    when(
      () => mockProductRepository.getProducts(),
    ).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase();

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockProductRepository.getProducts());
    verifyNoMoreInteractions(mockProductRepository);
  });
}

