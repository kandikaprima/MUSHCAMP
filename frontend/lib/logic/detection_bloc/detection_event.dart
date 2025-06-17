part of 'detection_bloc.dart';

abstract class DetectionEvent extends Equatable {
  const DetectionEvent();

  @override
  List<Object?> get props => [];
}

class DetectionStarted extends DetectionEvent {
  final String imagePath; // bisa juga pakai File kalau nanti perlu

  const DetectionStarted(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}
