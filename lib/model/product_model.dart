class ProductModel {
  final int? id;
  final String? name;
  final String? author;
  final String? cover;
  final double? price;

  ProductModel({
    required this.id,
    required this.name,
    required this.author,
    required this.cover,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      cover: json['cover'],
      price: json['price'].toDouble(),
    );
  }
}