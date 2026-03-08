import 'package:flutter/material.dart';
import 'package:marketoo/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart'), centerTitle: true),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty!', style: TextStyle(fontSize: 22, color: Colors.grey)))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          // 1. حماية الصورة (Image Sanitization)
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: cartItem.product.image.startsWith('http')
                                ? Image.network(
                                    cartItem.product.image,
                                    width: 60, height: 60, fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, color: Colors.grey),
                                  )
                                : const Icon(Icons.fastfood, size: 40, color: Colors.grey),
                          ),
                          title: Text(cartItem.product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('\$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                          // 2. أزرار التحكم في الكمية
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(cartItem.quantity > 1 ? Icons.remove_circle_outline : Icons.delete_outline, color: cartItem.quantity > 1 ? Colors.orange : Colors.red),
                                onPressed: () => cartProvider.decrementQuantity(cartItem),
                              ),
                              Text('${cartItem.quantity}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                onPressed: () => cartProvider.incrementQuantity(cartItem),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // 3. منطقة الإجمالي والدفع
                _buildCheckoutSection(context, cartProvider),
              ],
            ),
    );
  }

  // دمجنا جزء الـ Checkout في Widget منفصلة عشان الكود يكون Scannable
  Widget _buildCheckoutSection(BuildContext context, CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total:', style: TextStyle(fontSize: 18, color: Colors.grey)),
              Text('\$${cartProvider.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          ),
          ElevatedButton(
            onPressed: () {}, // سيتم برمجته لاحقاً
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            child: const Text('Checkout', style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}