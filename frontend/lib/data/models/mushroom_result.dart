class MushroomResult {
  final String label;
  final double confidence;

  MushroomResult({required this.label, required this.confidence});

  factory MushroomResult.fromJson(Map<String, dynamic> json) {
    return MushroomResult(
      label: json['label'],
      confidence: (json['confidence'] as num).toDouble(),
    );
  }
}
