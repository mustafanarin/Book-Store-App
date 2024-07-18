
import 'package:book_store_mobile/product/navigator/app_router.dart';
import 'package:book_store_mobile/product/theme/light_theme.dart';
import 'package:book_store_mobile/view_model/catalog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CatalogViewModel()),
        //ChangeNotifierProvider(create: (_) => ImageViewModel()),
      //  ChangeNotifierProvider(create: (_) => ImageDen())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Book Store App',
        theme: LightTheme().theme,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
