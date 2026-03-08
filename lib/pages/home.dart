// ignore_for_file: unused_import, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:marketoo/models/app_models.dart'; // <--- كان ناقص
import 'package:marketoo/providers/theme_provider.dart';
import 'package:marketoo/providers/category_provider.dart'; // <--- كان ناقص
import 'package:marketoo/pages/cart_page.dart';
import 'package:marketoo/pages/fast_food.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newTitle = '';
              String newImage = '';
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  'Add New Category',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Category Name (e.g., Drinks)',
                      ),
                      onChanged: (val) => newTitle = val,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      onChanged: (val) => newImage = val,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (newTitle.isNotEmpty && newImage.isNotEmpty) {
                        Provider.of<CategoryProvider>(
                          context,
                          listen: false,
                        ).addCategory(newTitle, newImage);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: const Text('Marketoo App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Icon(
              Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<CategoryProvider>(
                builder: (context, categoryProvider, child) {
                  final categoriesList = categoryProvider.categories;

                  if (categoriesList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: categoriesList.length,
                    itemBuilder: (context, index) {
                      final category = categoriesList[index];

                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FastFood(category: category),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 160,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black,
                                  image: DecorationImage(
                                    image: category.imagePath.startsWith('http')
                                        ? NetworkImage(category.imagePath)
                                              as ImageProvider
                                        : AssetImage(category.imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                  child: Text(
                                    category.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          title: const Text('Delete Category'),
                                          content: Text(
                                            'Are you sure you want to delete "${category.title}"?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.redAccent,
                                              ),
                                              onPressed: () {
                                                if (category.id != null) {
                                                  Provider.of<CategoryProvider>(
                                                    context,
                                                    listen: false,
                                                  ).deleteCategory(
                                                    category.id!,
                                                  );
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // جوه الـ Stack في ملف home.dart
                              Positioned(
                                top: 10,
                                right:
                                    60, // حركناه شمال شوية عشان يبقى جنب زرار الحذف
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                    onPressed: () {
                                      // فتح شاشة التعديل الخاصة بالقسم
                                      String newTitle = category.title;
                                      String newImage = category.imagePath;

                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          title: const Text('Edit Category'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                initialValue: newTitle,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText:
                                                          'Category Name',
                                                    ),
                                                onChanged: (val) =>
                                                    newTitle = val,
                                              ),
                                              const SizedBox(height: 10),
                                              TextFormField(
                                                initialValue: newImage,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText: 'Image URL',
                                                    ),
                                                onChanged: (val) =>
                                                    newImage = val,
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                if (newTitle.isNotEmpty &&
                                                    newImage.isNotEmpty &&
                                                    category.id != null) {
                                                  Provider.of<CategoryProvider>(
                                                    context,
                                                    listen: false,
                                                  ).updateCategory(
                                                    category.id!,
                                                    newTitle,
                                                    newImage,
                                                  );
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Text('Save'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
