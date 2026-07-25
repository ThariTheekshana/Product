import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../errors/app_errors.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';

enum ViewState { loading, loaded, error }

const String _favouritesKey = 'favourite_product_ids';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository;

  ProductProvider({ProductRepository? repository})
      : _repository = repository ?? ProductRepository() {
    _loadFavourites();
    loadProducts();
  }

  ViewState _state = ViewState.loading;
  ViewState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<Product> _allProducts = [];
  String _searchQuery = '';

  final Set<int> _favouriteIds = {};

  List<Product> get products {
    if (_searchQuery.isEmpty) return _allProducts;
    final query = _searchQuery.toLowerCase();
    return _allProducts
        .where((p) => p.title.toLowerCase().contains(query))
        .toList();
  }

  String get searchQuery => _searchQuery;

  bool isFavourite(int productId) => _favouriteIds.contains(productId);

  List<Product> get favouriteProducts =>
      _allProducts.where((p) => _favouriteIds.contains(p.id)).toList();

  Future<void> loadProducts() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      _allProducts = await _repository.getProducts();
      _state = ViewState.loaded;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _state = ViewState.error;
    } catch (_) {
      _errorMessage = const UnexpectedException().message;
      _state = ViewState.error;
    }
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> toggleFavourite(int productId) async {
    if (_favouriteIds.contains(productId)) {
      _favouriteIds.remove(productId);
    } else {
      _favouriteIds.add(productId);
    }
    notifyListeners();
    await _saveFavourites();
  }

  Future<void> _loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_favouritesKey) ?? [];
    _favouriteIds
      ..clear()
      ..addAll(saved.map(int.tryParse).whereType<int>());
    notifyListeners();
  }

  Future<void> _saveFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _favouritesKey,
      _favouriteIds.map((id) => id.toString()).toList(),
    );
  }
}
