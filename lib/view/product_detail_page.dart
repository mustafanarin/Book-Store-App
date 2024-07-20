import 'package:auto_route/auto_route.dart';
import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:book_store_mobile/product/widgets/elevated_button.dart';
import 'package:book_store_mobile/product/widgets/large_text.dart';
import 'package:book_store_mobile/product/widgets/medium_text.dart';
import 'package:book_store_mobile/product/widgets/product_get_image.dart';
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
  final String _appBarTitle = 'Book Details';
  final String _descriptionTitle = "Summary";
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
        actions: [
              Padding(
                padding: EdgeInsets.only(right: context.dynamicWidht(0.05)),
                child: LargeText(text: _appBarTitle),
              )
            ],
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
      return LayoutBuilder(
        builder: (context,constraints){
          return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: context.paddingAllLow2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                ProductGetImage(servis: servis, imageHeight: context.dynamicHeight(0.3), imageWidht: context.dynamicWidht(0.5), forOnlyProduct: true,onlyProduct: product,),
                                LargeText(text: product['name'] ?? ""),
                                const SizedBox(height: 8),
                                MediumText(text: '${product['author']}', color: ProjectColors.grey)
                              ],
                            ),
                          ),
                          LargeText(text: _descriptionTitle),
                          SizedBox(height: context.lowValue1),
                          _DescriptionText(product: product),
                          // DEĞİŞİKLİK: Spacer eklendi
                          Spacer(),
                          SizedBox(height: context.highValue),
                          ElevatedButtonProject(text: 'Buy Now: ${product['price']} \$', onPressed: (){}),
                          SizedBox(height: context.mediumValue,)
                        ],
                      ),
                    ),
                  ),
                ),
              );
        }
      );
    },
        )
    );
  }
}


class _DescriptionText extends StatelessWidget {
  const _DescriptionText({
    super.key,
    required this.product,
  });

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Text(
    product['description'],
         style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300),
        );
  }
}

