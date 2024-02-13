part of 'Emom_main_bloc.dart';

class EmomEvent{
  EmomEvent();
}

class EmomStart extends EmomEvent{
  int? duration;
  EmomStart({this.duration});
}

class EmomPaused extends EmomEvent{
  EmomPaused();
}

class EmomUpdate extends EmomEvent{
  int? totalDuration;
  EmomStatus? emomStatus;
  int?  interval;
  String? description;
  int? forScrollWheelIndex;
  int? everyScrollWheelIndex;
  EmomModel? emomModel;
  FixedExtentScrollController? everyController;
  FixedExtentScrollController? forController;
  EmomUpdate({
    this.totalDuration,
    this.emomStatus,
    this.description,
    this.interval,
    this.forScrollWheelIndex,
    this.everyScrollWheelIndex,
    this.emomModel,
    this.everyController,
    this.forController
  });
}

class EmomReset extends EmomEvent{
  bool fullReset;
  EmomReset({required this.fullReset});
}

class CreateEmomModel extends EmomEvent{
  String? description;
  int? totalDuration;
  int? interval;
  int? rounds;
  CreateEmomModel({
    this.description,
    this.interval,
    this.totalDuration,
    this.rounds});

}

class EmomTicked extends EmomEvent{
  EmomTicked({ required this.duration,});
  final int duration;
}

class EmomDurationTicked extends EmomEvent{
  EmomDurationTicked({ required this.totalDuration});
  final int totalDuration;
}

class EmomDurationStart extends EmomEvent{
  EmomDurationStart({this.totalDuration});
  int? totalDuration;
}