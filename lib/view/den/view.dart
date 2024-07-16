import 'package:book_store_mobile/model/category_model.dart';
import 'package:book_store_mobile/model/product_model.dart';
import 'package:book_store_mobile/view/den/den.dart';
import 'package:flutter/material.dart';


class CategoryRow extends StatelessWidget {
  final CategoryModel category;
  final List<ProductModel> products;

  const CategoryRow({Key? key, required this.category, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(category.name ?? "", style: Theme.of(context).textTheme.bodyLarge),
            TextButton(
              onPressed: () {
                // TODO: Implement view all functionality
              },
              child: Text('View All'),
            ),
          ],
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<String>(
            future: ApiService().getCoverImageUrl(product.cover ?? ""),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Icon(Icons.error);
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
                Text(product.name ?? "", style: Theme.of(context).textTheme.bodyLarge),
                Text(product.author ?? "", style: Theme.of(context).textTheme.bodyMedium),
                Text('\$${product.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Store'),
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: apiService.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                CategoryModel category = snapshot.data![index];
                return FutureBuilder<List<ProductModel>>(
                  future: apiService.getProducts(category.id ?? 1),
                  builder: (context, productSnapshot) {
                    if (productSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (productSnapshot.hasError) {
                      return Center(child: Text('Error: ${productSnapshot.error}'));
                    } else {
                      return CategoryRow(
                        category: category,
                        products: productSnapshot.data!,
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}