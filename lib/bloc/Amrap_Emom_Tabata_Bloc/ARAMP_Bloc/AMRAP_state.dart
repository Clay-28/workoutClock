
part of 'AMRAP_bloc.dart';

enum AMRAP_Status {initial, countdown, paused, inProgress, finished, selectingWorkout, helper}

class AMRAPState {

  AmrapModel? amrapModel;
  AMRAP_Status status;
  int duration;
  int rounds;


  AMRAPState({ required this.status, required this.duration, required this.rounds, this.amrapModel});

  AMRAPState copyWith({
    AMRAP_Status? status,
    int? duration,
    int? rounds,
    AmrapModel? amrapModel,}){
    return AMRAPState(
      status: status ?? this.status,
      duration: duration ?? this.duration,
      rounds: rounds ?? this.rounds,
      amrapModel: amrapModel ?? this.amrapModel
    );
  }


}