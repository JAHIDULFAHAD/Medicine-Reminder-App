import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_medicine.dart';
import '../../domain/usecases/get_history.dart';
import '../../domain/usecases/get_today_medicine_status.dart';
import '../../domain/usecases/get_medicines.dart';
import '../../domain/usecases/save_history.dart';
import '../../domain/entities/medicine.dart';
import '../../domain/entities/history.dart';
import 'medicine_state.dart';

class MedicineCubit extends Cubit<MedicineState> {
  final AddMedicine addMedicineUseCase;
  final SaveHistory saveHistoryUseCase;
  final GetTodayMedicineStatus getTodayStatusUseCase;
  final GetMedicines getMedicinesUseCase;
  final GetHistory getHistoryUseCase;

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  MedicineCubit({
    required this.addMedicineUseCase,
    required this.saveHistoryUseCase,
    required this.getTodayStatusUseCase,
    required this.getMedicinesUseCase,
    required this.getHistoryUseCase,
  }) : super(MedicineInitial());

  Future<void> loadData({DateTime? date}) async {
    emit(MedicineLoading());

    if (date != null) {
      _selectedDate = DateTime(date.year, date.month, date.day);
    }

    try {
      final medicines = await getMedicinesUseCase();

      final status = await getTodayStatusUseCase(_selectedDate);

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

  Future<void> addMedicine(Medicine medicine) async {
    await addMedicineUseCase(medicine);
    await loadData();
  }

  Future<void> saveHistory(History history) async {
    await saveHistoryUseCase(history);
    await loadData();
  }

  bool isMedicineActive(Medicine medicine, DateTime date) {
    final diff = date.difference(medicine.createdAt).inDays + 1;
    return medicine.days.contains(diff);
  }

  void changeSelectedDate(DateTime date) {
    _selectedDate = DateTime(date.year, date.month, date.day);
    loadData(date: _selectedDate);
  }
}
