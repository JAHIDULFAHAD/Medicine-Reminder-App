import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_medicine.dart';
import '../../domain/usecases/get_today_medicine_status.dart';
import '../../domain/usecases/save_history.dart';
import 'medicine_state.dart';
import '../../domain/entities/medicine.dart';
import '../../domain/entities/history.dart';
import '../../domain/repositories/medicine_repository.dart';

class MedicineCubit extends Cubit<MedicineState> {
  final AddMedicine addMedicineUseCase;
  final SaveHistory saveHistoryUseCase;
  final GetTodayMedicineStatus getTodayStatusUseCase;
  final MedicineRepository repository;

  MedicineCubit({
    required this.addMedicineUseCase,
    required this.saveHistoryUseCase,
    required this.getTodayStatusUseCase,
    required this.repository,
  }) : super(MedicineInitial());

  Future<void> loadData() async {
    emit(MedicineLoading());
    try {
      final medicines = await repository.getMedicines();
      final status = await getTodayStatusUseCase();

      emit(MedicineLoaded(medicines: medicines, todayStatus: status));
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
}
