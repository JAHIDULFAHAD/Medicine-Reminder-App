// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineModelAdapter extends TypeAdapter<MedicineModel> {
  @override
  final int typeId = 0;

  @override
  MedicineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicineModel(
      id: fields[0] as String,
      name: fields[1] as String,
      times: (fields[2] as List).cast<MedicineTime>(),
      days: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MedicineModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.times)
      ..writeByte(3)
      ..write(obj.days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
