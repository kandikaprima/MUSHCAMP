import 'package:equatable/equatable.dart';

class MushroomResult extends Equatable {
  final String label;
  final double confidence;

  const MushroomResult({required this.label, required this.confidence});

  factory MushroomResult.fromJson(Map<String, dynamic> json) {
    return MushroomResult(
      label: json['label'],
      confidence: (json['confidence'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'confidence': confidence,
    };
  }

  @override
  List<Object?> get props => [label, confidence];
}
