import 'dart:async';
import 'package:WorkoutClock/audio/audio_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../items/ticks.dart';

part 'bloc_state.dart';
part 'bloc_event.dart';




class TimerBloc extends Bloc<TimerEvent, TimerState>{



  int restTime = 89;
  double totalRestingTime = 89;
  int addRestingTime = 16;
  final Ticker _ticker;

  /// sets the audio session to not duck audio, this allows a silent audio mp3 to play,
  /// 0: is a countdown mp3
  /// 1: is a silent mp3
  MyAudioHandler audioPlayer = MyAudioHandler(false, 1);

  StreamSubscription<int>? _tickerSubscription;
  StreamSubscription<int>? _breakSubscription;
  StreamSubscription<int>? _addBreakSubscription;

  TimerBloc({required Ticker ticker}):
        _ticker = ticker,
        super(const TimerState(
          duration: 0,
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

     /// MyAudioHandler(true,0).stop();
      audioPlayer.stop();

      totalRestingTime = event.totalRestingTime.toDouble();
      _breakSubscription?.cancel();
      _breakSubscription = _ticker.breaktick(seconds: event.restingTime).listen((event) => add(BreakCountDown(restTime: event)));
    }else {
      _tickerSubscription?.pause();
      _breakSubscription?.cancel();
      _breakSubscription = _ticker.breaktick(seconds: event.restingTime).listen((event) =>
              add(BreakCountDown(restTime: event)));


    }
  }

  void _onBreakCountDown(BreakCountDown event, Emitter<TimerState> emit) async {

    if(event.restTime.round() >= 1){
      emit(state.copyWith(restTime: event.restTime, status: ClockStatus.resting));
    }
    if(state.restTime.round() == 5){
      /// Setting MyAudioHandler == true: adjust the audio session configuration to duck audio
      /// Setting MyAudioHandler == false: adjust the audio session configuration to mix with others
      audioPlayer.stop();
      audioPlayer = MyAudioHandler(true, 0);
      audioPlayer.play();
    }
    if(event.restTime < 1){
      //audioPlayer.initAudioService();
      /// Stops the countdown audio
      audioPlayer.stop();
      /// Sets Audio Session to allow mixed audio, audio to silent mp3 and plays plays the mp3
      audioPlayer = MyAudioHandler(false, 1);
      audioPlayer.play();
      _breakSubscription?.cancel();
      totalRestingTime = restTime.toDouble();
      emit(state.copyWith(duration: state.duration, restTime: restTime, status: ClockStatus.running));
      _tickerSubscription?.resume();
    }
  }


  void _onStarted(TimerStarted event, Emitter<TimerState> emit){

    audioPlayer.stop();
    audioPlayer = MyAudioHandler(false, 1);
    audioPlayer.play();


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
