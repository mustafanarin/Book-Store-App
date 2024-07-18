// import 'package:book_store_mobile/product/color/project_colors.dart';
// import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
// import 'package:book_store_mobile/product/extensions/image_path_extension.dart';
// import 'package:book_store_mobile/product/widgets/large_text.dart';
// import 'package:book_store_mobile/product/widgets/textfield_search.dart';
// import 'package:book_store_mobile/services/product_service.dart';
// import 'package:book_store_mobile/view/category_page.dart';
// import 'package:book_store_mobile/view/den/den.dart';
// import 'package:book_store_mobile/view_model/Image_upload.dart';
// import 'package:book_store_mobile/view_model/catalog_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CatalogPage extends StatefulWidget {
//   const CatalogPage({super.key});

//   @override
//   State<CatalogPage> createState() => _CatalogPageState();
// }

// class _CatalogPageState extends State<CatalogPage> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       initialIndex: 0,
//       length: 5,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           actions:  [Padding(
//             padding: EdgeInsets.only(right: context.dynamicWidht(0.05)),
//             child: const largeText(text: "Catalog"),
//           )],
//           toolbarHeight: context.dynamicHeight(0.10),
//           leading: Padding(
//             padding: context.paddingAllLow1,
//             child: Image.asset(ImageName.app_logo.path(),fit: BoxFit.contain,),
//           ),
//           elevation: 0,
//           bottom: TabBar(
//             mouseCursor: MouseCursor.defer,
//             indicatorPadding: const EdgeInsets.only(top: 5,bottom: 5),
//             isScrollable: true,
//             tabs:   const [
//               _Tab(text: "All",),
//               _Tab(text: "Best Seller"),
//               _Tab(text: "Classics"),
//               _Tab(text: "Children"),
//               _Tab(text: "Philosphy")
//             ],
//             splashBorderRadius: BorderRadius.zero,
//             splashFactory: NoSplash.splashFactory,
//              tabAlignment: TabAlignment.start,
//                   physics: const ClampingScrollPhysics(),
//                   padding: const EdgeInsets.all(10),
//             indicator: BoxDecoration(
//               borderRadius: BorderRadius.circular(4),
//               color: ProjectColors.majoreBlue,
//             ),
//             labelColor: ProjectColors.maWhite,
//             unselectedLabelColor: ProjectColors.grey,
//             labelStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
//           ),
//         ),
//         body: const TabBarView(
//           children: <Widget>[
//           TabbarPage(color: Colors.white,),
//           TabbarPage(color: Colors.amber,),
//           TabbarPage(color: Colors.red,),
//           TabbarPage(color: Colors.amber,),
//           TabbarPage(color: Colors.red,)
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _Tab extends StatelessWidget {
//   const _Tab({
//     super.key, required this.text,
//   });
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: context.paddingColumnHorizontalLow2,
//       child: Tab(text: text ,),
//     );
//   }
// }

// class TabbarPage extends StatefulWidget {
//   const TabbarPage({super.key, required this.color});
//   final Color color;
//   @override
//   State<TabbarPage> createState() => _TabbarPageState();
// }

// class _TabbarPageState extends State<TabbarPage> {
//   final TextEditingController _tfSearchController = TextEditingController();
//   late final ProductService servis;
//   @override
//   void initState() {
//     super.initState();
//     servis = ProductService();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CatalogViewModel>(
//         builder: (context, categoryViewModel, child) {
//           if (categoryViewModel.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             return Padding( //aaa
//               padding: context.paddingAllLow2,
//               child: Column(
//                 children: [
//                   TextFieldSearch(tfSearchController: _tfSearchController),
//                   Expanded(
//                     child: ListView.builder(
                      
//                       itemCount: categoryViewModel.categories.length,
//                       itemBuilder: (context, index) {
//                         final category = categoryViewModel.categories[index];
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             largeText(text: category.name ?? ""),
                            
//                             SizedBox(
//                               height: 200,
//                               child: Consumer<CatalogViewModel>(//
//                                 builder:(context, productValue, child) {
//                                   final products = productValue.getProductsForCategory(category.id ?? 1);
//                                   return ListView.builder(
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: 3,
//                                     itemBuilder:(context, index) {
//                                       return GestureDetector(
//                                         onTap: () {
//                                           Navigator.push(context, MaterialPageRoute(builder: (context) =>  CategoryPage(categoryModel: category,productModel:products ,)));
//                                         },
//                                         child: Card(
//                                           margin: const EdgeInsets.all(8),
//                                           child: SizedBox(
//                                             width: 250                                  ,
//                                             child: Row(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 FutureBuilder<String>(
//                                               future: servis.getCoverImageUrl(products[index].cover ?? "1984.png"),
//                                               builder: (context, snapshot) {
//                                                 if (snapshot.connectionState == ConnectionState.waiting) {
//                                                  return const CircularProgressIndicator();
//                                                 } else if (snapshot.hasError) {
//                                                   return const Icon(Icons.error);
//                                                 } else {
//                                                   return Image.network(
//                                                     snapshot.data!,
//                                                     height: 120,
//                                                     width: 100,
//                                                     fit: BoxFit.cover,
//                                                   );
//                                                 }
//                                               },
//                                             ),
//                                                 Padding(
//                                                   padding: const EdgeInsets.all(8.0), //aaaaa
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       SizedBox(
//                                                         width: 120,
//                                                         child: Text(
//                                                           products[index].name ?? "",
//                                                           style: const TextStyle(fontWeight: FontWeight.bold),
//                                                           maxLines: 2,
//                                                           overflow: TextOverflow.ellipsis,
//                                                           softWrap: true,
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 120,
//                                                         child: Text(products[index].author ?? "")),
//                                                       Text(
//                                                         "${products[index].price ?? 0.00}",
//                                                         style: const TextStyle(color: Colors.green),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 },
//                               ),
//                             )
                    
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       );
//   }
// }





import 'package:auto_route/auto_route.dart';
import 'package:book_store_mobile/product/navigator/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:book_store_mobile/product/extensions/image_path_extension.dart';
import 'package:book_store_mobile/product/widgets/large_text.dart';
import 'package:book_store_mobile/product/widgets/textfield_search.dart';
import 'package:book_store_mobile/services/product_service.dart';
import 'package:book_store_mobile/view_model/catalog_view_model.dart';

@RoutePage()
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
          actions: [
            Padding(
              padding: EdgeInsets.only(right: context.dynamicWidht(0.05)),
              child: const largeText(text: "Catalog"),
            )
          ],
          toolbarHeight: context.dynamicHeight(0.10),
          leading: Padding(
            padding: context.paddingAllLow1,
            child: Image.asset(ImageName.app_logo.path(), fit: BoxFit.contain,),
          ),
          elevation: 0,
          bottom: TabBar(
            mouseCursor: MouseCursor.defer,
            indicatorPadding: const EdgeInsets.only(top: 5, bottom: 5),
            isScrollable: true,
            tabs: const [
              _Tab(text: "All",),
              _Tab(text: "Best Seller"),
              _Tab(text: "Classics"),
              _Tab(text: "Children"),
              _Tab(text: "Philosophy")
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
            labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            TabbarPage(id: 4),
            TabbarPage(id: 0,),
            TabbarPage(id: 1,),
            TabbarPage(id: 2,),
            TabbarPage(id: 3,)
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingColumnHorizontalLow2,
      child: Tab(text: text,),
    );
  }
}

