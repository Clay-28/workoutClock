
part of 'AMRAP_bloc.dart';


/// pause, start, update, add round, decrease round,

class AMRAPEvent {

  AMRAPEvent();
}

class AmrapStart extends AMRAPEvent {
  int duration;

  AmrapStart({required this.duration});
}

class AmrapPause extends AMRAPEvent {
  AmrapPause();
}

class AmrapUpdate extends AMRAPEvent {
  int duration;
  AmrapUpdate({required this.duration});
}
