import 'package:WorkoutClock/services/workout_note_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState>{

  WorkoutNotesServices userData = WorkoutNotesServices();

  NoteBloc(): super( RegisteringHiveState() ){
    on<OpenNote>(_onOpenNotes);
    on<CloseNote>(_onCloseNotes);
    on<UpdateNotes>(_onUpdateNote);
    on<RegisterHiveEvent>(_onRegisterHive);
  }


  void _onOpenNotes(OpenNote event, Emitter<NoteState> emit){
    emit(NoteOpenState(notes: state.text!));
  }

  void _onCloseNotes(CloseNote event, Emitter<NoteState> emit){
    state.copyWith(text: event.text);
  }

  void _onUpdateNote(UpdateNotes event, Emitter<NoteState> emit){
    state.text = event.text;
  }

  void _onRegisterHive(RegisterHiveEvent event, Emitter<NoteState> emit) async {
    await userData.init();
    emit(NoteMainState());
  }


}