
part of 'AMRAP_bloc.dart';

enum AMRAP_Status {initial, countdown, paused, inProgress,}

class AMRAPState {

  AMRAP_Status status;
  int duration;
  int rounds;


  AMRAPState({ required this.status, required this.duration, required this.rounds});

  AMRAPState copyWith({
    AMRAP_Status? status,
    int? duration,
    int? rounds,}){
    return AMRAPState(
      status: status ?? this.status,
      duration: duration ?? this.duration,
      rounds: rounds ?? this.rounds,
    );
  }


}