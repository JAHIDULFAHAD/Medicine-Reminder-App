import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/medicine_time.dart';
import '../../domain/usecases/add_medicine.dart';
import '../../domain/usecases/get_history.dart';
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
  final GetHistory getHistoryUseCase;

  MedicineCubit({
    required this.addMedicineUseCase,
    required this.saveHistoryUseCase,
    required this.getTodayStatusUseCase,
    required this.getMedicinesUseCase,
    required this.getMedicinesByTime,
    required this.getHistoryUseCase,
  }) : super(MedicineInitial()) {
    loadTodayData();
  }

  Future<void> loadData() async {
    emit(MedicineLoading());
    try {
      final medicines = await getMedicinesUseCase();
      final status = await getTodayStatusUseCase(DateTime.now());
      final histories = await getHistoryUseCase();

      emit(
        MedicineLoaded(
          medicines: medicines,
          todayStatus: status,
          histories: histories,
        ),
      );
    } catch (e) {
      emit(MedicineError(e.toString()));
    }
  }

  Future<void> loadTodayData({MedicineTime? time}) async {
    try {
      final medicines = time != null
          ? await getMedicinesByTime(time)
          : await getMedicinesUseCase();

      final status = await getTodayStatusUseCase(DateTime.now());
      final histories = await getHistoryUseCase();

      emit(MedicineLoaded(
        medicines: medicines,
        todayStatus: status,
        histories: histories,
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
