import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState>{


  NoteBloc(): super( NoteMainState()){
    on<OpenNote>(_onOpenNotes);
    on<CloseNote>(_onCloseNotes);
  }

  void _onOpenNotes(OpenNote event, Emitter<NoteState> emit){
    emit(NoteOpenState(notes: state.text));
  }

  void _onCloseNotes(CloseNote event, Emitter<NoteState> emit){
    state.copyWith(text: event.text);
  }
}