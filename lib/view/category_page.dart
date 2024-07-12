import 'package:book_store_mobile/model/category_model.dart';
import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:book_store_mobile/product/widgets/large_text.dart';
import 'package:book_store_mobile/product/widgets/textfield_search.dart';
import 'package:book_store_mobile/view/image_denem.dart';
import 'package:book_store_mobile/view_model/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.categoryModel, });
  final CategoryModel categoryModel;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController _tfSearchController = TextEditingController();
  List<String> deneme = ["ankara","adana","izmir","istanbul"];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryViewModel>(
      create: (context) => CategoryViewModel(categoryModel: widget.categoryModel),
      builder: (context,child){
        return Scaffold(
        appBar: AppBar(
          actions: [Padding(
              padding: EdgeInsets.only(right: context.dynamicWidht(0.05)),
              child:  largeText(text: widget.categoryModel.name ?? "asd"),
            )],
        ),
        body: context.watch<CategoryViewModel>().loading ? const Center(child: CircularProgressIndicator()) :  Padding(
          padding: context.paddingColumnHorizontalLow2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: TextFieldSearch(tfSearchController: _tfSearchController),
              ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2/3 ), 
                  itemCount: context.watch<CategoryViewModel>().products.length,
                itemBuilder: (context,index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ImageDenem()));
                    },
                    child: Card(
                      color: ProjectColors.maWhite,
                      child: Padding(
                        padding: context.paddingAllLow1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'images/logo/book.png',
                                height: 150,
                                width: 150,
                                fit: BoxFit.contain
                              ),
                              Text(context.watch<CategoryViewModel>().products[index].author ?? "",style:  TextStyle(fontWeight: FontWeight.bold),),
                              Row(
                                children: [
                                  SizedBox(
                                    width: context.dynamicWidht(0.3),
                                    child: Text(context.watch<CategoryViewModel>().products[index].author ?? "",style: TextStyle(fontSize: 11),overflow: TextOverflow.ellipsis,maxLines: 2,softWrap: true,)),
                                  Spacer(),
                                  Text("${context.watch<CategoryViewModel>().products[index].price}" ?? "",style: TextStyle(fontSize: 15),)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            )
            ],
          ),
        ),
      );
      }
    );
  }
}