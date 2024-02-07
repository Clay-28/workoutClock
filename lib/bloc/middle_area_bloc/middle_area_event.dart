
part of 'middle_area_bloc.dart';


class MiddleAreaEvent{
  MiddleAreaEvent();
}

class MiddleAreaUpdateState extends MiddleAreaEvent{
  int? widgetIndex;
  MiddleAreaStatus status;
  int? emomWorkoutIndex;
  bool? emoBorderColor;
  MiddleAreaUpdateState({
    required this.status,
    this.widgetIndex,
    this.emomWorkoutIndex,
    this.emoBorderColor,
  });
}

class ResetMiddleArea extends MiddleAreaEvent{
  MiddleAreaStatus status;
  ResetMiddleArea({required this.status});
}