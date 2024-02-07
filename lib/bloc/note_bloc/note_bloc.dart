

import 'package:WorkoutClock/ARAMP_Componets/AMRAP_model.dart';
import 'package:WorkoutClock/services/workout_note_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../workout_notes/workout_notes.dart';
import '../clock_bloc/clock_bloc.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState>{

  // TextEditingController controller = TextEditingController(
  //     text: 'Workout Notes:\n'
  // );

 //static TextEditingController noteGlobalController = TextEditingController(text:'Workout Notes:\n');
  //List<AmrapModel> AmrapNotes = [];


  WorkoutNotesServices userData = WorkoutNotesServices();
  static NoteStatus globalNoteStatus = NoteStatus.open;

  NoteBloc(): super( RegisteringHiveState(controller: TextEditingController(text:'Workout Notes:\n',))){
    on<OpenNote>(_onOpenNotes);
    on<CloseNote>(_onCloseNotes);
    on<UpdateNotes>(_onUpdateNote);
    on<RegisterHiveEvent>(_onRegisterHive);
    on<AddWorkout>(_onAddWorkout);
    on<HideNotes>(_onHideNotes);
  }


  void _onOpenNotes(OpenNote event, Emitter<NoteState> emit){
    //state.copyWith(noteStatus: NoteStatus.open );
    emit(NoteOpenState(notes: state.text!, controller: TextEditingController()));
  }

  void _onCloseNotes(CloseNote event, Emitter<NoteState> emit){
    state.copyWith(text: event.text, noteStatus: NoteStatus.open );
  }

  void _onUpdateNote(UpdateNotes event, Emitter<NoteState> emit){
    // state.controller.text = '${state.controller.text} \n${event.text}';
    state.text = event.text;
    // noteGlobalController.text = '${state.controller.text} \n${event.text}';
    // String totalAmrapNotes = '';
    // for(AmrapModel item in AmrapNotes) {
    //   totalAmrapNotes += 'Amrap Workout\n${item.description}\n\n';
    // }

    //noteGlobalController = TextEditingController(text: '${state.text}\n\n$totalAmrapNotes');
    //emit(NoteMainState(controller: TextEditingController(text: '${state.text}\n\n$totalAmrapNotes')));

    emit(NoteMainState(controller: TextEditingController(text: '${state.text}'), status: NoteStatus.open));

    print('State.NoteStatus: ${state.noteStatus}');
  }

  void _onAddWorkout(AddWorkout event, Emitter<NoteState> emit){
    /// A Method to add a Workout Directly to the notes

    //state.controller.text = '${state.controller.text} \n\nAmrap\n${event.ArmapWorkout.duration ~/60} Minutes\n';

    // print('\n\nTesting Add Workout ${event.ArmapWorkout.description} ');
    // AmrapNotes.add(event.ArmapWorkout);
    // Future.delayed(Duration(milliseconds: 500), (){
    //   add(UpdateNotes(text: ''));
    // });
   //emit(NoteMainState(controller: TextEditingController(text: '${state.controller.text} \n${}' )));
  }


  void _onRegisterHive(RegisterHiveEvent event, Emitter<NoteState> emit) async {
    await userData.init();
    emit(NoteMainState(controller: TextEditingController(text: 'Workout Notes:\n'), status: NoteStatus.open));
  }

  void _onHideNotes(HideNotes event, Emitter<NoteState> emit){
    globalNoteStatus = event.noteStatus;
    state.noteStatus = event.noteStatus;
    if(event.noteStatus == NoteStatus.open){
      state.copyWith(noteStatus: NoteStatus.open);
      emit(NoteMainState(controller: TextEditingController(text: '${state.text}'), status: event.noteStatus));
      print('\n\n ');
    }else{
      emit(state.copyWith(noteStatus: event.noteStatus));
    }
    state.noteStatus = event.noteStatus;
    print('Note Status = ${state.noteStatus}');
    print('event.noteStatus = ${event.noteStatus}');
  }




}