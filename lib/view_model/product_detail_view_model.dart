import 'package:book_store_mobile/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();
  Map<String, dynamic>? _product;
  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? get product => _product;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProductDetails(int categoryId, int productId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _product = await _productService.fetchProductDetails(categoryId, productId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}