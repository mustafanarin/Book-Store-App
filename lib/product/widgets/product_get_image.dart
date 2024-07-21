import 'package:book_store_mobile/model/product_model.dart';
import 'package:book_store_mobile/services/product_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// class ProductGetImage extends StatelessWidget {
//   const ProductGetImage({
//     super.key,
//     required this.servis,
//     this.product, required this.imageHeight, required this.imageWidht, required this.forOnlyProduct, this.onlyProduct,
//   });

//   final ProductService servis;
//   final ProductModel? product;
//   final double imageHeight;
//   final double imageWidht;
//   final bool forOnlyProduct;
//   final Map<String, dynamic>? onlyProduct;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String>(
//       future: servis.getCoverImageUrl(forOnlyProduct ? (onlyProduct?['cover'] ?? "dune.png") : (product?.cover ?? "1984.png") ),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return SizedBox(
//             height: imageHeight,
//             width: imageWidht,
//             child: Center(child: CircularProgressIndicator()));
//         } else if (snapshot.hasError) {
//           return const Icon(Icons.error);
//         } else {
//           return Image.network(
//             snapshot.data!,
//              height: imageHeight,
//             width: imageWidht,
//             fit: BoxFit.contain,
//           );
//         }
//       },
//     );
//   }
// }

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
            child: const Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else {
          return CachedNetworkImage(
            imageUrl: snapshot.data!,
            width: imageWidht,
            height: imageHeight,
            fit: BoxFit.contain,
            fadeInDuration: const Duration(seconds: 0),
            cacheManager: CacheManager(Config("images",stalePeriod: const Duration(days: 7))),
            );
        }
      },
    );
  }
}
