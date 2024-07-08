import 'package:book_store_mobile/product/theme/light_theme.dart';
import 'package:book_store_mobile/view/login_page.dart';
import 'package:book_store_mobile/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store App',
      theme: LightTheme().theme,
      home: const LoginPage()
    );
  }
}
