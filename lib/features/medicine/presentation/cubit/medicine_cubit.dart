import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/notification_service.dart';
import '../../domain/entities/medicine_time.dart';
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
  final NotificationService notificationService;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  final Map<String, List<int>> _medicineDayOptions = {
    'Paracetamol': [7, 14, 21],
    'Antibiotic': [15, 30],
    'Vitamin C': [7, 30],
    'Aspirin': [1, 5, 10],
  };

  MedicineCubit({
    required this.addMedicineUseCase,
    required this.saveHistoryUseCase,
    required this.getTodayStatusUseCase,
    required this.getMedicinesUseCase,
    required this.getHistoryUseCase,
    required this.notificationService,
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
          medicineDays: _medicineDayOptions,
        ),
      );
    } catch (e) {
      emit(MedicineError(e.toString()));
    }
  }

  Future<void> addMedicine(Medicine medicine) async {
    await addMedicineUseCase(medicine);
    await loadData();
    await refreshNotifications();
  }

  Future<void> saveHistory(History history) async {
    await saveHistoryUseCase(history);
    await loadData();
  }

  bool isMedicineActive(Medicine medicine, DateTime date) {
    final diff = date.difference(medicine.createdAt).inDays + 1;
    return medicine.days.contains(diff);
  }

  Future<void> refreshNotifications() async {
    final medicines = await getMedicinesUseCase();

    final Map<MedicineTime, List<String>> grouped = {};

    // Group medicines by time
    for (final medicine in medicines) {
      for (final time in medicine.times) {
        grouped.putIfAbsent(time, () => []);
        grouped[time]!.add(medicine.name);
      }
    }

    // Schedule notification
    for (final entry in grouped.entries) {
      final time = entry.key;
      final names = entry.value.join(', ');

      final id = _getNotificationId(time);

      if (names.isEmpty) {
        await notificationService.cancelNotification(id);
        continue;
      }

      await notificationService.scheduleDailyNotification(
        id: id,
        title: "Medicine Reminder 💊",
        body: "Take: $names",
        hour: _getHour(time),
        minute: 0,
      );
    }
  }

  int _getNotificationId(MedicineTime time) {
    return switch (time) {
      MedicineTime.morning => 1,
      MedicineTime.noon => 2,
      MedicineTime.night => 3,
    };
  }

  int _getHour(MedicineTime time) {
    return switch (time) {
      MedicineTime.morning => 12,
      MedicineTime.noon => 16,
      MedicineTime.night => 22,
    };
  }

  void changeSelectedDate(DateTime date) {
    _selectedDate = DateTime(date.year, date.month, date.day);
    loadData(date: _selectedDate);
  }

  List<int> getDaysForMedicine(String medicineName) {
    return _medicineDayOptions[medicineName] ?? [];
  }
}
