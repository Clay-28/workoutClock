
part of 'note_bloc.dart';

class NoteEvent extends Equatable{
  NoteEvent();

  @override
  List<Object> get props => [];
}

class OpenNote extends NoteEvent{
  OpenNote();
}

class CloseNote extends NoteEvent{
  final String text;
  CloseNote({required this.text});
}

class UpdateNotes extends NoteEvent{
  final String? text;
  bool? finished;
  int? duration;
  bool? locked;

  UpdateNotes({ this.text, this.finished, this.duration, this.locked});
}

class AddWorkout extends NoteEvent{
  final AmrapModel ArmapWorkout;
  AddWorkout({required this.ArmapWorkout});
}

class RegisterHiveEvent extends NoteEvent{
  RegisterHiveEvent();
}

class HideNotes extends NoteEvent{
  NoteStatus noteStatus;
  HideNotes({required this.noteStatus});
}