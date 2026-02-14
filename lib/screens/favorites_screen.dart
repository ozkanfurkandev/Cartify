import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/product_data.dart';

/// Favoriler Sayfası
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<Product> _favoriteProducts;
  late Set<int> _favoriteIds;
  bool _isInitialized = false;
  // Favori ekranındayken sepete eklenen ürün ID'leri
  final List<int> _addToCartIds = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _favoriteProducts =
          List<Product>.from(args['products'] as List<Product>);
      _favoriteIds = Set<int>.from(args['favoriteIds'] as Set<int>);
      _isInitialized = true;
    }
  }

  void _removeFavorite(int productId) {
    setState(() {
      _favoriteProducts.removeWhere((p) => p.id == productId);
      _favoriteIds.remove(productId);
    });
  }

  void _navigateToDetail(Product product) {
    Navigator.pushNamed(
      context,
      '/product-detail',
      arguments: {
        'product': product,
        'isFavorite': _favoriteIds.contains(product.id),
      },
    ).then((result) {
      if (result != null && result is Map<String, dynamic>) {
        final productId = result['productId'] as int;
        final isFavorite = result['isFavorite'] as bool;
        setState(() {
          if (isFavorite) {
            _favoriteIds.add(productId);
          } else {
            _favoriteIds.remove(productId);
            _favoriteProducts.removeWhere((p) => p.id == productId);
          }
        });
        // Sepete ekleme isteğini biriktir
        if (result.containsKey('addToCart') && result['addToCart'] == true) {
          _addToCartIds.add(productId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, {
              'favoriteIds': _favoriteIds,
              'addToCartIds': _addToCartIds,
            });
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F9),
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  size: 16, color: Color(0xFF1A1A2E)),
            ),
            onPressed: () => Navigator.pop(context, {
              'favoriteIds': _favoriteIds,
              'addToCartIds': _addToCartIds,
            }),
          ),
          title: Column(
            children: [
              const Text(
                'Favorilerim',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              if (_favoriteProducts.isNotEmpty)
                Text(
                  '${_favoriteProducts.length} ürün',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
          centerTitle: true,
        ),
        body: _favoriteProducts.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B35).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Icon(
                        Icons.favorite_border_rounded,
                        size: 56,
                        color:
                            const Color(0xFFFF6B35).withValues(alpha: 0.4),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Henüz favori ürün yok',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Beğendiğiniz ürünleri favorilere ekleyin',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, {
                        'favoriteIds': _favoriteIds,
                        'addToCartIds': _addToCartIds,
                      }),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A1A2E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Ürünleri Keşfet',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                itemCount: _favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = _favoriteProducts[index];
                  return _buildFavoriteItem(product, index);
                },
              ),
      ),
    );
  }

  Widget _buildFavoriteItem(Product product, int index) {
    return Dismissible(
      key: Key('favorite-${product.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_outline, color: Colors.white, size: 24),
            SizedBox(height: 4),
            Text('Sil',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      onDismissed: (_) => _removeFavorite(product.id),
      child: GestureDetector(
        onTap: () => _navigateToDetail(product),
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFF0F0F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Görsel
              Container(
                width: 85,
                height: 85,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.grey.shade400),
                ),
              ),
              const SizedBox(width: 14),
              // Bilgiler
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A2E),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ProductData.getCategoryDisplayName(product.category),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '\$${product.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star_rounded,
                                  size: 13, color: Colors.amber.shade700),
                              const SizedBox(width: 2),
                              Text(
                                product.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Favori butonu
              GestureDetector(
                onTap: () => _removeFavorite(product.id),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B35).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.favorite_rounded,
                      color: Color(0xFFFF6B35), size: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
