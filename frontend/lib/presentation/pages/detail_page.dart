import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_texts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/mushroom_result.dart';

class DetailPage extends StatelessWidget {
  final MushroomResult result;
  final String imagePath;

  const DetailPage({super.key, required this.result, required this.imagePath});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAsset = imagePath.startsWith('assets/');
    final wikiUrl = 'https://en.wikipedia.org/wiki/${result.label}';

    Widget imageWidget = isAsset
        ? Image.asset(imagePath, width: double.infinity, height: 250, fit: BoxFit.cover)
        : Image.file(File(imagePath), width: double.infinity, height: 250, fit: BoxFit.cover);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.yellow),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("MushCamp", style: TextStyle(color: AppColors.yellow)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: AppColors.yellow,
              child: Image.asset('assets/logo.png', width: 24, height: 24),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          imageWidget,
          Expanded(
            child: Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(result.label, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Divider(
                    color: AppColors.yellow,
                    thickness: 2,
                  ),
                  const SizedBox(height: 6),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Confidence: '),
                        TextSpan(
                          text: '${(result.confidence * 100).toStringAsFixed(2)}%',
                          style: const TextStyle(fontWeight: FontWeight.bold)
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Penjelasan Lebih Lanjut:',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => _launchURL(wikiUrl),
                    child: Text(
                      wikiUrl,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 30,
        color: AppColors.yellow,
        alignment: Alignment.center,
        child: const Text(
          AppTexts.credit,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}