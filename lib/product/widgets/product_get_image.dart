import 'package:book_store_mobile/model/product_model.dart';
import 'package:book_store_mobile/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductGetImage extends StatelessWidget {
  const ProductGetImage({
    super.key,
    required this.servis,
    this.product, required this.imageHeight, required this.imageWidht, required this.forOnlyProduct, this.onlyProduct,
  });

  final ProductService servis;
  final ProductModel? product;
  final double imageHeight;
  final double imageWidht;
  final bool forOnlyProduct;
  final Map<String, dynamic>? onlyProduct;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: servis.getCoverImageUrl(forOnlyProduct ? (onlyProduct?['cover'] ?? "dune.png") : (product?.cover ?? "1984.png") ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: imageHeight,
            width: imageWidht,
            child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else {
          return Image.network(
            snapshot.data!,
             height: imageHeight,
            width: imageWidht,
            fit: BoxFit.contain,
          );
        }
      },
    );
  }
}