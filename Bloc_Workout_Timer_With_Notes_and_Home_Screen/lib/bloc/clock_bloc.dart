import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_workout_timer_test_1/bloc/scroll_wheel_bloc/scroll_wheel_bloc.dart';
import 'package:equatable/equatable.dart';
import '../items/ticks.dart';
part 'bloc_event.dart';
part 'bloc_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState>{
  static const int _startingTime = 0;
  static const int _addbreakTime = 15;
  //static int _initialBreakTime = 90;

  int initialBreakTime = 90;
  int breakTime = 90;
  double totalBreakTime = 89;
  final Ticker _ticker;

  /// _startingTime, _breakTime, _addbreakTime

  StreamSubscription<int>? _tickerSubscription;
  StreamSubscription<int>? _breakSubscription;
  StreamSubscription<int>? _addBreakSubscription;

  TimerBloc({required Ticker ticker}):
        _ticker = ticker,
        super( TimerInitial(_startingTime, 90 ,_addbreakTime)){
    on<TimerStarted>(_onStarted);
    on<_TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerReset>(_onReset);
    on<BreakStared>(_onBreakStarted);
    on<BreakCountDown>(_onBreakCountDown);
    on<UpdateBreakTime>(_onUpdateBreakTime);
  }

  @override
  Future<void> close(){
    _tickerSubscription?.cancel();
    _breakSubscription?.cancel();
    return super.close();
  }



  void _onUpdateBreakTime(UpdateBreakTime event, Emitter<TimerState> emit){
    //int breakTime = 31;
    //state.breakTime = 20;
    breakTime = event.breakSeconds + (event.breakMinutes * 60);
    state.breakTime = (event.breakMinutes * 60) + event.breakSeconds;
    totalBreakTime = (event.breakMinutes.toDouble() * 60) + event.breakSeconds.toDouble() ;
    //_tickerSubscription?.pause();
    //_breakSubscription?.cancel();
    if(state is TimerIsPaused){
      //_tickerSubscription?.pause();
      emit(TimerIsPaused(state.duration, state.breakTime, 0));
    }
    if(state is TimerRunning) {
      emit(TimerRunning(state.duration, state.breakTime, 0));
    }
    if(state is BreakTimerRunning){
        _breakSubscription?.cancel();
        //close();
        _breakSubscription = _ticker.breaktick(seconds: state.breakTime ).listen((event) => add(BreakCountDown(breakTime: event)));
    }

  }

  void _onBreakStarted( BreakStared event, Emitter<TimerState> emit){
    if(state is BreakTimerRunning){
       totalBreakTime = event.totalBreakTime.toDouble();
      _breakSubscription?.cancel();
      _breakSubscription = _ticker.breaktick(seconds: event.breakTime).listen((event) => add(BreakCountDown(breakTime: event)));
    }else {
      _tickerSubscription?.pause();
      _breakSubscription?.cancel();
      _breakSubscription = _ticker.breaktick(seconds: event.breakTime).listen((event) =>
              add(BreakCountDown(breakTime: event)));
    }
  }

  void _onBreakCountDown(BreakCountDown event, Emitter<TimerState> emit){
    if(event.breakTime >= 1){
      emit(BreakTimerRunning(state.duration, event.breakTime, state.addBreakTime, totalBreakTime));
    }
    if(event.breakTime < 1){
      //totalBreakTime = 5;
      _breakSubscription?.cancel();
      emit(TimerRunning(state.duration, breakTime, _addbreakTime));
      _tickerSubscription?.resume();
    }
  }



  void _onStarted(TimerStarted event, Emitter<TimerState> emit){
    _tickerSubscription?.cancel();
    _breakSubscription?.cancel();
    _addBreakSubscription?.cancel();
    totalBreakTime = breakTime.toDouble();
    _tickerSubscription = _ticker.tick(seconds: event.duration)
      .listen((event) => add(_TimerTicked(duration: event)));
    emit(TimerRunning(state.duration, breakTime , _addbreakTime));
  }

  void _onPaused( TimerPaused event, Emitter<TimerState>  emit){
    _tickerSubscription?.pause();
    _breakSubscription?.cancel();
    _addBreakSubscription?.cancel();
    emit(TimerIsPaused(state.duration, breakTime, _addbreakTime));
  }

  void _onTicked(_TimerTicked event, Emitter<TimerState> emit){
    emit(TimerRunning(event.duration, state.breakTime, _addbreakTime));
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit){
    _tickerSubscription?.cancel();
    _breakSubscription?.cancel();
    _addBreakSubscription?.cancel();
    breakTime = 10;
    state.breakTime = 10;
    totalBreakTime = 10;
    emit(TimerInitial(_startingTime, breakTime , _addbreakTime));

  }


}

