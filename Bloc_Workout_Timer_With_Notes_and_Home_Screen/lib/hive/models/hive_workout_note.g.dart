// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_workout_note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveWorkoutNotesAdapter extends TypeAdapter<HiveWorkoutNotes> {
  @override
  final int typeId = 1;

  @override
  HiveWorkoutNotes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveWorkoutNotes(
      title: fields[0] as String,
      text: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveWorkoutNotes obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveWorkoutNotesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
