import 'package:auto_route/auto_route.dart';
import 'package:book_store_mobile/product/widgets/elevated_button.dart';
import 'package:book_store_mobile/product/widgets/large_text.dart';
import 'package:book_store_mobile/services/product_service.dart';
import 'package:book_store_mobile/view_model/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProductDetailPage extends StatefulWidget {
  final int categoryId;
  final int productId;

  const ProductDetailPage({
    super.key, 
    required this.categoryId, 
    required this.productId
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  late final ProductService servis;
   @override
  void initState() {
    super.initState();
    servis = ProductService();
    Future.microtask(() => context.read<ProductDetailViewModel>().fetchProductDetails(widget.categoryId, widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: Consumer<ProductDetailViewModel>(
    builder: (context, viewModel, child) {
      if (viewModel.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (viewModel.error != null) {
        return Center(child: Text('Error: ${viewModel.error}'));
      } else if (viewModel.product == null) {
        return const Center(child: Text('No data available'));
      }
    
      final product = viewModel.product!;
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Center(
                 child: Column(
                   children: [
                     FutureBuilder<String>(
                         future: servis.getCoverImageUrl(product['cover'] ?? "1984.png"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                           return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                            return const Icon(Icons.error);
                            } else {
                            return Image.network(
                              snapshot.data!,
                              height: 120,
                              width: 100,
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      ),
                     largeText(text: product['name']),
                     const SizedBox(height: 8),
                     Text('${product['author']}'),
                   ],
                 ),
               ),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              const largeText(text: "Summary"),
              const SizedBox(height: 8),
              Text(product['description']),
              const SizedBox(height: 10,),
              ElevatedButtonProject(text: 'Buy Now: \$${product['price']}', onPressed: (){})
            ],
          ),
      );
    },
        )
    );
  }
}

