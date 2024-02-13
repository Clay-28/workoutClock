
part of 'Tabata_bloc.dart';


class TabataEvent {
  TabataEvent();
}

class UpdateTabata extends TabataEvent{
  int? roundControllerIndex;
  int? intervalControllerIndex;
  int? restControllerIndex;
  int? totalDuration;
  int? interval;
  int? restInterval;
  int? rounds;
  TabataModel? tabataModel;
  FixedExtentScrollController? workController;
  FixedExtentScrollController? restController;
  TabataStatus? status;
  String? description;

  UpdateTabata({
    this.restInterval,
    this.interval,
    this.totalDuration,
    this.restController,
    this.workController,
    this.rounds,
    this.tabataModel,
    this.status,
    this.description,
    this.intervalControllerIndex,
    this.restControllerIndex,
    this.roundControllerIndex,
  });
}

class TabataReset extends TabataEvent{
  bool fullReset;
  TabataReset({required this.fullReset});
}

class TabataStartInterval extends TabataEvent{
  int duration;
  TabataStartInterval({required this.duration});
}

class TabataStartRestInterval extends TabataEvent{
  int restDuration;
  TabataStartRestInterval({required this.restDuration});
}

class TabataPause extends TabataEvent{
  TabataPause();
}

class CreateTabataWorkout extends TabataEvent{
  CreateTabataWorkout();
}

class TabataTicked extends TabataEvent{
  TabataTicked({ required this.duration,});
  final int duration;
}

class TabataRestingTicked extends TabataEvent{
  TabataRestingTicked({ required this.duration,});
  final int duration;
}