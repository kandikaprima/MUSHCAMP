import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/app_colors.dart';

class GalleryButton extends StatelessWidget {
  final ValueChanged<File> onImagePicked;

  const GalleryButton({super.key, required this.onImagePicked});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: 'gallery',
      backgroundColor: AppColors.blue,
      onPressed: () async {
        final picker = ImagePicker();
        final picked = await picker.pickImage(source: ImageSource.gallery);
        if (picked != null) {
          onImagePicked(File(picked.path));
        }
      },
      child: const Icon(Icons.folder, color: AppColors.yellow,),
    );
  }
}
