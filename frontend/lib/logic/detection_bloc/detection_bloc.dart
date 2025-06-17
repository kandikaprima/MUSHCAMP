import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/repositories/mushroom_repository.dart';

part 'detection_event.dart';
part 'detection_state.dart';

class DetectionBloc extends Bloc<DetectionEvent, DetectionState> {
  final MushroomRepository repository;

  DetectionBloc({required this.repository}) : super(DetectionInitial()) {
    on<DetectionStarted>((event, emit) async {
      emit(DetectionLoading());
      try {
        final result = await repository.detectMushroom(File(event.imagePath));
        emit(DetectionSuccess(label: result.label, confidence: result.confidence));
      } catch (e) {
        emit(const DetectionFailure("Gagal mendeteksi jamur."));
      }
    });
  }
}
