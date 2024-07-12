
import 'package:book_store_mobile/model/category_model.dart';
import 'package:dio/dio.dart';

class CategoryService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://assign-api.piton.com.tr/api/rest';

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await _dio.get('$_baseUrl/categories');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['category'];
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception('Kategoriler yüklenemedi. Hata kodu: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }
}