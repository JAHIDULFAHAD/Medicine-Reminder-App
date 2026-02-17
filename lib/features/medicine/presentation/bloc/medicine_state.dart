import 'package:equatable/equatable.dart';
import '../../domain/entities/medicine_time.dart';

abstract class MedicineState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MedicineInitial extends MedicineState {}

class MedicineLoading extends MedicineState {}

class MedicineLoaded extends MedicineState {
  final Map<String, Map<MedicineTime, bool>> status;

  MedicineLoaded(this.status);

  @override
  List<Object?> get props => [status];
}

class MedicineError extends MedicineState {
  final String message;
  MedicineError(this.message);

  @override
  List<Object?> get props => [message];
}
