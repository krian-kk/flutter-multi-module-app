// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_details_h_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaseDetailsHiveModelAdapter extends TypeAdapter<CaseDetailsHiveModel> {
  @override
  final int typeId = 0;

  @override
  CaseDetailsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaseDetailsHiveModel(
      status: fields[0] as int,
      message: fields[1] as String,
      result: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, CaseDetailsHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaseDetailsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
