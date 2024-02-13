import 'dart:async';

import 'package:WorkoutClock/bloc/note_bloc/note_bloc.dart';
import 'package:WorkoutClock/bloc/user_note_bloc/user_notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ARAMP_Componets/AMRAP_model.dart';
import '../../../ARAMP_Componets/ARAMP_Scroll_Wheel/Amrap_scroll_wheel_widget.dart';
import '../../../audio/audio_handler.dart';
import '../../../items/ticks.dart';


part 'AMRAP_event.dart';
part 'AMRAP_state.dart';

class AMRAPBloc extends Bloc<AMRAPEvent, AMRAPState> {

  /// sets the audio session to not duck audio, this allows a silent audio mp3 to play,
  /// 0: is a countdown mp3
  /// 1: is a silent mp3
  MyAudioHandler AmrapAudioPlayer = MyAudioHandler(false, 1);

  static int totalDuration = 10 * 60;
  static int roundCount = 0;
  static double pausedDuration = 0;
  static AMRAP_Status Amrap_status = AMRAP_Status.initial;
  int countDown = 10;
  final Ticker _ticker = Ticker();
  StreamSubscription<int>? _AmrapTicks;
  static List<AmrapModel> AmrapsList = [];

  AMRAPBloc() : super(
      AMRAPState(
          status: AMRAP_Status.initial,
          duration: 10, rounds: 0,
          amrapModel: AmrapModel(duration: 10, rounds: 0, description: '')))
  {
    on<AmrapStart>(_onAmrapStart);
    on<AmrapPause>(_onAmrapPause);
    on<AmrapUpdate>(_onAmrapUpdate);
    on<AmrapClose>(_onAmrapClose);
    on<AmrapCountDown>(_onAmrapCountDown);
    on<CreateAmrapModel>(_onCreateAmrapModel);
    on<AmrapUpdateRounds>(_onAmrapUpdateRounds);
    on<UpdateAmrapDescription>(_onUpdateAmrapDescription);
  }

  @override
  initState(){
    NoteBloc().add(UpdateNotes(text: 'Amrap $totalDuration'));
  }


  String fetchTotalAmrapData(){
    String AmrapData = '';
    if(AmrapsList.length >= 1) {
      for (AmrapModel item in AmrapsList) {
        AmrapData += '**Amrap**\n${item.duration} Minutes, ${item.rounds} Rounds\n${item.description ?? 'Custom'}\n\n';
      }
      return '**AMRAP Review**\n${AmrapData}';
    }
    return '';
  }



  void _onAmrapStart(AmrapStart event, Emitter<AMRAPState> emit){

    /// Plays Silent Audio
    /// Is there a way to check if it's playing?

    AmrapAudioPlayer.stop();
    AmrapAudioPlayer = MyAudioHandler(false, 1);
    AmrapAudioPlayer.play();

    print('start: total duration: $totalDuration');
    _AmrapTicks = _ticker.AmrapTick(seconds: state.duration).listen((event) {
      add(AmrapCountDown(duration: event));
    });

  }

  void _onAmrapPause(AmrapPause event, Emitter<AMRAPState> emit){
    pausedDuration = state.duration / totalDuration;
    _AmrapTicks?.pause();
    emit(state.copyWith(status: AMRAP_Status.paused));
  }

  void _onAmrapUpdate(AmrapUpdate event, Emitter<AMRAPState> emit){
    //AmrapScrollWheel.duration = event.duration * 60;
    totalDuration = event.duration! * 60;
    Amrap_status = event.status!;
    int _rounds = event.rounds ?? 0;

    emit(state.copyWith(status: event.status, duration: event.duration! * 60, amrapModel: event.amrapModel, rounds: state.rounds + _rounds ));

    if(event.status == AMRAP_Status.helper){
      emit(state.copyWith(status: AMRAP_Status.helper, duration: event.duration, amrapModel: event.amrapModel, ));
      Future.delayed(const Duration(milliseconds: 100), (){
        ///
        add(AmrapUpdate(duration: event.duration!, amrapModel: event.amrapModel, status: AMRAP_Status.selectingWorkout));
      });
    }

  }

  void _onAmrapClose(AmrapClose event, Emitter<AMRAPState> emit){

    /// Stops Stream
    _AmrapTicks?.cancel();
    /// Resets Scroll Wheel value and Initial item to 10 mins
    AmrapScrollWheel.duration = 10;
    /// Resets Static Variables
    roundCount = 0;
    Amrap_status = AMRAP_Status.initial;
    emit(state.copyWith(status: AMRAP_Status.initial, rounds: 0, amrapModel: AmrapModel(duration: 10, rounds: 0,)));
  }

  void _onAmrapCountDown(AmrapCountDown event, Emitter<AMRAPState> emit){

    if(state.duration >=0){
      emit(state.copyWith(duration: event.duration, status: AMRAP_Status.inProgress));
    }
    print('state.duration: ${state.duration}');
    print('total duration: $totalDuration');

    if(state.duration == 5){
      /// Setting MyAudioHandler == true: adjust the audio session configuration to duck audio
      /// Setting MyAudioHandler == false: adjust the audio session configuration to mix with others
      AmrapAudioPlayer.stop();
      AmrapAudioPlayer = MyAudioHandler(true, 0);
      AmrapAudioPlayer.play();
    }

    // if(state.duration == 0){
    //   print('Amrap Finished');
    //   emit(state.copyWith(status: AMRAP_Status.finished));
    // }

    if(state.duration < 0) {
      emit(state.copyWith(status: AMRAP_Status.finished));
      totalDuration = 10 * 60;
      _AmrapTicks?.cancel();
      AmrapAudioPlayer.stop();
      AmrapAudioPlayer = MyAudioHandler(false, 1);
      AmrapAudioPlayer.play();
    }
  }

  void _onCreateAmrapModel(CreateAmrapModel event, Emitter<AMRAPState> emit){
    /// Used for end of workout summary
    AmrapModel newAmrapWorkout = AmrapModel(duration: (event.duration) , rounds: event.rounds, description: event.description);
    AmrapsList.add(newAmrapWorkout);
    print('Create Amrap Model: ${AmrapsList.length}');
  }


  void AmrapReset(){
    _AmrapTicks?.cancel();
    AmrapsList = [];
    totalDuration = 10 * 60;
    AmrapScrollWheel.duration = 10;
    emit(state.copyWith(rounds: 0, duration: 10, status: AMRAP_Status.initial));
  }

  void _onAmrapUpdateRounds(AmrapUpdateRounds event, Emitter<AMRAPState> emit){
    if(state.rounds > 0){
      print('state.round: ${state.rounds}');
      AmrapsList.last.rounds = AmrapsList.last.rounds! + event.rounds;
      emit(state.copyWith(rounds: state.rounds + event.rounds));
    }if(state.rounds == 0 && event.rounds < 0){
      emit(state.copyWith(rounds: 0));
      AmrapsList.last.rounds = AmrapsList.last.rounds!;
    }if(state.rounds == 0 && event.rounds > 0){
      emit(state.copyWith(rounds: state.rounds + event.rounds));
      AmrapsList.last.rounds = AmrapsList.last.rounds! + event.rounds;
    }

  }

  void _onUpdateAmrapDescription(UpdateAmrapDescription event, Emitter <AMRAPState> emit){
    /// Update the last amrap model then copy with update
    AmrapsList.last.description = event.description;
    emit(state.copyWith(amrapModel: AmrapsList.last));
    print(AmrapsList.last.description);
  }




}