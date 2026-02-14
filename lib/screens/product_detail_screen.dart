import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/product_data.dart';

/// Ürün Detay Sayfası - Sepete ekleme + Favori
class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Product _product;
  late bool _isFavorite;
  bool _isInitialized = false;
  int _selectedSizeIndex = 1;
  int _selectedColorIndex = 0;
  bool _addedToCart = false;

  final List<String> _sizes = ['S', 'M', 'L', 'XL'];
  final List<Color> _colors = [
    const Color(0xFF1A1A2E),
    const Color(0xFF5D4037),
    const Color(0xFF37474F),
    const Color(0xFF4A148C),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _product = args['product'] as Product;
      _isFavorite = args['isFavorite'] as bool;
      _isInitialized = true;
    }
  }

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
  }

  Map<String, dynamic> get _resultData => {
        'productId': _product.id,
        'isFavorite': _isFavorite,
        'addToCart': _addedToCart,
      };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isClothing = _product.category.contains('clothing');

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context, _resultData);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                // Görsel
                SliverAppBar(
                  expandedHeight: size.height * 0.45,
                  pinned: true,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context, _resultData),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            size: 16, color: Color(0xFF1A1A2E)),
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: _toggleFavorite,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _isFavorite
                                ? const Color(0xFFFF6B35).withValues(alpha: 0.1)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Icon(
                            _isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            size: 20,
                            color: _isFavorite
                                ? const Color(0xFFFF6B35)
                                : const Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: const Color(0xFFFAFAFA),
                      padding: const EdgeInsets.fromLTRB(40, 60, 40, 40),
                      child: Hero(
                        tag: 'product-${_product.id}',
                        child: Image.network(
                          _product.image,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image_not_supported_outlined,
                                  size: 64, color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ),
                ),

                // Bilgiler
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tutma çubuğu
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Kategori + Rating
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C63FF)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                ProductData.getCategoryDisplayName(
                                    _product.category),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF6C63FF),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star_rounded,
                                      size: 16, color: Colors.amber.shade700),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${_product.rating}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber.shade900,
                                    ),
                                  ),
                                  Text(
                                    ' (${_product.ratingCount})',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Başlık
                        Text(
                          _product.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Fiyat
                        Text(
                          '\$${_product.price}',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Renk (giyim ise)
                        if (isClothing) ...[
                          _buildSectionTitle('Renk'),
                          const SizedBox(height: 12),
                          Row(
                            children: List.generate(_colors.length, (index) {
                              final isSelected = _selectedColorIndex == index;
                              return GestureDetector(
                                onTap: () => setState(
                                    () => _selectedColorIndex = index),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.only(right: 12),
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: _colors[index],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF6C63FF)
                                          : Colors.transparent,
                                      width: 2.5,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: _colors[index]
                                                  .withValues(alpha: 0.4),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            )
                                          ]
                                        : null,
                                  ),
                                  child: isSelected
                                      ? const Icon(Icons.check,
                                          color: Colors.white, size: 18)
                                      : null,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 24),

                          // Beden
                          _buildSectionTitle('Beden'),
                          const SizedBox(height: 12),
                          Row(
                            children: List.generate(_sizes.length, (index) {
                              final isSelected = _selectedSizeIndex == index;
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedSizeIndex = index),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.only(right: 12),
                                  width: 48,
                                  height: 48,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF1A1A2E)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.transparent
                                          : const Color(0xFFE0E0E0),
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: const Color(0xFF1A1A2E)
                                                  .withValues(alpha: 0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            )
                                          ]
                                        : null,
                                  ),
                                  child: Text(
                                    _sizes[index],
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFF1A1A2E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 28),
                        ],

                        // Açıklama
                        _buildSectionTitle('Ürün Açıklaması'),
                        const SizedBox(height: 12),
                        Text(
                          _product.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            height: 1.7,
                          ),
                        ),

                        const SizedBox(height: 110), // Alt buton boşluğu
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Alt Buton
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade100, width: 1),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      // Fiyat
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Toplam Fiyat',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '\$${_product.price}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 24),
                      // Buton
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() => _addedToCart = true);
                            Navigator.pop(context, _resultData);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A1A2E),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_bag_outlined, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Sepete Ekle',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1A1A2E),
      ),
    );
  }
}
