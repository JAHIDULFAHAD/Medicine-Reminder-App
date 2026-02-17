import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_today_medicine_status.dart';
import 'medicine_event.dart';
import 'medicine_state.dart';

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  final GetTodayMedicineStatus getTodayMedicineStatusUseCase;

  MedicineBloc({required this.getTodayMedicineStatusUseCase})
    : super(MedicineInitial()) {
    on<LoadTodayMedicineStatus>((event, emit) async {
      emit(MedicineLoading());
      try {
        final status = await getTodayMedicineStatusUseCase();
        emit(MedicineLoaded(status));
      } catch (e) {
        emit(MedicineError(e.toString()));
      }
    });
  }
}
