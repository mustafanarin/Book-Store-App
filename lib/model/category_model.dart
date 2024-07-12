class CategoryModel {
  final int? id;
  final String? name;
  final String? createdAt;

  CategoryModel({required this.id, required this.name, required this.createdAt});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
    );
  }
}