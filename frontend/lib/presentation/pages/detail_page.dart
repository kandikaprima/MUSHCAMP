import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Deteksi')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Di sini akan ditampilkan nama jamur dan gambar hasil deteksi.'),
      ),
    );
  }
}
