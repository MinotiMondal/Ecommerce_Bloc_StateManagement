import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await client
          .get(
            Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}',
            ),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(ApiConstants.receiveTimeout);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          'Failed to fetch products: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final response = await client
          .get(
            Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}/$id',
            ),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(ApiConstants.receiveTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return ProductModel.fromJson(json);
      } else {
        throw ServerException(
          'Failed to fetch product: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Network error: $e');
    }
  }
}
