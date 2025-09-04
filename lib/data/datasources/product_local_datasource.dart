import 'package:hive/hive.dart';
import '../../core/constants/app_constants.dart';
import '../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
  Future<ProductModel> getCachedProduct(int id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<List<ProductModel>> getCachedProducts() async {
    try {
      final box = await Hive.openBox<ProductModel>(
        AppConstants.productsBoxName,
      );
      return box.values.toList();
    } catch (e) {
      throw CacheException('Failed to get cached products: $e');
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    try {
      final box = await Hive.openBox<ProductModel>(
        AppConstants.productsBoxName,
      );
      await box.clear();
      for (int i = 0; i < products.length; i++) {
        await box.put(products[i].id, products[i]);
      }
    } catch (e) {
      throw CacheException('Failed to cache products: $e');
    }
  }

  @override
  Future<ProductModel> getCachedProduct(int id) async {
    try {
      final box = await Hive.openBox<ProductModel>(
        AppConstants.productsBoxName,
      );
      final product = box.get(id);
      if (product != null) {
        return product;
      } else {
        throw CacheException('Product not found in cache');
      }
    } catch (e) {
      throw CacheException('Failed to get cached product: $e');
    }
  }
}
