import 'package:flutter_bloc/flutter_bloc.dart';
import 'detection_event.dart';
import 'detection_state.dart';

class DetectionBloc extends Bloc<DetectionEvent, DetectionState> {
  DetectionBloc() : super(DetectionInitial()) {
    on<DetectionStarted>((event, emit) async {
      emit(DetectionLoading());

      // Simulasi loading deteksi
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Panggil API ke GCP di sini
      emit(const DetectionSuccess(label: 'Agaricus', confidence: 0.92));
    });
  }
}
