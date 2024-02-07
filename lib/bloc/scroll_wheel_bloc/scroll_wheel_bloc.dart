import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'scroll_wheel_event.dart';
part 'scroll_wheel_state.dart';

class ScrollWheelBloc extends Bloc<ScrollEvent, ScrollWheelState>{

  static int breakminutes = 1;
  static int breakseconds= 30;


  ScrollWheelBloc(): super(ScrollWheelInitial(minSelected: breakminutes, secondSelected: breakseconds)){
    on<OpenScrollWheel>(_onOpenScrollWheel);
    on<CloseScrollWheel>(_onCloseScrollWheel);
    on<UpdateScrollWheel>(_onUpdateScrollWheel);
    on<VanishScrollWheel>(_onVanishScrollWheel);
  }

  void _onOpenScrollWheel(OpenScrollWheel event, Emitter<ScrollWheelState> emit){
    emit(ScrollWheelInProgress());
  }

  _onCloseScrollWheel(CloseScrollWheel event, Emitter<ScrollWheelState> emit) {
    emit(ScrollWheelInitial(minSelected: event.breakMinutes, secondSelected: event.breakSeconds));
  }

  void _onUpdateScrollWheel(UpdateScrollWheel event, Emitter<ScrollWheelState> state){
    // userSelectedMinutes = event.breakMinutes;
    // userSelectedSeconds = event.breakSeconds;
    breakminutes = event.breakMinutes;
    breakseconds = event.breakSeconds;
    emit(ScrollWheelUpdate(minSelected: event.breakMinutes, secondSelected: event.breakSeconds));
  }

  void _onVanishScrollWheel(VanishScrollWheel event, Emitter<ScrollWheelState> state){
    emit(ScrollWheelVanish());
  }


}