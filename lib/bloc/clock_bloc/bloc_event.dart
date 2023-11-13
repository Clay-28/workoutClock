part of 'clock_bloc.dart';

abstract class TimerEvent{
  const TimerEvent();
}


final class TimerStarted extends TimerEvent{
  TimerStarted({required this.duration});

  final int duration;
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
  UpdateBreakTime({ required this.restMinutes, required this.restSeconds});
  final int restMinutes;
  final int restSeconds;
}


class _TimerTicked extends TimerEvent{
  const _TimerTicked({required this.duration});
  final int duration;
}

class BreakStared extends TimerEvent{
  const BreakStared({required this.restingTime, required this.totalRestingTime});
  final int restingTime;
  final int totalRestingTime;
}

class BreakCountDown extends TimerEvent{
  const BreakCountDown({required this.restTime});
  final int restTime;
}

