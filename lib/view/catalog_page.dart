import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:book_store_mobile/product/extensions/image_path_extension.dart';
import 'package:book_store_mobile/product/widgets/large_text.dart';
import 'package:book_store_mobile/view_model/catalog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions:  [Padding(
            padding: EdgeInsets.only(right: context.dynamicWidht(0.05)),
            child: const largeText(text: "Catalog"),
          )],
          toolbarHeight: context.dynamicHeight(0.10),
          leading: Padding(
            padding: context.paddingAllLow1,
            child: Image.asset(ImageName.app_logo.path(),fit: BoxFit.contain,),
          ),
          elevation: 0,
          bottom: TabBar(
            mouseCursor: MouseCursor.defer,
            indicatorPadding: const EdgeInsets.only(top: 5,bottom: 5),
            isScrollable: true,
            tabs:   const [
              _Tab(text: "All",),
              _Tab(text: "Best Seller"),
              _Tab(text: "Classics"),
              _Tab(text: "Children"),
              _Tab(text: "Philosphy")
            ],
            splashBorderRadius: BorderRadius.zero,
            splashFactory: NoSplash.splashFactory,
             tabAlignment: TabAlignment.start,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: ProjectColors.majoreBlue,
            ),
            labelColor: ProjectColors.maWhite,
            unselectedLabelColor: ProjectColors.grey,
            labelStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
          TabbarPage(color: Colors.white,),
          TabbarPage(color: Colors.amber,),
          TabbarPage(color: Colors.red,),
          TabbarPage(color: Colors.amber,),
          TabbarPage(color: Colors.red,)
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    super.key, required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingColumnHorizontalLow2,
      child: Tab(text: text ,),
    );
  }
}

class TabbarPage extends StatefulWidget {
  const TabbarPage({super.key, required this.color});
  final Color color;
  @override
  State<TabbarPage> createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<CatalogViewModel>(
        builder: (context, categoryViewModel, child) {
          if (categoryViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: categoryViewModel.categories.length,
              itemBuilder: (context, index) {
                final category = categoryViewModel.categories[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    largeText(text: category.name ?? ""),
                    SizedBox(
                      height: 200,
                      child: Consumer<CatalogViewModel>(
                        builder:(context, productValue, child) {
                          final products = productValue.getProductsForCategory(category.id ?? 1);

              
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder:(context, index) {
                              return Card(
                                margin: const EdgeInsets.all(8),
                                child: SizedBox(
                                  width: 210,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'images/logo/book.png',
                                        height: 80,
                                        width: 70,
                                        fit: BoxFit.contain,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0), //aaaaa
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 120,
                                              child: Text(
                                                products[index].name ?? "",
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 120,
                                              child: Text(products[index].author ?? "")),
                                            Text(
                                              "${products[index].price ?? 0.00}",
                                              style: const TextStyle(color: Colors.green),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )

                  ],
                );
              },
            );
          }
        },
      );
  }
}

