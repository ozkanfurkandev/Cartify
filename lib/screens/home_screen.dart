import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../data/product_data.dart';
import '../widgets/product_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/search_bar_widget.dart';

/// Modern Ana Sayfa - Sepet + Favori + Arama + Filtre
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Product> _allProducts;
  List<Product> _filteredProducts = [];
  final Set<int> _favoriteIds = {};
  final List<CartItem> _cartItems = [];
  String? _selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadProducts() {
    _allProducts = ProductData.productsJson
        .map((json) => Product.fromJson(json))
        .toList();
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final matchesCategory =
            _selectedCategory == null || product.category == _selectedCategory;
        final matchesSearch = _searchQuery.isEmpty ||
            product.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            product.description
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  void _toggleFavorite(int productId) {
    setState(() {
      if (_favoriteIds.contains(productId)) {
        _favoriteIds.remove(productId);
      } else {
        _favoriteIds.add(productId);
      }
    });
  }

  /// Sepete ürün ekle
  void addToCart(Product product) {
    setState(() {
      final existingIndex =
          _cartItems.indexWhere((item) => item.product.id == product.id);
      if (existingIndex != -1) {
        _cartItems[existingIndex].quantity++;
      } else {
        _cartItems.add(CartItem(product: product));
      }
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline,
                color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${product.title} sepete eklendi',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      ),
    );
  }

  int get _cartItemCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

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
          }
        });
        // Sepete ekleme sonucu
        if (result.containsKey('addToCart') && result['addToCart'] == true) {
          final p = _allProducts.firstWhere((p) => p.id == productId);
          addToCart(p);
        }
      }
    });
  }

  void _navigateToFavorites() {
    final favoriteProducts =
        _allProducts.where((p) => _favoriteIds.contains(p.id)).toList();
    Navigator.pushNamed(
      context,
      '/favorites',
      arguments: {
        'products': favoriteProducts,
        'favoriteIds': Set<int>.from(_favoriteIds),
      },
    ).then((result) {
      if (result != null && result is Map<String, dynamic>) {
        // Favori durumunu güncelle
        final returnedFavoriteIds = result['favoriteIds'] as Set<int>;
        setState(() {
          _favoriteIds.clear();
          _favoriteIds.addAll(returnedFavoriteIds);
        });
        // Favori ekranından sepete eklenen ürünleri işle
        final addToCartIds = result['addToCartIds'] as List<int>;
        for (final productId in addToCartIds) {
          final product = _allProducts.firstWhere((p) => p.id == productId);
          addToCart(product);
        }
      }
    });
  }

  void _navigateToCart() {
    Navigator.pushNamed(
      context,
      '/cart',
      arguments: {
        'cartItems': _cartItems,
      },
    ).then((result) {
      if (result != null && result is List<CartItem>) {
        setState(() {
          _cartItems.clear();
          _cartItems.addAll(result);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F9),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Üst Bar
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    // Sol: Logo + Metin
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF6C63FF),
                                      Color(0xFFFF6B35),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.shopping_bag_rounded,
                                    color: Colors.white, size: 20),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Cartify',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A1A2E),
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'En iyi ürünleri keşfet',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Sağ: Favori + Sepet
                    _buildHeaderIcon(
                      icon: _favoriteIds.isEmpty
                          ? Icons.favorite_border_rounded
                          : Icons.favorite_rounded,
                      badgeCount: _favoriteIds.length,
                      badgeColor: const Color(0xFFFF6B35),
                      iconColor: _favoriteIds.isNotEmpty
                          ? const Color(0xFFFF6B35)
                          : null,
                      onTap: _navigateToFavorites,
                    ),
                    const SizedBox(width: 12),
                    _buildHeaderIcon(
                      icon: Icons.shopping_bag_outlined,
                      badgeCount: _cartItemCount,
                      badgeColor: const Color(0xFF6C63FF),
                      onTap: _navigateToCart,
                    ),
                  ],
                ),
              ),
            ),

            // Arama
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              sliver: SliverToBoxAdapter(
                child: SearchBarWidget(
                  controller: _searchController,
                  onChanged: (value) {
                    _searchQuery = value;
                    _applyFilters();
                  },
                  onClear: () {
                    _searchController.clear();
                    _searchQuery = '';
                    _applyFilters();
                  },
                ),
              ),
            ),

            // Banner
            if (_searchQuery.isEmpty && _selectedCategory == null)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                sliver: SliverToBoxAdapter(child: _buildPromoBanner()),
              ),

            // Kategoriler
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Kategoriler',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    Text(
                      'Tümünü Gör',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CategoryChip(
                        label: 'Tümü',
                        icon: Icons.grid_view_rounded,
                        isSelected: _selectedCategory == null,
                        onTap: () {
                          _selectedCategory = null;
                          _applyFilters();
                        },
                      ),
                    ),
                    ...ProductData.categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CategoryChip(
                          label: ProductData.getCategoryDisplayName(category),
                          icon: IconData(
                            ProductData.getCategoryIconCode(category),
                            fontFamily: 'MaterialIcons',
                          ),
                          isSelected: _selectedCategory == category,
                          onTap: () {
                            _selectedCategory = category;
                            _applyFilters();
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Ürün Başlığı
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedCategory == null
                            ? 'Popüler Ürünler'
                            : ProductData.getCategoryDisplayName(
                                _selectedCategory!),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_filteredProducts.length} ürün',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6C63FF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Grid
            _filteredProducts.isEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(60),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Icon(Icons.search_off_rounded,
                                size: 40, color: Colors.grey.shade300),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Ürün bulunamadı',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.58,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = _filteredProducts[index];
                          return ProductCard(
                            product: product,
                            isFavorite: _favoriteIds.contains(product.id),
                            onFavoriteToggle: () => _toggleFavorite(product.id),
                            onTap: () => _navigateToDetail(product),
                          );
                        },
                        childCount: _filteredProducts.length,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIcon({
    required IconData icon,
    required int badgeCount,
    required Color badgeColor,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFEEEEEE)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, size: 22, color: iconColor ?? const Color(0xFF1A1A2E)),
          ),
          if (badgeCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Text(
                  '$badgeCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF2D2B55)],
          ),
        ),
        child: Stack(
        children: [
          // Dekoratif daireler
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.03),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B35),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '%50 İNDİRİM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Yaz Koleksiyonu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Keşfetmeye başla',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Alışverişe Başla',
                    style: TextStyle(
                      color: Color(0xFF1A1A2E),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
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
  }
}
