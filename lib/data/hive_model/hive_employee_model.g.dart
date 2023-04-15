// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_employee_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveEmployeeModelAdapter extends TypeAdapter<HiveEmployeeModel> {
  @override
  final int typeId = 0;

  @override
  HiveEmployeeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEmployeeModel(
      name: fields[0] as String,
      role: fields[1] as String,
      fromDate: fields[2] as String,
      toDate: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveEmployeeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.role)
      ..writeByte(2)
      ..write(obj.fromDate)
      ..writeByte(3)
      ..write(obj.toDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEmployeeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
