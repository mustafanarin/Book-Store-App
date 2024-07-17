import 'package:book_store_mobile/model/category_model.dart';
import 'package:book_store_mobile/model/product_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  static const String baseUrl = 'https://assign-api.piton.com.tr/api/rest';

  ApiService() {
    _dio.options.baseUrl = baseUrl;
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get('/categories');
      List<dynamic> data = response.data['category'];
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<List<ProductModel>> getProducts(int categoryId) async {
    try {
      final response = await _dio.get('/products/$categoryId');
      List<dynamic> data = response.data['product'];
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<String> getCoverImageUrl(String fileName) async {
    try {
      final response = await _dio.post(
        '/cover_image',
        data: {'fileName': fileName},
      );
      return response.data['action_product_image']['url'];
    } catch (e) {
      throw Exception('Failed to load image URL: $e');
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      List<ProductModel> allProducts = [];
      List<CategoryModel> categories = await getCategories();
      
      for (var category in categories) {
        List<ProductModel> products = await getProducts(category.id ?? 1);
        allProducts.addAll(products);
      }
      
      return allProducts;
    } catch (e) {
      throw Exception('Failed to load all products: $e');
    }
  }
}