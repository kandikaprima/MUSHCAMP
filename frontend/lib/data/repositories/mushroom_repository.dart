import 'dart:io';
import 'package:dio/dio.dart';
import '../models/mushroom_result.dart';

class MushroomRepository {
  final Dio _dio = Dio();

  Future<MushroomResult> detectMushroom(File imageFile) async {
    const url = 'http://10.0.2.2:5000/predict';

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
    });

    final response = await _dio.post(url, data: formData);

    final List<dynamic> pred = response.data['prediction'][0];
    final int maxIdx = pred.indexWhere((e) => e == pred.reduce((a, b) => a > b ? a : b));
    final labels = [
      'Agaricus',
      'Amanita',
      'Cortinarius',
      'Entoloma',
      'Hygrocybe',
      'Lactarius',
      'Russula',
      'Suillus',
    ];

    return MushroomResult(
      label: labels[maxIdx],
      confidence: pred[maxIdx],
    );
  }
}
