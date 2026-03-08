import 'package:flutter/material.dart';
import 'package:marketoo/models/app_models.dart';
import 'package:marketoo/core/db_helper.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];
  List<CartItem> get items => _items;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  CartProvider() {
    loadCart(); // أول ما الأبلكيشن يفتح، يسحب الداتا من الهارد
  }

  // 1. استرجاع السلة من الداتا بيز (Synchronization Startup)
  Future<void> loadCart() async {
    final data = await _dbHelper.fetchCartItems();
    _items = data.map((map) {
      return CartItem(
        product: ProductModel.fromMap(map),
        quantity: map['quantity'] as int,
      );
    }).toList();
    notifyListeners();
  }

  // 2. إضافة منتج (Insert or Update logic)
  Future<void> addToCart(ProductModel product) async {
    if (product.id == null) return;

    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
      await _dbHelper.insertOrUpdateCart(product.id!, _items[existingIndex].quantity);
    } else {
      _items.add(CartItem(product: product));
      await _dbHelper.insertOrUpdateCart(product.id!, 1);
    }
    notifyListeners();
  }

  // 3. زيادة الكمية (Increment Quantity)
  Future<void> incrementQuantity(CartItem cartItem) async {
    if (cartItem.product.id == null) return;
    cartItem.quantity++;
    await _dbHelper.insertOrUpdateCart(cartItem.product.id!, cartItem.quantity);
    notifyListeners();
  }

  // 4. تقليل الكمية أو الحذف النهائي (Decrement or Clean-up)
  Future<void> decrementQuantity(CartItem cartItem) async {
    if (cartItem.product.id == null) return;
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
      await _dbHelper.insertOrUpdateCart(cartItem.product.id!, cartItem.quantity);
    } else {
      // لو الكمية وصلت لـ 1 وداس ناقص، بنمسحه من السلة تماماً
      await _dbHelper.deleteFromCart(cartItem.product.id!);
      _items.remove(cartItem);
    }
    notifyListeners();
  }
// دالة إتمام الشراء وتفريغ السلة
  Future<void> clearCart() async {
    await _dbHelper.clearCart(); // 1. تفريغ الـ SQLite
    _items.clear(); // 2. تفريغ الـ RAM
    notifyListeners(); // 3. تحديث الـ UI ليظهر السلة فارغة
  }
  // 5. حساب الإجمالي (Total Price Calculation)
  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }
}