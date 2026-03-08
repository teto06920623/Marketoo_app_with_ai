// lib/models/app_models.dart

class ProductModel {
  int? id;
  int? categoryId;
  final String name;
  final String image;
  final double price;
  final String description;

  ProductModel({
    this.id,
    this.categoryId,
    required this.name,
    required this.image,
    required this.price,
    this.description = "Fresh and delicious meal",
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'image': image,
      'price': price,
      'description': description,
    };
    if (id != null) map['id'] = id;
    if (categoryId != null) map['categoryId'] = categoryId;
    return map;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      categoryId: map['categoryId'],
      name: map['name'],
      image: map['image'],
      price: map['price'],
      description: map['description'],
    );
  }
}

class CategoryModel {
  int? id;
  final String title;
  final String imagePath;
  final List<ProductModel> products;

  CategoryModel({
    this.id,
    required this.title,
    required this.imagePath,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{'title': title, 'imagePath': imagePath};
    if (id != null) map['id'] = id;
    return map;
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      title: map['title'],
      imagePath: map['imagePath'],
      products: [],
    );
  }
}

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

// لستة البيانات الافتراضية (appCategories) اللي كانت عاملة إيرور
List<CategoryModel> appCategories = [
  // ... حط هنا كل الأقسام والمنتجات اللي كانت عندك في الموديل القديم ...
];
