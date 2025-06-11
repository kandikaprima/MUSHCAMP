import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CapturePage extends StatelessWidget {
  const CapturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ambil Gambar')),
      body: const Center(child: Text('Di sini akan ada kamera atau picker gambar.')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/detail'), // Simulasi pindah ke detail
        child: const Icon(Icons.check),
      ),
    );
  }
}
