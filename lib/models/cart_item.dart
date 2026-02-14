import 'product.dart';

/// Sepetteki bir ürünü temsil eden model sınıfı
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  /// Toplam fiyat (ürün fiyatı x adet)
  double get totalPrice => product.price * quantity;
}
