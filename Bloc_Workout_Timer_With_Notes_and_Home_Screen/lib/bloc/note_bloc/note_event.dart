
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
  // passing values here to update the state text value
  final String text;
  CloseNote({required this.text});
}