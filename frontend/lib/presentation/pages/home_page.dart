import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_texts.dart';
import '../../../data/models/mushroom_result.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: RichText(
          text: TextSpan(
            style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
            children: const [
              TextSpan(text: AppTexts.appTitle, style: TextStyle(color: Colors.yellow)),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Image.asset(
                'assets/logo.png',
                width: 30,
                height: 30,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                children: const [
                  TextSpan(text: 'Welcome to '),
                  TextSpan(text: 'Mush', style: TextStyle(color: Colors.blue)),
                  TextSpan(text: 'Camp', style: TextStyle(color: Color(0xFFFFD500))),
                  TextSpan(text: '!'),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(AppTexts.intro, style: GoogleFonts.lato(fontSize: 12, color: Colors.black87)),
            const SizedBox(height: 16),
            Text(AppTexts.guide, style: GoogleFonts.lato(fontSize: 16)),
            const SizedBox(height: 12),
            Text(AppTexts.rule1, style: GoogleFonts.lato(fontSize: 16)),
            Text(AppTexts.rule2, style: GoogleFonts.lato(fontSize: 16)),
            const SizedBox(height: 20),
            Text(AppTexts.info, style: GoogleFonts.lato(fontSize: 16)),
            const SizedBox(height: 20),
            Text("Explore Mushroom Types:", style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: AppTexts.mushroomList.length,
              itemBuilder: (context, index) {
                final name = AppTexts.mushroomList[index];
                final image = AppTexts.mushroomImages[name] ?? '';

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: image.isNotEmpty
                        ? Image.asset(image, width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.image),
                    title: Text(name, style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.push('/detail', extra: {
                        'result': MushroomResult(label: name, confidence: 1.0),
                        'imagePath': image,
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blue,
        onPressed: () => context.push('/capture'),
        child: const Icon(Icons.image_search, color: AppColors.yellow),
      ),
    );
  }
}