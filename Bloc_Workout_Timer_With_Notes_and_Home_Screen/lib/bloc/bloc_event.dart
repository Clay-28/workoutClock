
part of 'clock_bloc.dart';

abstract class TimerEvent{
  const TimerEvent();
}

final class TimerStarted extends TimerEvent{
  TimerStarted({required this.duration, required this.breakTime});

  final int duration;
  final int breakTime;
}

final class TimerPaused extends TimerEvent{
  const TimerPaused();
}

final class TimerResumed extends TimerEvent{
  const TimerResumed();
}

class TimerReset extends TimerEvent{
  const TimerReset();
}

class UpdateBreakTime extends TimerEvent{
  UpdateBreakTime({ required this.breakMinutes, required this.breakSeconds});
  final int breakMinutes;
  final int breakSeconds;
}

class UpdateBreakMinutes extends TimerEvent{
  UpdateBreakMinutes({ required this.minutes});
  final int minutes;
}

class UpdateBreakSeconds extends TimerEvent{
  UpdateBreakSeconds({required this.seconds});
  final int seconds;
}

class _TimerTicked extends TimerEvent{
  const _TimerTicked({required this.duration});
  final int duration;
}



class BreakStared extends TimerEvent{
  const BreakStared({required this.breakTime, required this.totalBreakTime});
  final int breakTime;
  final int totalBreakTime;
}

class BreakCountDown extends TimerEvent{
  const BreakCountDown({required this.breakTime});
  final int breakTime;
}

