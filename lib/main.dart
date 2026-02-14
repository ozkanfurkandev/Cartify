import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const CartifyApp());
}

/// Cartify - Modern E-Ticaret Katalog Uygulaması
class CartifyApp extends StatelessWidget {
  const CartifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7F9),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF1A1A2E),
          onPrimary: Colors.white,
          secondary: Color(0xFFFF6B35),
          onSecondary: Colors.white,
          tertiary: Color(0xFF6C63FF),
          error: Color(0xFFBA1A1A),
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Color(0xFF1A1A2E),
          surfaceContainerHighest: Color(0xFFF0F2F5),
          outline: Color(0xFFE8E8E8),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF1A1A2E)),
          titleTextStyle: TextStyle(
            color: Color(0xFF1A1A2E),
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFF0F0F0), width: 1),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A1A2E),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/product-detail': (context) => const ProductDetailScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}
