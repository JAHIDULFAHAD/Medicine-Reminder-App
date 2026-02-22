// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_time.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineTimeAdapter extends TypeAdapter<MedicineTime> {
  @override
  final int typeId = 2;

  @override
  MedicineTime read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MedicineTime.morning;
      case 1:
        return MedicineTime.noon;
      case 2:
        return MedicineTime.night;
      default:
        return MedicineTime.morning;
    }
  }

  @override
  void write(BinaryWriter writer, MedicineTime obj) {
    switch (obj) {
      case MedicineTime.morning:
        writer.writeByte(0);
        break;
      case MedicineTime.noon:
        writer.writeByte(1);
        break;
      case MedicineTime.night:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
