import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../items/ticks.dart';


part 'bloc_state.dart';
part 'bloc_event.dart';


class TimerBloc extends Bloc<TimerEvent, TimerState>{


  int restTime = 89;
  double totalRestingTime = 89;
  int addRestingTime = 16;
  final Ticker _ticker;
  AudioPlayer audioPlayer = AudioPlayer();



  StreamSubscription<int>? _tickerSubscription;
  StreamSubscription<int>? _breakSubscription;
  StreamSubscription<int>? _addBreakSubscription;

  TimerBloc({required Ticker ticker}):
        _ticker = ticker,
        super(const TimerState(
          duration: 8190,
          restTime: 89,
          status: ClockStatus.initial)){
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
    restTime = event.restSeconds + (event.restMinutes * 60);
    totalRestingTime = (event.restMinutes.toDouble() * 60) + event.restSeconds.toDouble() ;
    if(state.status == ClockStatus.paused ){
      emit(state.copyWith(duration: state.duration , restTime: restTime, status: ClockStatus.paused));
    }
    if(state.status == ClockStatus.running) {
      emit(state.copyWith(duration: state.duration, restTime: restTime));
    }
    if(state.status == ClockStatus.resting){
        _breakSubscription?.cancel();
        _breakSubscription = _ticker.breaktick(seconds: restTime ).listen((event) => add(BreakCountDown(restTime: event)));
    }

  }

  void _onBreakStarted( BreakStared event, Emitter<TimerState> emit) async{
    if(state.status  == ClockStatus.resting){
       audioPlayer.stop();
       audioPlayer = AudioPlayer();
       totalRestingTime = event.totalRestingTime.toDouble();
      _breakSubscription?.cancel();
      _breakSubscription = _ticker.breaktick(seconds: event.restingTime).listen((event) => add(BreakCountDown(restTime: event)));
    }else {
       audioPlayer = AudioPlayer();
       int test = event.restingTime;
       print('test:$test');
      _tickerSubscription?.pause();
      _breakSubscription?.cancel();
      _breakSubscription = _ticker.breaktick(seconds: event.restingTime).listen((event) =>
              add(BreakCountDown(restTime: event)));


    }
  }

  void _onBreakCountDown(BreakCountDown event, Emitter<TimerState> emit) async {

    if(event.restTime.round() >= 1){
      print('State.breakTime: ${state.restTime}');
      emit(state.copyWith(restTime: event.restTime, status: ClockStatus.resting));
    }
    if(state.restTime.round() == 5){
      audioPlayer.play(AssetSource('countdown.mp3'));
    }
    if(event.restTime < 1){
      //audioPlayer = AudioPlayer();
      _breakSubscription?.cancel();
      totalRestingTime = restTime.toDouble();
      emit(state.copyWith(duration: state.duration, restTime: restTime, status: ClockStatus.running));
      Future.delayed(Duration(seconds: 1), (){audioPlayer.stop();});
      _tickerSubscription?.resume();
    }
  }


  void _onStarted(TimerStarted event, Emitter<TimerState> emit){
    audioPlayer.stop();
    totalRestingTime = restTime.toDouble();
    _breakSubscription?.cancel();
    _tickerSubscription = _ticker.tick(seconds: event.duration)
        .listen((event) => add(_TimerTicked(duration: event)));
    emit(state.copyWith(status: ClockStatus.running, duration: event.duration, restTime: restTime));
  }

  void _onPaused( TimerPaused event, Emitter<TimerState>  emit){
    _tickerSubscription?.pause();
    _breakSubscription?.cancel();
    _addBreakSubscription?.cancel();
    emit(state.copyWith(status: ClockStatus.paused, duration: state.duration));

  }

  void _onTicked(_TimerTicked event, Emitter<TimerState> emit){
    emit(state.copyWith(duration: event.duration, status: ClockStatus.running));
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit){
    _tickerSubscription?.cancel();
    _breakSubscription?.cancel();
    _addBreakSubscription?.cancel();
  }


}
