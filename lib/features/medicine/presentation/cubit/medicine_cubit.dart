import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/medicine_time.dart';
import '../../domain/usecases/add_medicine.dart';
import '../../domain/usecases/get_medicines_by_time.dart';
import '../../domain/usecases/get_today_medicine_status.dart';
import '../../domain/usecases/save_history.dart';
import '../../domain/usecases/get_medicines.dart';
import 'medicine_state.dart';
import '../../domain/entities/medicine.dart';
import '../../domain/entities/history.dart';

class MedicineCubit extends Cubit<MedicineState> {
  final AddMedicine addMedicineUseCase;
  final SaveHistory saveHistoryUseCase;
  final GetTodayMedicineStatus getTodayStatusUseCase;
  final GetMedicines getMedicinesUseCase;
  final GetMedicinesByTime getMedicinesByTime;

  MedicineCubit({
    required this.addMedicineUseCase,
    required this.saveHistoryUseCase,
    required this.getTodayStatusUseCase,
    required this.getMedicinesUseCase,
    required this.getMedicinesByTime,
  }) : super(MedicineInitial()) {
    loadTodayData();
  }

  Future<void> loadData() async {
    emit(MedicineLoading());
    try {
      final medicines = await getMedicinesUseCase();
      final status = await getTodayStatusUseCase(DateTime.now());

      emit(MedicineLoaded(
        medicines: medicines,
        todayStatus: status,
      ));
    } catch (e) {
      emit(MedicineError(e.toString()));
    }
  }

  Future<void> loadTodayData({MedicineTime? time}) async {
    emit(MedicineLoading());
    try {
      List<Medicine> medicines;
      if (time != null) {
        medicines = await getMedicinesByTime(time);
      } else {
        medicines = await getMedicinesUseCase();
      }

      final status = await getTodayStatusUseCase(DateTime.now());

      emit(MedicineLoaded(
        medicines: medicines,
        todayStatus: status,
      ));
    } catch (e) {
      emit(MedicineError(e.toString()));
    }
  }

  Future<void> addMedicine(Medicine medicine) async {
    await addMedicineUseCase(medicine);
    await loadTodayData();
  }

  Future<void> saveHistory(History history) async {
    await saveHistoryUseCase(history);
    await loadTodayData();
  }
}
