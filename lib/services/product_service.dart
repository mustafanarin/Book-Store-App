import 'package:book_store_mobile/model/product_model.dart';
import 'package:dio/dio.dart';

class ProductService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://assign-api.piton.com.tr/api/rest';

  Future<List<ProductModel>> fetchProductsByCategory(int? categoryId) async {
    try {
      final response = await _dio.get('$_baseUrl/products/$categoryId');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['product'];
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Ürünler yüklenemedi. Hata kodu: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }
}