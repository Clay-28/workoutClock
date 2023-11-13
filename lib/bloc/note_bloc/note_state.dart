
part of 'note_bloc.dart';

/// States:
/// Initial -> Add Notes : blueAccent
/// onPressed -> Bottom Sheet with Text Field & Timer Pauses
/// Bottom Sheet: white54 or off black[800],
/// Quil package to edit text?
///
/// onClosed -> Resume
///

/// Better to store the value in the bloc or the state?

class NoteState extends Equatable {
  NoteState({this.text = 'Workout Notes'});

  //String title = 'Notes';
  String text;


  @override
  List<Object?> get props => [text];

  NoteState copyWith({
    String? text,
  }){
    return NoteState(
      text: text ?? this.text,
    );
  }

}

class NoteMainState extends NoteState{
  NoteMainState();
}

class NoteOpenState extends NoteState{
  String notes;
  NoteOpenState({required this.notes});
}

class RegisteringHiveState extends NoteState{

}