import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/camera_button.dart';
import '../widgets/gallery_button.dart';
import '../../data/models/mushroom_result.dart';
import '../../../core/constants/app_colors.dart';
import '../../logic/detection_bloc/detection_bloc.dart';

class CapturePage extends StatefulWidget {
  const CapturePage({super.key});

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetectionBloc, DetectionState>(
      listener: (context, state) {
        if (state is DetectionSuccess) {
          context.push('/detail', extra: {
            'result': MushroomResult(
              label: state.label,
              confidence: state.confidence,
            ),
            'imagePath': _selectedImage?.path ?? '',
          });
        } else if (state is DetectionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Detection failed: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.blue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.yellow),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            "MushCamp",
            style: TextStyle(color: AppColors.yellow, fontWeight: FontWeight.bold),
          ),
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
            BlocBuilder<DetectionBloc, DetectionState>(
              builder: (context, state) {
                if (state is DetectionLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GalleryButton(
                onImagePicked: (image) => setState(() => _selectedImage = image),
              ),
              CameraButton(
                onImagePicked: (image) => setState(() => _selectedImage = image),
              )
            ],
          ),
        ),
      ),
    );
  }
}
