/// Ürün verilerinin JSON simülasyonu
/// FakeStoreAPI formatında hazırlanmış lokal veri kaynağı
class ProductData {
  /// JSON formatında ürün listesi simülasyonu
  static final List<Map<String, dynamic>> productsJson = [
    {
      "id": 1,
      "title": "Fjallraven - Foldsack No. 1 Backpack",
      "price": 109.95,
      "description":
          "Günlük kullanım ve doğa yürüyüşleri için mükemmel çanta. 15 inç'e kadar dizüstü bilgisayarınızı yastıklı bölmeye yerleştirin. Her gün kullanabileceğiniz çok yönlü bir sırt çantası.",
      "category": "men's clothing",
      "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
      "rating": {"rate": 3.9, "count": 120}
    },
    {
      "id": 2,
      "title": "Mens Casual Premium Slim Fit T-Shirts",
      "price": 22.3,
      "description":
          "Dar kesim, kontrast raglan uzun kollu, üç düğmeli henley yaka, hafif ve yumuşak kumaş. Nefes alabilen ve rahat bir giyim sunar.",
      "category": "men's clothing",
      "image":
          "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_t.png",
      "rating": {"rate": 4.1, "count": 259}
    },
    {
      "id": 3,
      "title": "Mens Cotton Jacket",
      "price": 55.99,
      "description":
          "İlkbahar/Sonbahar/Kış için harika dış giyim ceketleri. Çalışma, yürüyüş, kamp, dağcılık, bisiklet, seyahat gibi birçok etkinlik için uygundur.",
      "category": "men's clothing",
      "image": "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_t.png",
      "rating": {"rate": 4.7, "count": 500}
    },
    {
      "id": 4,
      "title": "Mens Casual Slim Fit",
      "price": 15.99,
      "description":
          "Ekrandaki renk ile gerçek ürün rengi arasında küçük farklılıklar olabilir. Vücut yapıları kişiden kişiye farklılık gösterdiğinden detaylı beden bilgilerini inceleyiniz.",
      "category": "men's clothing",
      "image": "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_t.png",
      "rating": {"rate": 2.1, "count": 430}
    },
    {
      "id": 5,
      "title": "John Hardy Women's Gold & Silver Bracelet",
      "price": 695.0,
      "description":
          "Legends koleksiyonumuzdan, Naga okyanusun incisini koruyan efsanevi su ejderhasından ilham almıştır. Sevgi ve bolluk için içe doğru, koruma için dışa doğru takın.",
      "category": "jewelery",
      "image":
          "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_t.png",
      "rating": {"rate": 4.6, "count": 400}
    },
    {
      "id": 6,
      "title": "Solid Gold Petite Micropave",
      "price": 168.0,
      "description":
          "Memnuniyet garantisi. 30 gün içinde iade veya değişim imkanı. ABD'de tasarlanmış ve satışa sunulmuştur.",
      "category": "jewelery",
      "image":
          "https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_t.png",
      "rating": {"rate": 3.9, "count": 70}
    },
    {
      "id": 7,
      "title": "White Gold Plated Princess Ring",
      "price": 9.99,
      "description":
          "Klasik Nişan Yüzüğü. Nişan, düğün, yıldönümü, Sevgililer Günü için sevdiklerinize özel hediye.",
      "category": "jewelery",
      "image":
          "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_t.png",
      "rating": {"rate": 3.0, "count": 400}
    },
    {
      "id": 8,
      "title": "Rose Gold Plated Stainless Steel Earrings",
      "price": 10.99,
      "description":
          "Rose Gold Kaplama Çift Tünel Küpe. 316L Paslanmaz Çelikten üretilmiştir. Şık ve dayanıklı tasarım.",
      "category": "jewelery",
      "image":
          "https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_t.png",
      "rating": {"rate": 1.9, "count": 100}
    },
    {
      "id": 9,
      "title": "WD 2TB Portable External Hard Drive",
      "price": 64.0,
      "description":
          "USB 3.0 ve USB 2.0 uyumluluğu. Hızlı veri transferi ve yüksek kapasite. Windows 10, 8.1, 7 ile uyumludur.",
      "category": "electronics",
      "image": "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_t.png",
      "rating": {"rate": 3.3, "count": 203}
    },
    {
      "id": 10,
      "title": "SanDisk SSD PLUS 1TB Internal SSD",
      "price": 109.0,
      "description":
          "Daha hızlı açılış, kapatma ve uygulama yükleme performansı. 535MB/s okuma ve 450MB/s yazma hızı sunar.",
      "category": "electronics",
      "image": "https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_t.png",
      "rating": {"rate": 2.9, "count": 470}
    },
    {
      "id": 11,
      "title": "Silicon Power 256GB SSD",
      "price": 109.0,
      "description":
          "3D NAND flash teknolojisi ile yüksek transfer hızları. SLC Cache teknolojisi ile performans artışı ve uzun ömür. 7mm ince tasarım.",
      "category": "electronics",
      "image": "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_t.png",
      "rating": {"rate": 4.8, "count": 319}
    },
    {
      "id": 12,
      "title": "WD 4TB Gaming Drive for PS4",
      "price": 114.0,
      "description":
          "PS4 oyun deneyiminizi genişletin. Hızlı ve kolay kurulum. Yüksek kapasiteli şık tasarım. 3 yıl üretici garantisi.",
      "category": "electronics",
      "image": "https://fakestoreapi.com/img/61mtL65D4cL._AC_SX679_t.png",
      "rating": {"rate": 4.8, "count": 400}
    },
    {
      "id": 13,
      "title": "Acer SB220Q 21.5\" Full HD IPS Monitor",
      "price": 599.0,
      "description":
          "21.5 inç Full HD (1920 x 1080) IPS ekran. 75Hz yenileme hızı, 4ms tepki süresi. Ultra ince sıfır çerçeve tasarım.",
      "category": "electronics",
      "image": "https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_t.png",
      "rating": {"rate": 2.9, "count": 250}
    },
    {
      "id": 14,
      "title": "Samsung 49\" Curved Gaming Monitor",
      "price": 999.99,
      "description":
          "49 inç süper geniş 32:9 kavisli oyun monitörü. QLED teknolojisi, HDR desteği. 144Hz yenileme hızı ve 1ms tepki süresi.",
      "category": "electronics",
      "image": "https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_t.png",
      "rating": {"rate": 2.2, "count": 140}
    },
    {
      "id": 15,
      "title": "Women's 3-in-1 Snowboard Jacket",
      "price": 56.99,
      "description":
          "100% Polyester. Çıkarılabilir sıcak polar astarlı. Rüzgar ve su geçirmez ayarlanabilir kapüşon. Fermuarlı cepler ile eşyalarınız güvende.",
      "category": "women's clothing",
      "image": "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_t.png",
      "rating": {"rate": 2.6, "count": 235}
    },
    {
      "id": 16,
      "title": "Removable Hooded Faux Leather Jacket",
      "price": 29.95,
      "description":
          "Suni deri malzeme ile stil ve konfor. 2 ön cep, kapüşonlu denim tarzı. Bel detayları ve dekoratif dikişler.",
      "category": "women's clothing",
      "image": "https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_t.png",
      "rating": {"rate": 2.9, "count": 340}
    },
    {
      "id": 17,
      "title": "Rain Jacket Women Windbreaker",
      "price": 39.99,
      "description":
          "Hafif, seyahat veya günlük kullanım için ideal. Kapüşonlu, ayarlanabilir bel tasarımı. Düğme ve fermuarlı ön kapama.",
      "category": "women's clothing",
      "image": "https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2t.png",
      "rating": {"rate": 3.8, "count": 679}
    },
    {
      "id": 18,
      "title": "Women's Solid Short Sleeve Boat Neck",
      "price": 9.85,
      "description":
          "%95 Rayon %5 Spandex. Hafif kumaş ile mükemmel esneklik. Kollar ve yakalarda nervür detayı. Alt kısımda çift dikiş.",
      "category": "women's clothing",
      "image": "https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_t.png",
      "rating": {"rate": 4.7, "count": 130}
    },
    {
      "id": 19,
      "title": "Women's Short Sleeve Moisture T-Shirt",
      "price": 7.95,
      "description":
          "%100 Polyester. Nem emici kumaş ile kuru ve serin kalın. V yaka tasarım, ince ve feminen silüet.",
      "category": "women's clothing",
      "image": "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_t.png",
      "rating": {"rate": 4.5, "count": 146}
    },
    {
      "id": 20,
      "title": "DANVOUY Women's Cotton T Shirt",
      "price": 12.99,
      "description":
          "%95 Pamuk, %5 Spandex. Günlük, kısa kollu, baskılı, V yaka tasarım. Yumuşak ve esnek kumaş. Her mevsim uygundur.",
      "category": "women's clothing",
      "image": "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_t.png",
      "rating": {"rate": 3.6, "count": 145}
    },
  ];

  /// Tüm kategorilerin listesi
  static List<String> get categories {
    final Set<String> categorySet = {};
    for (var product in productsJson) {
      categorySet.add(product['category'] as String);
    }
    return categorySet.toList();
  }

  /// Kategori isimlerini Türkçe karşılıklarıyla eşleştirir
  static String getCategoryDisplayName(String category) {
    switch (category) {
      case "men's clothing":
        return "Erkek Giyim";
      case "women's clothing":
        return "Kadın Giyim";
      case "jewelery":
        return "Takı & Aksesuar";
      case "electronics":
        return "Elektronik";
      default:
        return category;
    }
  }

  /// Kategori için ikon döndürür
  static int getCategoryIconCode(String category) {
    switch (category) {
      case "men's clothing":
        return 0xe318; // Icons.male
      case "women's clothing":
        return 0xe261; // Icons.female
      case "jewelery":
        return 0xe1f8; // Icons.diamond
      case "electronics":
        return 0xe1e3; // Icons.devices
      default:
        return 0xe25a; // Icons.category
    }
  }
}
