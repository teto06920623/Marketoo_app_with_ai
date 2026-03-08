import 'package:flutter/material.dart';
import 'package:marketoo/models/app_models.dart';
import 'package:marketoo/core/db_helper.dart'; // المسار الصحيح الجديد

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  CategoryProvider() {
    loadCategories();
  }

  Future<void> deleteCategory(int id) async {
    await _dbHelper.deleteCategory(id);
    _categories.removeWhere((category) => category.id == id);
    notifyListeners();
  }

  Future<void> loadCategories() async {
    final dbCategories = await _dbHelper.fetchCategories();

    if (dbCategories.isEmpty) {
      _categories = [];
      for (var cat in appCategories) {
        final generatedCatId = await _dbHelper.insertCategory(cat);
        cat.id = generatedCatId;

        List<ProductModel> savedProducts = [];
        for (var prod in cat.products) {
          prod.categoryId = generatedCatId;
          final prodId = await _dbHelper.insertProduct(prod);
          prod.id = prodId;
          savedProducts.add(prod);
        }
        cat.products.clear();
        cat.products.addAll(savedProducts);
        _categories.add(cat);
      }
    } else {
      for (var cat in dbCategories) {
        final catProducts = await _dbHelper.fetchProductsByCategory(cat.id!);
        cat.products.addAll(catProducts);
      }
      _categories = dbCategories;
    }
    notifyListeners();
  }

  Future<void> addProductToCategory(
    int categoryId,
    String name,
    String image,
    double price,
  ) async {
    final newProduct = ProductModel(
      categoryId: categoryId,
      name: name,
      image: image,
      price: price,
    );

    final generatedId = await _dbHelper.insertProduct(newProduct);
    newProduct.id = generatedId;

    final categoryIndex = _categories.indexWhere((c) => c.id == categoryId);
    if (categoryIndex != -1) {
      _categories[categoryIndex].products.add(newProduct);
      notifyListeners();
    }
  }

  // داخل كلاس CategoryProvider في ملف category_provider.dart
  Future<void> updateProduct(
    int categoryId,
    ProductModel updatedProduct,
  ) async {
    // 1. التعديل في الهارد (SQLite)
    await _dbHelper.updateProduct(updatedProduct);

    // 2. التعديل في الميموري (RAM)
    final categoryIndex = _categories.indexWhere((c) => c.id == categoryId);
    if (categoryIndex != -1) {
      final productIndex = _categories[categoryIndex].products.indexWhere(
        (p) => p.id == updatedProduct.id,
      );
      if (productIndex != -1) {
        _categories[categoryIndex].products[productIndex] = updatedProduct;
        notifyListeners(); // إشعار الشاشات بالتغيير
      }
    }
  }
Future<void> updateCategory(int id, String newTitle, String newImage) async {
    final categoryIndex = _categories.indexWhere((c) => c.id == id);
    if (categoryIndex != -1) {
      // بنعمل Object جديد وبنحافظ على المنتجات القديمة اللي جوه القسم
      final updatedCategory = CategoryModel(
        id: id,
        title: newTitle,
        imagePath: newImage,
        products: _categories[categoryIndex].products, 
      );
      
      await _dbHelper.updateCategory(updatedCategory); // تحديث الهارد
      _categories[categoryIndex] = updatedCategory; // تحديث الرامات
      notifyListeners();
    }
  }
  Future<void> deleteProduct(int categoryId, int productId) async {
    await _dbHelper.deleteProduct(productId);

    final categoryIndex = _categories.indexWhere((c) => c.id == categoryId);
    if (categoryIndex != -1) {
      _categories[categoryIndex].products.removeWhere((p) => p.id == productId);
      notifyListeners();
    }
  }

  Future<void> addCategory(String title, String imageUrl) async {
    final newCategory = CategoryModel(
      id: null,
      title: title,
      imagePath: imageUrl,
      products: [],
    );

    final generatedId = await _dbHelper.insertCategory(newCategory);
    newCategory.id = generatedId;

    _categories.add(newCategory);
    notifyListeners();
  }
}
