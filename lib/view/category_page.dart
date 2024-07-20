import 'package:auto_route/auto_route.dart';
import 'package:book_store_mobile/model/category_model.dart';
import 'package:book_store_mobile/model/product_model.dart';
import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:book_store_mobile/product/widgets/large_text.dart';
import 'package:book_store_mobile/product/widgets/product_get_image.dart';
import 'package:book_store_mobile/product/widgets/textfield_search.dart';
import 'package:book_store_mobile/services/product_service.dart';
import 'package:book_store_mobile/view/product_detail_page.dart';
import 'package:book_store_mobile/view_model/category_view_model.dart';
import 'package:book_store_mobile/view_model/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key, required this.categoryModel}) : super(key: key);
  final CategoryModel categoryModel;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController _tfSearchController = TextEditingController();
  late final ProductService productService;

  @override
  void initState() {
    super.initState();
    productService = ProductService();
  }
  @override
  void dispose() {
    super.dispose();
    _tfSearchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryViewModel>(
      create: (context) => CategoryViewModel(categoryModel: widget.categoryModel),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.only(right: context.dynamicWidht(0.05)),
                child: LargeText(text: widget.categoryModel.name ?? ""),
              )
            ],
          ),
          body: context.watch<CategoryViewModel>().loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: context.paddingColumnHorizontalLow2,
                  child: Column(
                    children: [
                      _TextFieldSearch(tfSearchController: _tfSearchController),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                          ),
                          itemCount: context.watch<CategoryViewModel>().products.length,
                          itemBuilder: (context, index) {
                            final product = context.watch<CategoryViewModel>().products[index];
                            return GestureDetector(
                              onTap: () {
                                AutoRouter.of(context).pushNativeRoute(
                                  MaterialPageRoute(
                                    builder: (context) => ChangeNotifierProvider(
                                      create: (_) => ProductDetailViewModel(),
                                      child: ProductDetailPage(
                                        productId: product.id ?? 1,
                                        categoryId: widget.categoryModel.id ?? 1,
                                      ),
                                    ),
                                  )
                                );
                              },
                              child: Card(
                                color: ProjectColors.maWhite,
                                child: Padding(
                                  padding: context.paddingAllLow1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ProductGetImage(servis: productService, imageHeight: context.dynamicHeight(0.25), imageWidht: context.dynamicWidht(0.40), forOnlyProduct: false,product: product,),
                                      SizedBox(height: context.lowValue1),
                                      _ProductNameText(product: product),
                                      Row(
                                        children: [
                                          _ProductAuthorText(product: product),
                                          const Spacer(),
                                          _ProductPriceText(product: product)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _TextFieldSearch extends StatelessWidget {
  const _TextFieldSearch({
    super.key,
    required TextEditingController tfSearchController,
  }) : _tfSearchController = tfSearchController;

  final TextEditingController _tfSearchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.lowValue2),
      child:TextFieldSearch(
        tfSearchController: _tfSearchController,
        onChanged: (value) {
          context.read<CategoryViewModel>().filterProducts(value);
        },)
    );
  }
}


class _ProductNameText extends StatelessWidget {
  const _ProductNameText({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        product.name ?? "",
        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _ProductAuthorText extends StatelessWidget {
  const _ProductAuthorText({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidht(0.25),
      child: Text(
        product.author ?? "",
        style: const TextStyle(fontSize: 10),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        softWrap: true,
      ),
    );
  }
}

class _ProductPriceText extends StatelessWidget {
  const _ProductPriceText({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${product.price ?? ""} \$",
      style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w700,color: ProjectColors.majoreBlue),
    );
  }
}