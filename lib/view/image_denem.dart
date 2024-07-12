import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

Future<String> getCoverImageUrl(String fileName) async {
  final dio = Dio();
  final url = 'https://assign-api.piton.com.tr/api/rest/cover_image';

  try {
    final response = await dio.post(
      url,
      data: {'fileName': fileName},
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 200) {
      return response.data['action_product_image']['url'];
    } else {
      throw Exception('Failed to load cover image URL');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

class ImageDenem extends StatefulWidget {
  const ImageDenem({super.key});

  @override
  State<ImageDenem> createState() => _ImageDenemState();
}

class _ImageDenemState extends State<ImageDenem> {

  String? imageUrl;

  void _getImageUrl() async {
    try {
      final url = await getCoverImageUrl('dune.png');
      setState(() {
        imageUrl = url;
      });
    } catch (e) {
      print('Hata: $e');
      // Hata durumunda kullanıcıya bir mesaj gösterebilirsiniz
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cover Image Örneği')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _getImageUrl,
              child: Text('Resim URL\'si Al'),
            ),
            SizedBox(height: 20),
            if (imageUrl != null)
              Image.network(
                imageUrl!,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) {
                  return Text('Resim yüklenemedi');
                },
              )
            else
              Text('Henüz resim yok'),
          ],
        ),
      ),
    );
  }
}