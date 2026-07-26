import 'dart:convert';
import 'package:http/http.dart' as http;
import '../errors/app_errors.dart';
import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/products'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data
            .map((item) => Product.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(response.statusCode);
      }
    } on http.ClientException {
      throw const NetworkException();
    } on FormatException {
      throw const ParseException();
    } catch (e) {
      if (e is AppException) rethrow;
      throw const UnexpectedException();
    }
  }
}
