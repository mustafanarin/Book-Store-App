import 'package:book_store_mobile/model/category_model.dart';
import 'package:book_store_mobile/model/product_model.dart';
import 'package:book_store_mobile/services/category_service.dart';
import 'package:book_store_mobile/services/product_service.dart';
import 'package:flutter/material.dart';

class CatalogViewModel extends ChangeNotifier{
  final CategoryService _categoryService = CategoryService();
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  List<ProductModel> products = [];
  final ProductService _productService = ProductService();
  List<Map<int, List<ProductModel>>> _productsByCategory = [];
  List<ProductModel> getProductsForCategory(int categoryId) => _productsByCategory.firstWhere((element) => element.keys.first == categoryId).values.first;

  bool isLoading = false;

  CatalogViewModel(){
    categoryFetch();
  }
  void _changeLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }
 late final int id;
  

  Future<void> categoryFetch() async{
    try{
     _changeLoading();
    _categories = await _categoryService.fetchCategories();
   fetchProductsByCategory(1); 
    
    _changeLoading(); 
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> fetchProductsByCategory(int categoryId) async {
     _changeLoading();

    List<Map<int, List<ProductModel>>> productsByCategories = [];

    try {

      if(_categories.isNotEmpty){
        for(var i = 0; i<_categories.length; i++){
          final list = await _productService.fetchProductsByCategory(_categories[i].id);

          final data = {_categories[i].id ?? 0: list};

          productsByCategories.add(data);
        }

        _productsByCategory = productsByCategories;
      }


      // final products = await _productService.fetchProductsByCategory(categoryId);
      // _productsByCategory[categoryId] = products;
      // id =  products[categoryId].id ?? 1;
    } catch (e) {
      print(e.toString());
    }
     _changeLoading();

  }

}
