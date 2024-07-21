import 'package:book_store_mobile/model/category_model.dart';
import 'package:book_store_mobile/model/product_model.dart';
import 'package:book_store_mobile/services/category_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductService {
  final Dio _dio = Dio();
  static final String _baseUrl = dotenv.env["BASE_URL"] ?? "";
  final CategoryService _categoryService = CategoryService();

  Future<List<ProductModel>> fetchProductsByCategory(int? categoryId) async {
    try {
      final response = await _dio.get('$_baseUrl/${_ProductServicePath.products.name}/$categoryId');
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

  Future<Map<String, dynamic>> fetchProductDetails(int categoryId, int productId) async {
    try {
      final response = await _dio.get('$_baseUrl/${_ProductServicePath.products.name}/$categoryId');
      if (response.statusCode == 200) {
        final List<dynamic> products = response.data['product'];
        final product = products.firstWhere(
          (product) => product['id'] == productId,
          orElse: () => throw Exception('Product not found'),
        );
        return product;
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      throw Exception('Error fetching product details: $e');
    }
  }



 Future<String> getCoverImageUrl(String fileName) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/${_ProductServicePath.cover_image.name}',
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
      List<CategoryModel> categories = await _categoryService.fetchCategories();
      
      for (var category in categories) {
        List<ProductModel> products = await fetchProductsByCategory(category.id);
        allProducts.addAll(products);
      }
      
      return allProducts;
    } catch (e) {
      throw Exception('Failed to load all products: $e');
    }
  }
}

enum _ProductServicePath{
  products,
  cover_image
}