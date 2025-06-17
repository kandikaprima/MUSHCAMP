part of 'detection_bloc.dart';

abstract class DetectionState extends Equatable {
  const DetectionState();

  @override
  List<Object?> get props => [];
}

class DetectionInitial extends DetectionState {}

class DetectionLoading extends DetectionState {}

class DetectionSuccess extends DetectionState {
  final String label;
  final double confidence;

  const DetectionSuccess({required this.label, required this.confidence});

  @override
  List<Object?> get props => [label, confidence];
}

class DetectionFailure extends DetectionState {
  final String message;

  const DetectionFailure(this.message);

  @override
  List<Object?> get props => [message];
}
