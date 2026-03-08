import 'package:flutter/material.dart';
import 'package:marketoo/models/app_models.dart';
import 'package:marketoo/providers/cart_provider.dart';
import 'package:marketoo/providers/category_provider.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, catProvider, child) {
        final currentCategory = catProvider.categories.firstWhere(
          (c) => c.id == product.categoryId,
        );
        final currentProduct = currentCategory.products.firstWhere(
          (p) => p.id == product.id,
          orElse: () => product,
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(currentProduct.name),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.orange),
                onPressed: () =>
                    _showEditDialog(context, catProvider, currentProduct),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: currentProduct.image.startsWith('http')
                          ? NetworkImage(currentProduct.image)
                          : const AssetImage('assets/images/placeholder.png')
                                as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentProduct.name,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${currentProduct.price}',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        currentProduct.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            Provider.of<CartProvider>(
                              context,
                              listen: false,
                            ).addToCart(currentProduct);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${currentProduct.name} added to cart!',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditDialog(
    BuildContext context,
    CategoryProvider provider,
    ProductModel currentProduct,
  ) {
    String name = currentProduct.name;
    String image = currentProduct.image;
    String priceStr = currentProduct.price.toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // استخدام TextFormField بدلاً من TextField لحل المشكلة
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              initialValue: name,
              onChanged: (v) => name = v,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Image URL'),
              initialValue: image,
              onChanged: (v) => image = v,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              initialValue: priceStr,
              onChanged: (v) => priceStr = v,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final price = double.tryParse(priceStr);
              if (name.isNotEmpty && image.isNotEmpty && price != null) {
                final updated = ProductModel(
                  id: currentProduct.id,
                  categoryId: currentProduct.categoryId,
                  name: name,
                  image: image,
                  price: price,
                  description: currentProduct.description,
                );
                provider.updateProduct(currentProduct.categoryId!, updated);
                Navigator.pop(context);
              }
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}