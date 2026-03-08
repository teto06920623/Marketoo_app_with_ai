import 'package:flutter/material.dart';
import 'package:marketoo/core/app_theme.dart';
import 'package:marketoo/providers/theme_provider.dart';
import 'package:marketoo/providers/category_provider.dart';
import 'package:marketoo/providers/cart_provider.dart';
import 'package:marketoo/pages/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()), 
      ],
      child: const ShoppingApp(), 
    ),
  );
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      home: const SplashScreen(), 
    );
  }
}