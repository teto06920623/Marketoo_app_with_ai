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

List<CategoryModel> appCategories = [
  CategoryModel(
    id: 1,
    title: "Fast Food",
    imagePath: "assets/images/fastfood.png",
    products: [
      ProductModel(
        id: 1,
        categoryId: 1,
        name: "Margherita Pizza",
        image:
            "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500&q=80",
        price: 12.99,
        description: "Classic pizza with fresh tomatoes and mozzarella",
      ),
      ProductModel(
        id: 2,
        categoryId: 1,
        name: "Beef Burger",
        image:
            "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&q=80",
        price: 9.99,
        description: "Juicy beef patty with cheese and fresh lettuce",
      ),
      ProductModel(
        id: 3,
        categoryId: 1,
        name: "French Fries",
        image:
            "https://images.unsplash.com/photo-1576107232684-1279f390859f?w=500&q=80",
        price: 3.99,
        description: "Crispy golden french fries with salt",
      ),
      ProductModel(
        id: 4,
        categoryId: 1,
        name: "Hot Dog",
        image:
            "https://images.unsplash.com/photo-1590165482156-f564162e05bc?w=500&q=80",
        price: 5.49,
        description: "Classic hot dog with mustard and ketchup",
      ),
      ProductModel(
        id: 5,
        categoryId: 1,
        name: "Fried Chicken",
        image:
            "https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=500&q=80",
        price: 14.99,
        description: "Crunchy deep-fried chicken pieces",
      ),
    ],
  ),

  CategoryModel(
    id: 2,
    title: "Seafood",
    imagePath: "assets/images/fish.png",
    products: [
      ProductModel(
        id: 6,
        categoryId: 2,
        name: "Grilled Salmon",
        image:
            "https://images.unsplash.com/photo-1485921325833-c519f76c4927?w=500&q=80",
        price: 18.99,
        description: "Fresh grilled salmon served with lemon",
      ),
      ProductModel(
        id: 7,
        categoryId: 2,
        name: "Fried Shrimp",
        image:
            "https://images.unsplash.com/photo-1625937711947-0e3fc9d2ba88?w=500&q=80",
        price: 15.50,
        description: "Crispy butterfly shrimp with dipping sauce",
      ),
      ProductModel(
        id: 8,
        categoryId: 2,
        name: "Lobster Tail",
        image:
            "https://images.unsplash.com/photo-1559742811-822873691df8?w=500&q=80",
        price: 29.99,
        description: "Premium butter-poached lobster tail",
      ),
      ProductModel(
        id: 9,
        categoryId: 2,
        name: "Fried Calamari",
        image:
            "https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=500&q=80",
        price: 11.99,
        description: "Golden fried calamari rings",
      ),
      ProductModel(
        id: 10,
        categoryId: 2,
        name: "Fish Tacos",
        image:
            "https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=500&q=80",
        price: 10.99,
        description: "Spicy fish tacos with fresh salsa",
      ),
    ],
  ),

  CategoryModel(
    id: 3,
    title: "Fruit",
    imagePath: "assets/images/fruit.png",
    products: [
      ProductModel(
        id: 11,
        categoryId: 3,
        name: "Fresh Apples",
        image:
            "https://images.unsplash.com/photo-1560806887-1e4cd0b6faa6?w=500&q=80",
        price: 4.99,
        description: "Sweet and crunchy red apples",
      ),
      ProductModel(
        id: 12,
        categoryId: 3,
        name: "Bananas",
        image:
            "https://images.unsplash.com/photo-1571501679680-de32f1e7aad4?w=500&q=80",
        price: 2.99,
        description: "Fresh yellow bananas bundle",
      ),
      ProductModel(
        id: 13,
        categoryId: 3,
        name: "Strawberries",
        image:
            "https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=500&q=80",
        price: 5.99,
        description: "Juicy and sweet fresh strawberries",
      ),
      ProductModel(
        id: 14,
        categoryId: 3,
        name: "Oranges",
        image:
            "https://images.unsplash.com/photo-1549888834-3ec93abae044?w=500&q=80",
        price: 3.49,
        description: "Vitamin C rich fresh oranges",
      ),
      ProductModel(
        id: 15,
        categoryId: 3,
        name: "Watermelon",
        image:
            "https://images.unsplash.com/photo-1589984662646-e7b2e4962f18?w=500&q=80",
        price: 6.99,
        description: "Sliced refreshing summer watermelon",
      ),
    ],
  ),

  CategoryModel(
    id: 4,
    title: "Rice",
    imagePath: "assets/images/rice.png",
    products: [
      ProductModel(
        id: 16,
        categoryId: 4,
        name: "Chicken Biryani",
        image:
            "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=500&q=80",
        price: 14.99,
        description: "Traditional spicy rice with marinated chicken",
      ),
      ProductModel(
        id: 17,
        categoryId: 4,
        name: "Fried Rice",
        image:
            "https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=500&q=80",
        price: 8.99,
        description: "Asian style egg and vegetable fried rice",
      ),
      ProductModel(
        id: 18,
        categoryId: 4,
        name: "Sushi Rice Bowl",
        image:
            "https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=500&q=80",
        price: 12.50,
        description: "Sticky sushi rice served with fresh sides",
      ),
      ProductModel(
        id: 19,
        categoryId: 4,
        name: "Mushroom Risotto",
        image:
            "https://images.unsplash.com/photo-1633337474563-9ee82c4491de?w=500&q=80",
        price: 16.00,
        description: "Creamy Italian rice with mushrooms",
      ),
      ProductModel(
        id: 20,
        categoryId: 4,
        name: "Basmati Rice",
        image:
            "https://images.unsplash.com/photo-1536304929831-ee1ca9d44906?w=500&q=80",
        price: 5.99,
        description: "Plain steamed long-grain basmati rice",
      ),
    ],
  ),
];
