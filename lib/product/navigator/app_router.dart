import 'package:auto_route/auto_route.dart';
import 'package:book_store_mobile/model/category_model.dart';
import 'package:book_store_mobile/view/catalog_page.dart';
import 'package:book_store_mobile/view/category_page.dart';
import 'package:book_store_mobile/view/login_page.dart';
import 'package:book_store_mobile/view/product_detail_page.dart';
import 'package:book_store_mobile/view/register_page.dart';
import 'package:book_store_mobile/view/splash_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page,initial: true),
    AutoRoute(page: LoginRoute.page,),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: CatalogRoute.page),
    AutoRoute(page: CategoryRoute.page),
    AutoRoute(page: ProductDetailRoute.page)
  ];

  
}