class TabbarPage extends StatefulWidget {
  const TabbarPage({super.key, required this.id});
  final int id;

  @override
  State<TabbarPage> createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  final TextEditingController _tfSearchController = TextEditingController();
  late final ProductService servis;

  @override
  void initState() {
    super.initState();
    servis = ProductService();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CatalogViewModel>(
      builder: (context, catalogViewModel, child) {
        if (catalogViewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: context.paddingAllLow2,
            child: Column(
              children: [
                TextFieldSearch(
                  tfSearchController: _tfSearchController,
                  onChanged: catalogViewModel.filterByCategory),
                
                Expanded(
                  child: widget.id == 4 ? _AllCategoriesList(catalogViewModel: catalogViewModel, servis: servis,categoryId: null,) :
                  _AllCategoriesList(servis: servis, catalogViewModel: catalogViewModel, categoryId: widget.id,)
                  ,
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
    super.key,
    required this.servis, required this.catalogViewModel, this.categoryId,
  });

  final ProductService servis;
  final CatalogViewModel catalogViewModel;
  final int? categoryId;

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
          largeText(text: category.name ?? ""),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, productIndex) {
                final product = products[productIndex];
                return GestureDetector(
                  onTap:() => AutoRouter.of(context).push(CategoryRoute(categoryModel: category)),
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 250,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<String>(
                            future: servis.getCoverImageUrl(product.cover ?? "1984.png"),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    product.name ?? "",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Text(product.author ?? "")
                                ),
                                Text(
                                  "${product.price ?? 0.00}",
                                  style: const TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ],
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


