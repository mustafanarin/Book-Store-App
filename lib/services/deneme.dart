// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';

// // Services
// class CategoryService {
//   final Dio _dio = Dio();
//   final String _baseUrl = 'https://assign-api.piton.com.tr/api/rest';

//   Future<List<dynamic>> fetchCategories() async {
//     try {
//       final response = await _dio.get('$_baseUrl/categories');
//       if (response.statusCode == 200) {
//         return response.data['category'] as List<dynamic>;
//       } else {
//         throw Exception('Kategoriler yüklenemedi. Hata kodu: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Bir hata oluştu: $e');
//     }
//   }
// }

// class ProductService {
//   final Dio _dio = Dio();
//   final String _baseUrl = 'https://assign-api.piton.com.tr/api/rest';

//   Future<List<dynamic>> fetchProductsByCategory(int categoryId) async {
//     try {
//       final response = await _dio.get('$_baseUrl/products/$categoryId');
//       if (response.statusCode == 200) {
//         return response.data['product'] as List<dynamic>;
//       } else {
//         throw Exception('Ürünler yüklenemedi. Hata kodu: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Bir hata oluştu: $e');
//     }
//   }
// }

// // Widgets
// class BookStorePage extends StatelessWidget {
//   final CategoryService categoryService = CategoryService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Kitap Mağazası'),
//       ),
//       body: FutureBuilder<List<dynamic>>(
//         future: categoryService.fetchCategories(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Hata: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final category = snapshot.data![index];
//                 return CategorySection(category: category);
//               },
//             );
//           } else {
//             return Center(child: Text('Veri bulunamadı'));
//           }
//         },
//       ),
//     );
//   }
// }

// class CategorySection extends StatelessWidget {
//   final dynamic category;
//   final ProductService productService = ProductService();

//   CategorySection({required this.category});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             category['name'],
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         SizedBox(
//           height: 150,
//           child: FutureBuilder<List<dynamic>>(
//             future: productService.fetchProductsByCategory(category['id']),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Hata: ${snapshot.error}'));
//               } else if (snapshot.hasData) {
//                 return ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 3,
//                   itemBuilder: (context, index) {
//                     final product = snapshot.data![index];
//                     return BookCard(product: product);
//                   },
//                 );
//               } else {
//                 return Center(child: Text('Ürün bulunamadı'));
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class BookCard extends StatelessWidget {
//   final dynamic product;

//   BookCard({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8),
//       child: Container(
        
//         width: 210,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset(
//               'images/logo/book.png',
//               height: 80,
//               width: 70,
//               fit: BoxFit.contain,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0), //aaaaa
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: 120,
//                     child: Text(
//                       product['name'],
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       softWrap: true,
//                     ),
//                   ),
//                   Container(
//                     width: 120,
//                     child: Text('${product['author']}')),
//                   Text(
//                     '${product['price']} TL',
//                     style: TextStyle(color: Colors.green),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
