import 'package:auto_route/auto_route.dart';
import 'package:book_store_mobile/model/product_model.dart';
import 'package:book_store_mobile/product/extensions/assets/logo_path_extension.dart';
import 'package:book_store_mobile/product/extensions/assets/lottie_path_extension.dart';
import 'package:book_store_mobile/product/navigator/app_router.dart';
import 'package:book_store_mobile/product/widgets/product_get_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:book_store_mobile/product/widgets/large_text.dart';
import 'package:book_store_mobile/product/widgets/textfield_search.dart';
import 'package:book_store_mobile/services/product_service.dart';
import 'package:book_store_mobile/view_model/catalog_view_model.dart';

part '../product/part_of/part_custom_tabbar.dart';

@RoutePage()
class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final String _appBarName = "Catalog"; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectColors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: context.dynamicWidht(0.05)),
            child: LargeText(text: _appBarName),
          )
        ],
        leading: Padding(
          padding: context.paddingAllLow1,
          child: Image.asset(LogoName.app_logo.path(), fit: BoxFit.contain,),
        ),
        elevation: 0,
        
      ),
      body: Column(
        children: [
          _CustomTabBar(
            tabs: const ['All', 'Best Seller', 'Classics', 'Children', 'Philosophy'],
            onTabSelected: (index) {
              context.read<CatalogViewModel>().changeIndex(index);
            },
          ),
          Expanded(
            child: IndexedStack(
              index: context.watch<CatalogViewModel>().selectedIndex,
              children: const <Widget>[
                _TabbarPage(id: 4),
                _TabbarPage(id: 0),
                _TabbarPage(id: 1),
                _TabbarPage(id: 2),
                _TabbarPage(id: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _TabbarPage extends HookWidget {
  final int id;

  const _TabbarPage({ required this.id});

  @override
  Widget build(BuildContext context) {
    final tfSearchController = useTextEditingController();
    final servis = useState<ProductService?>(ProductService());

    useEffect(() {
      servis.value = ProductService();
      return () {};
    }, []);

    useEffect(() {
      return () => tfSearchController.dispose();
    }, [tfSearchController]);

    return Consumer<CatalogViewModel>(
      builder: (context, catalogViewModel, child) {
        if (catalogViewModel.isLoading) {
          return Center(child: Lottie.asset(LottieItems.book_loading.lottiePath));
        } else {
          return Padding(
            padding: context.paddingColumnHorizontalLow2,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: context.lowValue2),
                  child: TextFieldSearch(
                    tfSearchController: tfSearchController,
                    onChanged: catalogViewModel.filterByCategory,
                  ),
                ),
                Expanded(
                  child: _AllCategoriesList(
                    servis: servis.value!,
                    catalogViewModel: catalogViewModel,
                    categoryId: id == 4 ? null : id,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
class _AllCategoriesList extends StatelessWidget {
  const _AllCategoriesList({
    required this.servis, required this.catalogViewModel, this.categoryId,
  });

  final ProductService servis;
  final CatalogViewModel catalogViewModel;
  final int? categoryId;
  final String _viewAllButton = "View All";
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
    itemCount: categoryId == null ? catalogViewModel.categories.length : 1,
    itemBuilder: (context, index) {
      final category = categoryId == null ? catalogViewModel.categories[index] : catalogViewModel.categories[categoryId!];
      final products = catalogViewModel.getProductsForCategory(category.id ?? 1);
      
      if (products.isEmpty) {
        return const SizedBox.shrink(); 
      }
    
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.lowValue2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LargeText(text: category.name ?? ""),
              TextButton(onPressed: () =>  context.pushRoute(CategoryRoute(categoryModel: category)),
              child: Text(_viewAllButton,style: context.textTheme().bodySmall?.copyWith(color: ProjectColors.entanRed,fontWeight: FontWeight.w700),))
            ],
          ),
          SizedBox(height: context.lowValue1,),
          SizedBox(
            height: context.dynamicHeight(0.2),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, productIndex) {
                final product = products[productIndex];
                return GestureDetector(
                  onTap:() => context.pushRoute(CategoryRoute(categoryModel: category)),
                  child: Card(
                    child: Padding(
                      padding:  EdgeInsets.all(context.lowValue1),
                      child: SizedBox(
                        width: context.dynamicWidht(0.5),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProductGetImage(servis: servis, imageHeight: context.dynamicHeight(0.20), imageWidht: context.dynamicWidht(0.25), forOnlyProduct: false,product: product,),
                              Padding(
                                padding: EdgeInsets.all(context.lowValue1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _ProductNameText(product: product),
                                    _ProductAutherText(product: product),
                                    const Spacer(),
                                    _ProductPriceText(product: product),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      );
    },
   );
  }
}


class _ProductNameText extends StatelessWidget {
  const _ProductNameText({
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidht(0.2),
      child: Text(
        product.name ?? "",
        style: Theme.of(context).textTheme.labelLarge,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
    );
  }
}

class _ProductAutherText extends StatelessWidget {
  const _ProductAutherText({
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidht(0.2),
      child: Text(product.author ?? "",style: Theme.of(context).textTheme.labelMedium)
    );
  }
}

class _ProductPriceText extends StatelessWidget {
  const _ProductPriceText({
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${product.price ?? 0.00} \$",
      style: context.textTheme().bodyLarge?.copyWith(color: ProjectColors.majoreBlue,fontWeight: FontWeight.w700));
  }
}


