import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class KatalogSayfasi extends StatefulWidget {
  @override
  _KatalogSayfasiState createState() => _KatalogSayfasiState();
}

class _KatalogSayfasiState extends State<KatalogSayfasi> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Dio _dio = Dio();
  List<Kategori> kategoriler = [];
  List<Urun> urunler = [];
  List<Urun> filtrelenmisUrunler = [];
  String aramaMetni = '';

  @override
  void initState() {
    super.initState();
    kategorileriGetir();
    urunleriGetir();
  }

  Future<void> kategorileriGetir() async {
    try {
      final yanit = await _dio.get('https://assign-api.piton.com.tr/api/rest/categories');
      if (yanit.statusCode == 200) {
        final veri = yanit.data;
        setState(() {
          kategoriler = [Kategori(id: 0, ad: 'Tümü'), ...List<Kategori>.from(veri['category'].map((x) => Kategori.fromJson(x)))];
          _tabController = TabController(length: kategoriler.length, vsync: this);
        });
      }
    } catch (e) {
      print('Kategoriler getirilirken hata oluştu: $e');
    }
  }

  Future<void> urunleriGetir() async {
    try {
      final yanit = await _dio.get('https://assign-api.piton.com.tr/api/rest/products/1');
      if (yanit.statusCode == 200) {
        final veri = yanit.data;
        setState(() {
          urunler = List<Urun>.from(veri['product'].map((x) => Urun.fromJson(x)));
          filtrelenmisUrunler = List.from(urunler);
        });
      }
    } catch (e) {
      print('Ürünler getirilirken hata oluştu: $e');
    }
  }

  void urunleriFiltreleme(int kategoriId) {
    setState(() {
      if (kategoriId == 0) {
        filtrelenmisUrunler = List.from(urunler);
      } else {
        filtrelenmisUrunler = urunler.where((urun) => urun.kategoriId == kategoriId).toList();
      }
    });
  }

  void urunleriArama(String sorgu) {
    setState(() {
      aramaMetni = sorgu;
      if (sorgu.isEmpty) {
        urunleriFiltreleme(_tabController.index);
      } else {
        filtrelenmisUrunler = filtrelenmisUrunler.where((urun) =>
          urun.ad.toLowerCase().contains(sorgu.toLowerCase()) ||
          urun.yazar.toLowerCase().contains(sorgu.toLowerCase())
        ).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Katalog'),
        bottom: kategoriler.isEmpty ? null : TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: kategoriler.map((kategori) => Tab(text: kategori.ad)).toList(),
          onTap: (index) {
            urunleriFiltreleme(kategoriler[index].id);
            urunleriArama(aramaMetni);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Ara',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: urunleriArama,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtrelenmisUrunler.length,
              itemBuilder: (context, index) {
                final urun = filtrelenmisUrunler[index];
                return ListTile(
                  leading: FutureBuilder<String>(
                    future: kapakResmiGetir(urun.kapak),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                        return Image.network(snapshot.data!, width: 50, height: 50, fit: BoxFit.cover);
                      } else {
                        return Container(width: 50, height: 50, color: Colors.grey);
                      }
                    },
                  ),
                  title: Text(urun.ad),
                  subtitle: Text(urun.yazar),
                  trailing: Text('${urun.fiyat.toStringAsFixed(2)} ₺'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<String> kapakResmiGetir(String dosyaAdi) async {
    try {
      final yanit = await _dio.post(
        'https://assign-api.piton.com.tr/api/rest/cover_image',
        data: {'fileName': dosyaAdi},
      );
      if (yanit.statusCode == 200) {
        final veri = yanit.data;
        return veri['action_product_image']['url'];
      }
    } catch (e) {
      print('Kapak resmi getirilirken hata oluştu: $e');
    }
    return '';
  }
}

class Kategori {
  final int id;
  final String ad;

  Kategori({required this.id, required this.ad});

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id: json['id'],
      ad: json['name'],
    );
  }
}

class Urun {
  final int id;
  final String ad;
  final String yazar;
  final double fiyat;
  final String kapak;
  final int kategoriId;

  Urun({
    required this.id,
    required this.ad,
    required this.yazar,
    required this.fiyat,
    required this.kapak,
    required this.kategoriId,
  });

  factory Urun.fromJson(Map<String, dynamic> json) {
    return Urun(
      id: json['id'],
      ad: json['name'],
      yazar: json['author'],
      fiyat: json['price'].toDouble(),
      kapak: json['cover'],
      kategoriId: json['category_id'] ?? 0,
    );
  }
}