import 'package:equatable/equatable.dart';

abstract class MedicineEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTodayMedicineStatus extends MedicineEvent {}
