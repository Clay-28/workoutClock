
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
  NoteState({
  this.text = 'Workout Notes:',
  required this.controller ,
  this.noteStatus = NoteStatus.open,
  required this.locked,
  });

  //String title = 'Notes';
  NoteStatus? noteStatus;
  String text;
  TextEditingController controller =  TextEditingController(
  text: 'Workout Notes:\n');
  bool locked;

  @override
  List<Object?> get props => [text];

  NoteState copyWith({
    String? text,
    TextEditingController ? controller,
    NoteStatus ? noteStatus,
    bool? locked,
  }){
    return NoteState(
      text: text ?? this.text,
      controller: controller ?? this.controller,
      noteStatus: noteStatus ?? this.noteStatus,
      locked: locked ?? this.locked

    );
  }

}

class NoteMainState extends NoteState{
  NoteStatus status;
  NoteMainState({
    required super.controller,
    required this.status,
    required super.locked
  });
}

class NoteOpenState extends NoteState{
  String notes;
  NoteOpenState({
    required this.notes,
    required super.controller,
    required super.locked
  });
}

class RegisteringHiveState extends NoteState{
  RegisteringHiveState({
    required super.controller,
    required super.locked,
  });
}

class HiddenNotes extends NoteState{
  HiddenNotes({
    required super.controller,
    required super.locked
  });
}

