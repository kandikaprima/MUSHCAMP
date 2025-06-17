import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/app_colors.dart';
import '../../logic/detection_bloc/detection_bloc.dart';

class CameraButton extends StatelessWidget {
  final ValueChanged<File> onImagePicked;

  const CameraButton({super.key, required this.onImagePicked});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'camera',
      backgroundColor: AppColors.blue,
      onPressed: () async{
        final picker = ImagePicker();
        final picked = await picker.pickImage(source: ImageSource.camera);
        if (picked != null) {
          final image = File(picked.path);
          onImagePicked(image);
          context.read<DetectionBloc>().add(DetectionStarted(image.path));
        }
      },
      child: const Icon(Icons.image_search, color: AppColors.yellow),
    );
  }
}
