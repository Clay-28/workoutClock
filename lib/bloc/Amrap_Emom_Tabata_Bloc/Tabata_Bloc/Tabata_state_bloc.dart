
part of 'Tabata_bloc.dart';



enum TabataStatus {setup, paused, inProgress, helper, selectingWorkout, finished, resting}
enum IntervalStatus {working, resting}
class TabataState {
  TabataStatus status;
  int rounds;
  int totalDuration;
  int restInterval;
  int interval;
  int roundControllerIndex;
  int intervalControllerIndex;
  int restControllerIndex;
  TabataModel tabataModel;
  FixedExtentScrollController roundController;
  FixedExtentScrollController durationController;
  FixedExtentScrollController restController;
  String description;
  IntervalStatus intervalStatus;

  TabataState({
    required this.status,
    required this.rounds,
    required this.totalDuration,
    required this.interval,
    required this.restInterval,
    required this.tabataModel,
    required this.durationController,
    required this.restController,
    required this.roundController,
    required this.intervalControllerIndex,
    required this.restControllerIndex,
    required this.roundControllerIndex,
    required this.description,
    required this.intervalStatus

  });

  TabataState copyWith({
    TabataStatus? status,
    String? description,
    int? rounds,
    int? totalDuration,
    int? restInterval,
    int? interval,
    int? intervalControllerIndex,
    int? restControllerIndex,
    int? roundControllerIndex,
    TabataModel? tabataModel,
    FixedExtentScrollController? durationController,
    FixedExtentScrollController? restController,
    FixedExtentScrollController? roundController,
    IntervalStatus? intervalStatus,


  }){
    return TabataState(
      status: status ?? this.status,
      rounds: rounds ?? this.rounds,
      totalDuration: totalDuration ?? this.totalDuration,
      interval: interval ?? this.interval,
      restInterval: restInterval ?? this.restInterval,
      tabataModel: tabataModel ?? this.tabataModel,
      durationController: durationController ?? this.durationController,
      restController: restController ?? this.restController,
      roundController: roundController ?? this.roundController,
      intervalControllerIndex: intervalControllerIndex ?? this.intervalControllerIndex,
      restControllerIndex: restControllerIndex ?? this.restControllerIndex,
      roundControllerIndex: roundControllerIndex ?? this.roundControllerIndex,
      description: description ?? this.description,
      intervalStatus: intervalStatus ?? this.intervalStatus

    );
  }
}