// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_workout_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserWorkoutNotesAdapter extends TypeAdapter<UserWorkoutNotes> {
  @override
  final int typeId = 1;

  @override
  UserWorkoutNotes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserWorkoutNotes(
      workoutNotes: fields[0] as String,
      day: fields[3] as int,
      year: fields[1] as String,
      weekDay: fields[4] as int,
      month: fields[2] as String,
      workoutTime: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserWorkoutNotes obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.workoutNotes)
      ..writeByte(1)
      ..write(obj.year)
      ..writeByte(2)
      ..write(obj.month)
      ..writeByte(3)
      ..write(obj.day)
      ..writeByte(4)
      ..write(obj.weekDay)
      ..writeByte(5)
      ..write(obj.workoutTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserWorkoutNotesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
