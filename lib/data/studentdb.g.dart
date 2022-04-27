// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studentdb.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentDbAdapter extends TypeAdapter<StudentDb> {
  @override
  final int typeId = 0;

  @override
  StudentDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentDb(
      name: fields[0] as String,
      age: fields[1] as String,
      domain: fields[2] as String,
      imageUrl: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StudentDb obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.domain)
      ..writeByte(3)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
