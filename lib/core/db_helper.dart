import 'package:marketoo/models/app_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'marketoo.db');
    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, imagePath TEXT)''',
        );
        await db.execute(
          '''CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT, categoryId INTEGER, name TEXT, image TEXT, price REAL, description TEXT, FOREIGN KEY (categoryId) REFERENCES categories (id) ON DELETE CASCADE)''',
        );
        await db.execute(
          '''CREATE TABLE cart(productId INTEGER PRIMARY KEY, quantity INTEGER, FOREIGN KEY (productId) REFERENCES products (id) ON DELETE CASCADE)''',
        );
      },
    );
  }

  // --- دوال الأقسام ---
  Future<int> insertCategory(CategoryModel category) async {
    final db = await database;
    return await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CategoryModel>> fetchCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return List.generate(maps.length, (i) => CategoryModel.fromMap(maps[i]));
  }

  Future<int> deleteCategory(int id) async {
    final db = await database;
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  // --- دوال المنتجات ---
  Future<int> insertProduct(ProductModel product) async {
    final db = await database;
    return await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProductModel>> fetchProductsByCategory(int categoryId) async {
    final db = await database;
    final maps = await db.query(
      'products',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );
    return List.generate(maps.length, (i) => ProductModel.fromMap(maps[i]));
  }

  // الدالة دي كانت ناقصة ومسببة إيرور في CategoryProvider
  Future<int> deleteProduct(int productId) async {
    final db = await database;
    return await db.delete('products', where: 'id = ?', whereArgs: [productId]);
  }

  // --- دوال السلة (المهمة جداً للـ CartProvider) ---
  Future<void> insertOrUpdateCart(int productId, int quantity) async {
    final db = await database;
    await db.insert('cart', {
      'productId': productId,
      'quantity': quantity,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> fetchCartItems() async {
    final db = await database;
    return await db.rawQuery(
      'SELECT products.*, cart.quantity FROM cart JOIN products ON cart.productId = products.id',
    );
  }

  Future<void> deleteFromCart(int productId) async {
    final db = await database;
    await db.delete('cart', where: 'productId = ?', whereArgs: [productId]);
  }

  // داخل كلاس DatabaseHelper في ملف db_helper.dart
  Future<int> updateProduct(ProductModel product) async {
    final db = await database;
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }
  Future<int> updateCategory(CategoryModel category) async {
    final db = await database;
    return await db.update('categories', category.toMap(), where: 'id = ?', whereArgs: [category.id]);
  }
  // دالة تفريغ السلة بالكامل بعد الدفع
  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart'); // هيمسح كل الـ Rows اللي في الجدول بدون ما يمسح الجدول نفسه
  }
}
