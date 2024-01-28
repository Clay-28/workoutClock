import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ARAMP_Componets/ARAMP_Scroll_Wheel/Amrap_scroll_wheel_widget.dart';
import '../../../items/ticks.dart';


part 'AMRAP_event.dart';
part 'AMRAP_state.dart';

class AMRAPBloc extends Bloc<AMRAPEvent, AMRAPState> {

  static int totalDuration = 10 * 60;
  static int roundCount = 0;
  int countDown = 10;
  final Ticker _ticker = Ticker();
  StreamSubscription<int>? _AmrapTicks;

  AMRAPBloc() : super(AMRAPState(status: AMRAP_Status.initial, duration: totalDuration, rounds: 0)) {
    on<AmrapStart>(_onAmrapStart);
    on<AmrapPause>(_onAmrapPause);
    on<AmrapUpdate>(_onAmrapUpdate);
    on<AmrapClose>(_onAmrapClose);
    on<AmrapCountDown>(_onAmrapCountDown);
  }


  void _onAmrapStart(AmrapStart event, Emitter<AMRAPState> emit){

    _AmrapTicks = _ticker.AmrapTick(seconds: state.duration).listen((event) {
      add(AmrapCountDown(duration: event));
    });

  }

  void _onAmrapPause(AmrapPause event, Emitter<AMRAPState> emit){
    _AmrapTicks?.pause();
    emit(state.copyWith(status: AMRAP_Status.paused));
  }

  void _onAmrapUpdate(AmrapUpdate event, Emitter<AMRAPState> emit){
    emit(state.copyWith(status: event.status, duration: event.duration));
  }

  void _onAmrapClose(AmrapClose event, Emitter<AMRAPState> emit){
    _AmrapTicks?.cancel();
    AmrapScrollWheel.duration = 10;
    emit(state.copyWith(status: AMRAP_Status.initial,));
  }

  void _onAmrapCountDown(AmrapCountDown event, Emitter<AMRAPState> emit){

      emit(state.copyWith(duration: event.duration, status: AMRAP_Status.inProgress));
      print(state.duration);

    if(state.duration < 0) {
      _AmrapTicks?.cancel();
      emit(state.copyWith(duration: 10, status: AMRAP_Status.paused));
    }


  }

  void addRound(){
    roundCount+=1;
  }

  void subtractRound(){
    if(roundCount > 0 ){
      roundCount-=1;
    }
  }





}