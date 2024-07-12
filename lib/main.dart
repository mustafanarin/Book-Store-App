

import 'package:book_store_mobile/product/theme/light_theme.dart';
import 'package:book_store_mobile/services/deneme.dart';
import 'package:book_store_mobile/view/catalog_page.dart';
import 'package:book_store_mobile/view/login_page.dart';
import 'package:book_store_mobile/view_model/catalog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CatalogViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book Store App',
        theme: LightTheme().theme,
        home:  const CatalogPage()
      ),
    );
  }
}
