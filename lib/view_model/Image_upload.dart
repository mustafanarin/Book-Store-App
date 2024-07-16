import 'package:book_store_mobile/services/product_service.dart';
import 'package:flutter/foundation.dart';


class ImageViewModel extends ChangeNotifier {
  final ProductService _imageService = ProductService();
  String? _imageUrl;
  bool _isLoading = false;

  String? get imageUrl => _imageUrl;
  bool get isLoading => _isLoading;

  Future<void> loadImage(String fileName) async {
    

    try {
      bool _isLoading = true;
      notifyListeners();
      _imageUrl = await _imageService.getCoverImageUrl(fileName);
    } catch (e) {
      print(e);
    } finally {
      bool _isLoading = false;
      notifyListeners();
    }
  }
}