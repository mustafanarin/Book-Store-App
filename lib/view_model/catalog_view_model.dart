import 'package:book_store_mobile/model/category_model.dart';
import 'package:book_store_mobile/model/product_model.dart';
import 'package:book_store_mobile/services/category_service.dart';
import 'package:book_store_mobile/services/product_service.dart';
import 'package:flutter/material.dart';

class CatalogViewModel extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  List<Map<int, List<ProductModel>>> _productsByCategory = [];
  List<Map<int, List<ProductModel>>> _filteredProductsByCategory = [];

  String? imageUrl;
  bool isLoading = false;
  int selectedIndex = 0;
  int customTabBarIndex = 0;

  CatalogViewModel() {
   categoryFetch();
  }

  void _changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> categoryFetch() async {
    try {
      _changeLoading();
      _categories = await _categoryService.fetchCategories();
      await fetchProductsByCategory(1);
      _changeLoading();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchProductsByCategory(int categoryId) async {
    _changeLoading();
    List<Map<int, List<ProductModel>>> productsByCategories = [];

    try {
      if (_categories.isNotEmpty) {
        for (var category in _categories) {
          final list = await _productService.fetchProductsByCategory(category.id);
          productsByCategories.add({category.id ?? 0: list});
        }
        _productsByCategory = productsByCategories;
        _filteredProductsByCategory = List.from(_productsByCategory);
      }
    } catch (e) {
      print(e.toString());
    }
    _changeLoading();
  }


  void filterByCategory(String query) {
    if (query.isEmpty) {
      _filteredProductsByCategory = List.from(_productsByCategory);
    } else {
      _filteredProductsByCategory = _productsByCategory.map((categoryProducts) {
        int categoryId = categoryProducts.keys.first;
        List<ProductModel> products = categoryProducts.values.first;
        
        List<ProductModel> filteredProducts = products.where((product) =>
          (product.name ?? "").toLowerCase().contains(query.toLowerCase())
        ).toList();
        return {categoryId: filteredProducts};
      }).toList();
    }
    notifyListeners();
  }

  List<ProductModel> getProductsForCategory(int categoryId) {
    return _filteredProductsByCategory
        .firstWhere((element) => element.keys.first == categoryId, 
                    orElse: () => {categoryId: []}).values.first;
  }

  void changeIndex(int index){
    selectedIndex = index;
    notifyListeners();
  }
  void changeCustomTabbarIndex(int index){
    customTabBarIndex = index;
    notifyListeners();
  }
}

