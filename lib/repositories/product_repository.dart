// repositories/product_repository.dart

import '../models/product.dart';
import '../services/api_service.dart';


class ProductRepository {
  final ApiService _apiService;

  ProductRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<List<Product>> getProducts() {
    return _apiService.fetchProducts();
  }
}
