// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgendaModelAdapter extends TypeAdapter<AgendaModel> {
  @override
  final int typeId = 0;

  @override
  AgendaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AgendaModel(
      startingTime: fields[0] as String,
      endingTime: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String,
      members: (fields[4] as List).cast<String>(),
      id: fields[5] as String,
      date: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AgendaModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.startingTime)
      ..writeByte(1)
      ..write(obj.endingTime)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.members)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgendaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
