
part of 'QuotesClockWorkoutBloc.dart';

class QCWState {
  bool locked;
  QCWState({required this.locked});

  QCWState copyWith({bool? locked}){
    return QCWState(locked: locked ?? this.locked);
  }
}