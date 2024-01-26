import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'AMRAP_event.dart';
part 'AMRAP_state.dart';

class AMRAPBloc extends Bloc<AMRAPEvent, AMRAPState> {

  static int totalDuration = 10 * 60;
  static int testCount = 0;

  AMRAPBloc() : super(AMRAPState(status: AMRAP_Status.initial, duration: totalDuration, rounds: 0)) {
    on<AmrapStart>(_onAmrapStart);
    on<AmrapPause>(_onAmrapPause);
    on<AmrapUpdate>(_onAmrapUpdate);
  }


  void _onAmrapStart(AmrapStart event, Emitter<AMRAPState> emit){
   emit(state.copyWith(status: AMRAP_Status.inProgress));
  }

  void _onAmrapPause(AmrapPause event, Emitter<AMRAPState> emit){
    emit(state.copyWith(status: AMRAP_Status.paused));
  }

  void _onAmrapUpdate(AmrapUpdate event, Emitter<AMRAPState> emit){
    emit(state.copyWith(duration: event.duration,));
  }

  void addRound(){
    testCount+=1;
  }

  void subtractRound(){
    if(testCount > 0 ){
      testCount-=1;
    }
  }





}