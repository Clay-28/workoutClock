import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

part 'middle_area_event.dart';
part 'middle_area_state.dart';

class MiddleAreaBloc extends Bloc<MiddleAreaEvent, MiddleAreaState>{


  /// By initializing index = -1, this allows all Middle Area Workouts Borders to be white
  static int amrapWorkoutIndex = -1;
  static bool amrapBorderColor = false;
  static int emomWorkoutIndex = -1;


  /// MiddleAreaStatus {Clock, Amramp, Emom, Tabata, Invisible}
  ///
  MiddleAreaBloc () : super(MiddleAreaState(status: MiddleAreaStatus.Clock, widgetIndex: -1)){
    on<MiddleAreaUpdateState>(_onUpdateState);
    on<ResetMiddleArea>(_onResetMiddleArea);
  }

  void _onUpdateState(MiddleAreaUpdateState event, Emitter<MiddleAreaState> emit) async{
    emit(state.copyWith(
      status: event.status,
      widgetIndex: event.widgetIndex,
      emomWorkoutIndex: event.emomWorkoutIndex,
      emomBorderColor: event.emoBorderColor,
    ));
  }

  void _onResetMiddleArea(ResetMiddleArea event, Emitter<MiddleAreaState> emit){
    emomWorkoutIndex = -1;
    amrapWorkoutIndex = -1;
    state.emomWorkoutIndex = -1;
    emit(state.copyWith(status: event.status, widgetIndex: -1));
  }


}