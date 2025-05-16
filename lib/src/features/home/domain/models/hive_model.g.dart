// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InformationHiveModelAdapter extends TypeAdapter<InformationHiveModel> {
  @override
  final int typeId = 0;

  @override
  InformationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InformationHiveModel(
      id: fields[0] as int,
      name: fields[1] as String,
      status: fields[2] as String,
      image: fields[3] as String,
      species: fields[4] as String,
      gender: fields[5] as String,
      locationName: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InformationHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.species)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.locationName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InformationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
