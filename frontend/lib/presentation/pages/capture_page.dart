import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/repositories/mushroom_repository.dart';

class CapturePage extends StatefulWidget {
  const CapturePage({super.key});

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFromGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  Future<void> _pickFromCamera() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  Future<void> _detectAndNavigate() async {
    await _pickFromCamera(); // Buka kamera
    if (_selectedImage == null) return;

    final repo = MushroomRepository();
    final result = await repo.detectMushroom(_selectedImage!);

    if (mounted) {
      context.push('/detail', extra: {
        'result': result,
        'imagePath': _selectedImage!.path,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.yellow),
          onPressed: () => context.pop(),
        ),
        title: const Text("MushCamp", style: TextStyle(color: AppColors.yellow, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: AppColors.yellow,
              child: Image.asset('assets/logo.png', width: 30, height: 30),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: _selectedImage != null
                ? Image.file(_selectedImage!, fit: BoxFit.cover)
                : const Center(child: Text("No image selected")),
          ),
          if (_selectedImage != null)
            const Align(
              alignment: Alignment.center,
              child: Icon(Icons.circle_outlined, size: 120, color: Colors.white30),
            ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.small(
              heroTag: 'gallery',
              onPressed: _pickFromGallery,
              backgroundColor: AppColors.blue,
              child: const Icon(Icons.folder, color: Colors.yellow),
            ),
            FloatingActionButton(
              heroTag: 'camera',
              onPressed: _detectAndNavigate,
              backgroundColor: AppColors.blue,
              child: const Icon(Icons.image_search, color: Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }
}
