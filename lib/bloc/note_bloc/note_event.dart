
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
  final String text;
  UpdateNotes({required this.text});
}

class RegisterHiveEvent extends NoteEvent{
  RegisterHiveEvent();
}