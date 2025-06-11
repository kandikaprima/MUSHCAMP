import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MushCamp')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Welcome to MushCamp! Silakan klik tombol di bawah untuk mulai.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/capture'),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
