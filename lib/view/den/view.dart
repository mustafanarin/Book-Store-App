import 'package:book_store_mobile/model/category_model.dart';
import 'package:book_store_mobile/model/product_model.dart';
import 'package:book_store_mobile/view/den/den.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final ApiService apiService = ApiService();
  late Future<List<CategoryModel>> categoriesFuture;
  late TabController _tabController;
  List<ProductModel> allProducts = [];
  List<ProductModel> displayedProducts = [];
  bool isSearching = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    categoriesFuture = apiService.getCategories();
    categoriesFuture.then((categories) {
      _tabController = TabController(length: categories.length + 1, vsync: this);
      _tabController.addListener(_handleTabSelection);
      _loadAllProducts();
    });
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      _filterProductsByCategory();
    }
  }

  Future<void> _loadAllProducts() async {
    List<CategoryModel> categories = await categoriesFuture;
    for (var category in categories) {
      List<ProductModel> products = await apiService.getProducts(category.id ?? 1);
      allProducts.addAll(products);
    }
    _filterProductsByCategory();
  }

  void _filterProductsByCategory() {
    setState(() {
      if (_tabController.index == 0) {
        displayedProducts = List.from(allProducts);
      } else {
        int categoryId = _tabController.index;
      //  displayedProducts = allProducts.where((product) => product.categoryId == categoryId).toList();
      }
      _applySearch();
    });
  }

  void _applySearch() {
    if (searchQuery.isNotEmpty) {
      displayedProducts = displayedProducts
          .where((product) =>
              product.name!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  void searchProducts(String query) {
    setState(() {
      searchQuery = query;
      isSearching = query.isNotEmpty;
      _filterProductsByCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<CategoryModel> categories = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Book Store'),
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  Tab(text: 'All'),
                  ...categories.map((category) => Tab(text: category.name)),
                ],
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for books...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: searchProducts,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildProductGrid(),
                      ...categories.map((_) => _buildProductGrid()),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildProductGrid() {
    if (displayedProducts.isEmpty) {
      return Center(child: Text('No products found'));
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: displayedProducts.length,
      itemBuilder: (context, index) {
        return ProductCard(product: displayedProducts[index]);
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<String>(
              future: ApiService().getCoverImageUrl(product.cover ?? ""),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Icon(Icons.error));
                } else {
                  return Image.network(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  product.author ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
            Text(category.name ?? "", style: Theme.of(context).textTheme.bodyMedium),
            TextButton(
              onPressed: () {
                // TODO: Implement view all functionality
              },
              child: Text('View All'),
            ),
          ],
        ),
        SizedBox(
          height: 200,
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