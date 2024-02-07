

part of 'middle_area_bloc.dart';

enum MiddleAreaStatus {Clock, Amramp, Emom, Tabata, Invisible}

class MiddleAreaState{
  int? widgetIndex;
  MiddleAreaStatus status;
  int? emomWorkoutIndex;
  bool? emomBorderColor;
  MiddleAreaState({
    required this.status,
    this.widgetIndex,
    this.emomWorkoutIndex = -1,
    this.emomBorderColor = false,
  });

  MiddleAreaState copyWith({
    int? widgetIndex,
    MiddleAreaStatus? status,
    int? emomWorkoutIndex,
    bool? emomBorderColor,
  }){
    return MiddleAreaState(
      status: status?? this.status,
      widgetIndex: widgetIndex ?? this.widgetIndex,
      emomWorkoutIndex: emomWorkoutIndex ?? this.emomWorkoutIndex,
      emomBorderColor: emomBorderColor ?? this.emomBorderColor,
    );
  }


}