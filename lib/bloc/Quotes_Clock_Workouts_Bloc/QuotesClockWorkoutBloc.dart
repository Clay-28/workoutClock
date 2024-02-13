import 'package:flutter_bloc/flutter_bloc.dart';
part 'QuotesClockWorkoutEvent.dart';
part 'QuotesClockWorkoutState.dart';


class QCWBloc extends Bloc<QCWEvent, QCWState>{

  QCWBloc() : super(QCWState(locked: false)){
    on<UpdateQCW>(_onUpdateQCW);
  }

  void _onUpdateQCW(UpdateQCW event, Emitter<QCWState> emit){
    emit(state.copyWith(locked: event.locked));
  }
}