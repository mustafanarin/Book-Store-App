// import 'package:book_store_mobile/model/category_model.dart';
// import 'package:book_store_mobile/model/product_model.dart';
// import 'package:book_store_mobile/services/product_service.dart';
// import 'package:flutter/material.dart';

// class CategoryViewModel extends ChangeNotifier{
//   final CategoryModel categoryModel;
//   final ProductService _productService = ProductService();
//   bool loading = false;
//   List<ProductModel> products = [];

//   CategoryViewModel({required this.categoryModel}){
//     _fetchCategory(categoryModel);
//   }

//   Future<void> _fetchCategory(CategoryModel model) async {
//     loading = !loading;
//     notifyListeners();
//     products = await _productService.fetchProductsByCategory(model.id ?? 1);
//     loading = !loading;
//     notifyListeners();
//   }

  
// }

import 'package:book_store_mobile/model/category_model.dart';
import 'package:book_store_mobile/model/product_model.dart';
import 'package:book_store_mobile/services/product_service.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryModel categoryModel;
  final ProductService _productService = ProductService();
  bool loading = false;
  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];

  List<ProductModel> get products => _filteredProducts;

  CategoryViewModel({required this.categoryModel}) {
    _fetchCategory(categoryModel);
  }

  Future<void> _fetchCategory(CategoryModel model) async {
    loading = true;
    notifyListeners();
    _allProducts = await _productService.fetchProductsByCategory(model.id ?? 1);
    _filteredProducts = List.from(_allProducts);
    loading = false;
    notifyListeners();
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = List.from(_allProducts);
    } else {
      _filteredProducts = _allProducts.where((product) =>
        product.name?.toLowerCase().contains(query.toLowerCase()) ?? false
      ).toList();
    }
    notifyListeners();
  }
}