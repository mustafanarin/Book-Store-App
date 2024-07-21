import 'package:book_store_mobile/model/product_model.dart';
import 'package:book_store_mobile/product/extensions/assets/image_path_extension.dart';
import 'package:book_store_mobile/services/product_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  static final String _cacheKey = dotenv.env["CACHE_KEY"] ?? "";

  static final customCacheManager = CacheManager(
    Config(
      _cacheKey,
      stalePeriod: const Duration(days: 7),
      repo: JsonCacheInfoRepository(databaseName: _DatabaseName.bookImagesCache.name),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: servis.getCoverImageUrl(
        forOnlyProduct ? (onlyProduct?['cover'] ?? "dune.png") : (product?.cover ?? "1984.png")
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Image.asset(
              ImageName.placeholder_image.path(),
              width: imageWidht,
              height: imageHeight,
              fit: BoxFit.contain,
            );
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else {
          return CachedNetworkImage(
            imageUrl: snapshot.data!,
            width: imageWidht,
            height: imageHeight,
            fit: BoxFit.contain,
            fadeInDuration: const Duration(milliseconds: 300),
            cacheManager: customCacheManager,
            placeholder: (context, url) => Image.asset(
              ImageName.placeholder_image.path(),
              width: imageWidht,
              height: imageHeight,
              fit: BoxFit.contain,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
        }
      },
    );
  }
}

enum _DatabaseName{
  bookImagesCache
}
