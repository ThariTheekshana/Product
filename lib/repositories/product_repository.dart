import '../models/product.dart';
import '../services/api_service.dart';

/// Repository is a light pass-through today, but keeps the ViewModel
/// (provider) decoupled from where product data actually comes from.
/// If a caching layer or a second data source is added later, only
/// this file needs to change.
class ProductRepository {
  final ApiService _apiService;

  ProductRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<List<Product>> getProducts() {
    return _apiService.fetchProducts();
  }
}
