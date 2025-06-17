import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/mushroom_result.dart';

class MushroomTile extends StatelessWidget {
  final String name;
  final String image;

  const MushroomTile({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: image.isNotEmpty
            ? Image.asset(image, width: 50, height: 50, fit: BoxFit.cover)
            : const Icon(Icons.image_not_supported),
        title: Text(
          name,
          style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          context.push('/detail', extra: {
            'result': MushroomResult(label: name, confidence: 1.0),
            'imagePath': image,
          });
        },
      ),
    );
  }
}
