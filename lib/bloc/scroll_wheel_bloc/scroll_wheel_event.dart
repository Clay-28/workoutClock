part of 'scroll_wheel_bloc.dart';

abstract class ScrollEvent extends Equatable {
  const ScrollEvent();

  @override
  List<Object> get props => [];
}

class OpenScrollWheel extends ScrollEvent{
  const OpenScrollWheel();
}


class CloseScrollWheel extends ScrollEvent{
  final int breakMinutes;
  final int breakSeconds;
  const CloseScrollWheel({required this.breakMinutes, required this.breakSeconds});

  @override
  List<Object> get props => [breakMinutes, breakSeconds];
}

class UpdateScrollWheel extends ScrollEvent{
  final int breakMinutes;
  final int breakSeconds;
  const UpdateScrollWheel({required this.breakMinutes, required this.breakSeconds});

  @override
  List<Object> get props => [breakMinutes, breakSeconds];
}