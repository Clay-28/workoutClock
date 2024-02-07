part of 'Emom_main_bloc.dart';

class EmomEvent{
  EmomEvent();
}

class EmomStart extends EmomEvent{
  int duration;
  EmomStart({required this.duration});
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
  EmomReset();
}