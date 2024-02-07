
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



enum NoteStatus {hidden, open}

class NoteState extends Equatable {
  NoteState({this.text = 'Workout Notes:', required this.controller , this.noteStatus = NoteStatus.open});

  //String title = 'Notes';
  NoteStatus? noteStatus;
  String text;
  TextEditingController controller =  TextEditingController(
  text: 'Workout Notes:\n');

  @override
  List<Object?> get props => [text];

  NoteState copyWith({
    String? text,
    TextEditingController ? controller,
    NoteStatus ? noteStatus
  }){
    return NoteState(
      text: text ?? this.text,
      controller: controller ?? this.controller,
      noteStatus: noteStatus ?? this.noteStatus
    );
  }

}

class NoteMainState extends NoteState{
  NoteStatus status;
  NoteMainState({required super.controller, required this.status});
}

class NoteOpenState extends NoteState{
  String notes;
  NoteOpenState({required this.notes, required super.controller});
}

class RegisteringHiveState extends NoteState{
  RegisteringHiveState({required super.controller});
}

class HiddenNotes extends NoteState{
  HiddenNotes({required super.controller});
}

