import 'package:equatable/equatable.dart';
import '../../domain/entities/history.dart';
import '../../domain/entities/medicine.dart';
import '../../domain/entities/medicine_time.dart';

abstract class MedicineState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MedicineInitial extends MedicineState {}

class MedicineLoading extends MedicineState {}

class MedicineLoaded extends MedicineState {
  final List<Medicine> medicines;
  final Map<String, Map<MedicineTime, bool>> todayStatus;
  final List<History> histories;

  MedicineLoaded({
    required this.medicines,
    required this.todayStatus,
    required this.histories,
  });

  @override
  List<Object?> get props => [medicines, todayStatus, histories];
}

class MedicineError extends MedicineState {
  final String message;

  MedicineError(this.message);

  @override
  List<Object?> get props => [message];
}
