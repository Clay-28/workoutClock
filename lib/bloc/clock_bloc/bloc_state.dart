
part of 'clock_bloc.dart';

enum ClockStatus {initial, paused, running, resting}

class TimerState extends Equatable {

  final int duration;
  final int restTime;
  final ClockStatus status;

  const TimerState({
    required this.duration,
    required this.restTime,
    required this.status
  });

  TimerState copyWith({
    int? duration,
    int? restTime,
    ClockStatus? status
  }){
    return TimerState(
        duration: duration ?? this.duration,
        restTime: restTime ?? this.restTime,
        status: status ?? this.status
    );
  }


  @override
  List<Object> get props => [duration, restTime, status];
}


