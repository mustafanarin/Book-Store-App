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


Future<String> getCoverImageUrl(String fileName) async {
  final dio = Dio();
  final url = 'https://assign-api.piton.com.tr/api/rest/cover_image';

  try {
    final response = await dio.post(
      url,
      data: {'fileName': fileName},
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 200) {
      return response.data['action_product_image']['url'];
    } else {
      throw Exception('Failed to load cover image URL');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
}