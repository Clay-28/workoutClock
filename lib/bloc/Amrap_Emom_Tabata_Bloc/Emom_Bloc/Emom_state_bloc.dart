part of 'Emom_main_bloc.dart';


/// The purpose of the helper function is to rebuild the
/// Horizontal Scroll to update the FixedExtentScrollController
/// Logic -> Create a copy, Update the
enum EmomStatus {setup, paused, inProgress, selectingWorkout, helper, finished}

class EmomState {
  int totalDuration;
  int interval;
  String? description;
  EmomStatus status;
  int? forScrollWheelIndex;
  int? everyScrollWheelIndex;
  int? rounds;
  String? forScrollText;
  String? everyScrollText;
  EmomModel emomModel;
  FixedExtentScrollController everyController;
  FixedExtentScrollController forController;
  //List<EmomModel>? emomWorkouts;


  EmomState({
    required this.emomModel,
    required this.interval,
    required this.totalDuration,
    required this.status,
    required this.everyController,
    required this.forController,
    this.description,
    this.forScrollWheelIndex,
    this.everyScrollWheelIndex,
    this.everyScrollText,
    this.forScrollText,
    //this.emomWorkouts,
    this.rounds,
  });

  EmomState copyWith({
    int? totalDuration,
    int? interval,
    EmomStatus? status,
    String? description,
    int? forScrollWheelIndex,
    int? everyScrollWheelIndex,
    String? everyScrollText,
    String? forScrollText,
    EmomModel? emomModel,
    FixedExtentScrollController? forController,
    FixedExtentScrollController? everyController,
    List<EmomModel>? emomWorkouts,
    int? rounds,
  }){
    return EmomState(
      interval: interval ?? this.interval,
      totalDuration: totalDuration ?? this.totalDuration,
      description: description ?? this.description,
      status: status?? this.status,
      forScrollWheelIndex: forScrollWheelIndex ?? this.forScrollWheelIndex,
      everyScrollWheelIndex: everyScrollWheelIndex ?? this.everyScrollWheelIndex,
      everyScrollText: everyScrollText ?? this.everyScrollText,
      forScrollText: forScrollText ?? this.forScrollText,
      emomModel: emomModel ?? this.emomModel,
      forController: forController ?? this.forController,
      everyController: everyController ?? this.everyController,
      //emomWorkouts: emomWorkouts ?? this.emomWorkouts,
      rounds: rounds ?? this.rounds,
    );
  }


}