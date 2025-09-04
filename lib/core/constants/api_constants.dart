class ApiConstants {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String productsEndpoint = '/products';
  
  // Timeout durations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
