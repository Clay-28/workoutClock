
part of 'AMRAP_bloc.dart';


/// pause, start, update, add round, decrease round,

class AMRAPEvent {

  AMRAPEvent();
}

class AmrapStart extends AMRAPEvent {
  //int duration;

  AmrapStart();
}

class AmrapPause extends AMRAPEvent {
  AmrapPause();
}

class AmrapUpdate extends AMRAPEvent {
  AMRAP_Status? status;
  int duration;
  AmrapUpdate({required this.duration, this.status});
}

class AmrapClose extends AMRAPEvent{
  AmrapClose();
}

class AmrapCountDown extends AMRAPEvent{
  int duration;
  AmrapCountDown({required this.duration});
}