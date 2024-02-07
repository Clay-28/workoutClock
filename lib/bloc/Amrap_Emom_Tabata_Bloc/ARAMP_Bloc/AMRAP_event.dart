
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
  String? description;
  AmrapModel? amrapModel;
  AMRAP_Status? status;
  int? duration;
  int? rounds;
  AmrapUpdate({this.duration, this.status, this.amrapModel, this.description, this.rounds});
}

class AmrapClose extends AMRAPEvent{
  AmrapClose();
}

class AmrapCountDown extends AMRAPEvent{
  int duration;
  AmrapCountDown({required this.duration});
}

class CreateAmrapModel extends AMRAPEvent{
  int duration;
  int rounds;
  String? description;
  CreateAmrapModel({required this.duration, required this.rounds, this.description});
}

class AmrapUpdateRounds extends AMRAPEvent{
  int rounds;
  AmrapUpdateRounds({required this.rounds});
}

class UpdateAmrapDescription extends AMRAPEvent{
  String description;
  UpdateAmrapDescription({required this.description});
}