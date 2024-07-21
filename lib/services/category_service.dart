
import 'package:book_store_mobile/model/category_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryService {
  final Dio _dio = Dio();
  static final String _baseUrl = dotenv.env["BASE_URL"] ?? "";

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await _dio.get('$_baseUrl/${_CategoryServicePath.categories.name}');
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

enum _CategoryServicePath{
  categories
}