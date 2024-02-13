part of 'QuotesClockWorkoutBloc.dart';

class QCWEvent{
  QCWEvent();
}

class UpdateQCW extends QCWEvent{
  bool locked;
  UpdateQCW({required this.locked});
}