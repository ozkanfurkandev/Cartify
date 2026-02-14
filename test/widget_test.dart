import 'package:flutter_test/flutter_test.dart';

import 'package:cartify/main.dart';

void main() {
  testWidgets('Cartify app smoke test', (WidgetTester tester) async {
    // Uygulamayı başlat
    await tester.pumpWidget(const CartifyApp());

    // Cartify başlığının göründüğünü doğrula
    expect(find.text('Cartify'), findsOneWidget);
    expect(find.text('En iyi ürünleri keşfedin'), findsOneWidget);
  });
}
