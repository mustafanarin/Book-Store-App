import 'package:book_store_mobile/model/category_model.dart';
import 'package:book_store_mobile/model/product_model.dart';
import 'package:book_store_mobile/services/product_service.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier{
  final CategoryModel categoryModel;
  final ProductService _productService = ProductService();
  bool loading = false;
  List<ProductModel> products = [];

  CategoryViewModel({required this.categoryModel}){
    _fetchCategory(categoryModel);
  }

  // void _isLoading(){
  //   loading = !loading;
  //   notifyListeners();
  // }

  Future<void> _fetchCategory(CategoryModel model) async {
    loading = !loading;
    notifyListeners();
    products = await _productService.fetchProductsByCategory(model.id ?? 1);
    loading = !loading;
    notifyListeners();
  }

  
}