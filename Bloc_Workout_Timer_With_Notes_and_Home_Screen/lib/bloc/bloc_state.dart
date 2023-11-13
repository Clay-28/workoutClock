
part of 'clock_bloc.dart';

abstract class TimerState extends Equatable{
  TimerState(this.duration, this.breakTime, this.addBreakTime);
  final int duration;
  int breakTime = 5;
  int? addBreakTime;

  @override
  List <Object?> get props => [duration, breakTime, addBreakTime];
}

final class TimerInitial extends TimerState{
  TimerInitial(super.duration, super.breakTime, super.addBreakTime);

}

final class TimerIsPaused extends TimerState{
  TimerIsPaused(super.duration, super.breakTime, super.addBreakTime);

}

final class TimerRunning extends TimerState{
  TimerRunning(super.duration, super.breakTime, super.addBreakTime,);
}

/*
final class TimerIsCompleted extends TimerState{
  TimerIsCompleted() : super(0,10,0);
}
 */

/*
final class TimerInBreak extends TimerState{
  TimerInBreak(super.duration, super.breakTime);
}

 */


final class BreakTimerRunning extends TimerState{
  BreakTimerRunning(super.duration, super.breakTime, super.addBreakTime, this.totalBreakTime);
  double totalBreakTime;
}

/*
final class BreakTimerIsCompleted extends TimerState{
  BreakTimerIsCompleted(super.duration, super.breakTime);
}
 */

