import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../EMOM/Emom_Model/Emom_Model_and_Emom_Workouts.dart';
import '../../../audio/audio_handler.dart';
import '../../../items/ticks.dart';

part 'Emom_state_bloc.dart';
part 'Emom_event_bloc.dart';

class EmomBloc extends Bloc<EmomEvent, EmomState>{

  late Map<int,List<dynamic>>scrollWheelText;
  late Map<int,List<dynamic>>forScrollWheelText;
  StreamSubscription<int>? emomSubscription;
  StreamSubscription<int>? durationSubscription;
  Ticker emomTimeController = Ticker();
  List<EmomModel> emomWorkoutList = [];
  MyAudioHandler EmomAudioPlayer = MyAudioHandler(false, 1);


  /// Initial State should start at 1 min intervals for 10 mins
  EmomBloc() : super(EmomState(
    emomModel: EmomModel(interval: 60, totalDuration: 10 * 60, description: ''),
    interval: 60,
    totalDuration: 10 * 60,
    rounds: 0,
    status: EmomStatus.setup,
    description: 'Initial',
    everyScrollWheelIndex: 3,
    everyScrollText: '1 min',
    forScrollWheelIndex: 9,
    forScrollText: '10 min',
    everyController: FixedExtentScrollController(initialItem: 3),
    forController: FixedExtentScrollController(initialItem: 9),
    //emomWorkouts: [EmomModel(interval: 180, rounds: 10, description: 'custom')],
  )){
    /// Helper Functions
    /// Paused, Start, Update....
    on<EmomStart>(_onEmomStart);
    on<EmomPaused>(_onEmomPaused);
    on<EmomUpdate>(_onEmomUpdate);
    on<EmomReset>(_onEmomReset);
    on<CreateEmomModel>(_onCreateEmomModel);
    on<EmomTicked>(_onEmomTicked);
    on<EmomDurationTicked>(_onEmomDurationTicked);
    on<EmomDurationStart>(_onEmomDurationStart);
    /// Sets the display of the Top or "Every" Scroll Wheel
    scrollWheelText = everyScrollWheelDescriptionText(totalValues: 30);
    /// Sets the display of the Bottom or "For" Scroll Wheel
    forScrollWheelText = forScrollWheelDescriptionText(totalValues: 30, startingValue: 60);
  }

  @override
  Future<void> close(){
    emomSubscription?.cancel();
    durationSubscription?.cancel();
    return super.close();
  }

  void _onCreateEmomModel(CreateEmomModel event, Emitter<EmomState> emit){
    /// Creates an Add an EmomModel to state.emomWorkout -> During a Workout they can be updated
    /// When the Workout is completed emomWorkout will be added to notes
    //EmomModel newEmomModel = EmomModel(interval: state.interval, totalDuration: state.totalDuration, description: state.emomModel.description, rounds: 0 );
    //state.emomModel = newEmomModel;

    /// Testing
    EmomModel newEmomModel = EmomModel(
        interval: state.interval,
        totalDuration: state.totalDuration,
        description: state.emomModel.description == '' ? 'Custom EMOM\n': state.emomModel.description ,
        rounds: 0 );

    //print('state.emomWorkouts.length: ${state.emomWorkouts!.length}');


    emomWorkoutList.add(newEmomModel);


    //state.emomWorkouts!.add(newEmomModel);
    // ToDo: remove ~/10 before publication
    emit(state.copyWith(emomModel: newEmomModel, totalDuration: state.totalDuration));
    //print('state.emomWorkouts.length: ${state.emomWorkouts!.length}');
    print('emomModelList: ${emomWorkoutList.length}');
  }

  void _onEmomReset(EmomReset event, Emitter<EmomState> emit){
    EmomAudioPlayer.stop();
    EmomAudioPlayer = MyAudioHandler(false, 1);
    EmomAudioPlayer.play();

    if(event.fullReset == true){
      emomWorkoutList = [];
    }

    emomSubscription?.cancel();
    durationSubscription?.cancel();
    forScrollWheelText = forScrollWheelDescriptionText(totalValues: 30, startingValue: 60);
    scrollWheelText = everyScrollWheelDescriptionText(totalValues: 30);
      emit(state.copyWith(
      totalDuration: 10 * 60,
      interval: 60,
      everyController: FixedExtentScrollController(initialItem: 3),
      forController: FixedExtentScrollController(initialItem: 9),
      description: '',
      status: EmomStatus.setup,
      everyScrollWheelIndex: 3,
      forScrollWheelIndex: 9,
      forScrollText: forScrollWheelText[9]?.first,
      everyScrollText: scrollWheelText[3]?.first ?? '1min',
      emomModel: EmomModel(interval: 60, totalDuration: 10*60, rounds: 0, description: ''),
      //emomWorkouts: [],

    ));
  }

  void _onEmomPaused(EmomPaused event, Emitter<EmomState> emit){
    durationSubscription?.pause();
    emomSubscription?.cancel();
    print('state.totalDuration: ${state.totalDuration}');
    print('state.interval: ${state.interval}');

    // ToDo: Remove ~/10 for publication
    emit(state.copyWith(status: EmomStatus.paused, interval: state.interval == 0 ? state.emomModel.interval!: state.interval));
    print('state.interval: ${state.interval}');
  }


  void _onEmomStart(EmomStart event, Emitter<EmomState> emit){
    emit(state.copyWith(status: EmomStatus.inProgress));

    print('state.emomModel.interval: ${state.emomModel.interval}');
    print('state.interval: ${state.interval}');

    EmomAudioPlayer.stop();
    EmomAudioPlayer = MyAudioHandler(false, 1);
    EmomAudioPlayer.play();

    // ToDo: Remove ~/10 for publication
    emomSubscription = emomTimeController.Emom(seconds: state.interval)
        .listen((event) => add(EmomTicked(duration: event)));

  }

  void _onEmomTicked(EmomTicked event, Emitter<EmomState> emit){

    if(event.duration == 5){
      /// Setting MyAudioHandler == true: adjust the audio session configuration to duck audio
      /// Setting MyAudioHandler == false: adjust the audio session configuration to mix with others
      EmomAudioPlayer.stop();
      EmomAudioPlayer = MyAudioHandler(true, 0);
      EmomAudioPlayer.play();
    }

    if(event.duration == 0){
      state.emomModel.rounds = state.emomModel.rounds! + 1;
    }
    if(event.duration < 0){

      EmomAudioPlayer.stop();
      EmomAudioPlayer = MyAudioHandler(false, 1);
      EmomAudioPlayer.play();


      print('testing 1234');
      print('event.duration: ${event.duration}');
      // ToDo: Remove ~/10 for publication
      emit(state.copyWith( interval: (state.emomModel.interval!) - 1 ) );
      emomSubscription?.cancel();
      /// Condition to restart Round

      /// Original
      if(state.emomModel.rounds! < state.emomModel.totalDuration! ~/ state.emomModel.interval!){
        emomSubscription =
            emomTimeController.Emom(seconds: (state.interval!))
                .listen((event) => add(EmomTicked(duration: event)));
        state.totalDuration = state.totalDuration - 1;
      }

      if(state.emomModel.rounds == state.emomModel.totalDuration! ~/ state.emomModel.interval!){
        emomSubscription?.cancel();
        state.totalDuration = 0;
       emit(state.copyWith(status: EmomStatus.finished, interval: 0,));
      }


    }
    if(event.duration >= 0){
      emit(state.copyWith(interval: event.duration));
      state.totalDuration = state.totalDuration - 1;
    }
    print('interval: ${event.duration}');

  }

  void _onEmomDurationStart (EmomDurationStart event, Emitter<EmomState> emit){
    emit(state.copyWith(status: EmomStatus.inProgress));

    durationSubscription?.cancel();

    durationSubscription = emomTimeController.EmomDuration(seconds: state.totalDuration)
        .listen((event)=> add(EmomDurationTicked(totalDuration: event)));

  }

  void _onEmomDurationTicked(EmomDurationTicked event, Emitter<EmomState> emit){
    if(event.totalDuration == 0 ){
      durationSubscription?.cancel();
    }

    //print('total event.duration: ${event.totalDuration}');
    emit(state.copyWith(totalDuration: event.totalDuration));
  }


  void _onEmomUpdate(EmomUpdate event, Emitter<EmomState> emit){

    if(event.emomStatus == EmomStatus.helper){
        scrollWheelText =  event.emomModel?.description! == ''? everyScrollWheelDescriptionText(totalValues: 30) : forScrollWheelDescriptionText(totalValues: 30, startingValue: 60, update: true);
        forScrollWheelText = forScrollWheelDescriptionText(totalValues: 30, startingValue: 60, update: true);
          emit(state.copyWith(
            status: EmomStatus.helper,
            description: event.description,
            //interval: event.interval ?? scrollWheelText[event.everyScrollWheelIndex]?.last,
            interval: 60,
            totalDuration: event.emomModel!.totalDuration,

            /// Original
            //everyScrollText: scrollWheelText[event.everyScrollWheelIndex]?.first,
            /// Test
            everyScrollText: scrollWheelText[0]?.first,
            everyScrollWheelIndex: event.everyScrollWheelIndex ?? 0,
            everyController: event.everyController ?? FixedExtentScrollController(initialItem: 0),
            // forScrollText: forScrollWheelText[testTotalDurationIndex]?.first,
            /// Original
            // forController: event.forController,
            // forScrollWheelIndex: event.forScrollWheelIndex,
            /// Adaptive Scroll Wheel Update
            forController: FixedExtentScrollController(
                initialItem: (event.emomModel!.totalDuration! ~/ 60) - 1),
            forScrollWheelIndex: (event.emomModel!.totalDuration! ~/ 60) - 1,
            emomModel: event.emomModel,

            /// Test
            forScrollText: scrollWheelText[0]?.first
        ));

        Future.delayed(const Duration(milliseconds: 100), () {
          print('Yeahhhh Buddy');
          //add(EmomUpdate(emomStatus: EmomStatus.selectingWorkout, forScrollWheelIndex: event.forScrollWheelIndex));
          add(EmomUpdate(
              emomStatus: EmomStatus.selectingWorkout, interval: 60));
          print(' Helper everyScrollIndex :${state.everyScrollWheelIndex}\nscrollWheelTex: $scrollWheelText');
        });
    }


    if((state.status == EmomStatus.selectingWorkout || state.status == EmomStatus.setup) && state.everyScrollWheelIndex != event.everyScrollWheelIndex) {
      print('Emom Update Yeeeeeee Hawwww');
      print('event.interval: ${event.interval}, state.interval: ${state.interval}');

      int newEveryScrollValue = scrollWheelText[event.everyScrollWheelIndex]?.last ?? state.interval;

      print('newEveryScrollValue: $newEveryScrollValue');
      /// Works Great
     // print('event.interval ${event.interval} ??  scrollWheelText[event.everyScrollWheelIndex]?.last ${scrollWheelText[event.everyScrollWheelIndex]?.last} ?? state.interval ${state.interval}');

      /// Only creates a new map if the index changes
      // if(event.everyScrollWheelIndex != null){
      //   forScrollWheelText = forScrollWheelDescriptionText(totalValues: 30,update: true, startingValue: newEveryScrollValue );
      //   print(forScrollWheelText);
      // }

      forScrollWheelText = forScrollWheelDescriptionText(totalValues: 30,update: true, startingValue: newEveryScrollValue );

      print(forScrollWheelText);


      /// Original
      //forScrollWheelText = forScrollWheelDescriptionText(totalValues: 30,update: true, startingValue: newEveryScrollValue );

      /// Test Updates the Top-Interval-Every Scroll Wheel Vales to 1 -> 30min
      //scrollWheelText = forScrollWheelDescriptionText(totalValues: 30,update: true, startingValue: event.interval ?? state.interval ?? scrollWheelText[event.everyScrollWheelIndex]?.last);

      //print('For Scroll Wheel: $forScrollWheelText\nEveryScrollWheelText: $scrollWheelText');

      /// When The Top Scroll Wheel is changes only everyScrollWheelIndex +=1
      ///
      //int testTotalDurationIndex  = event.everyScrollWheelIndex == null ? event.forScrollWheelIndex! : state.forScrollWheelIndex!;

      int testTotalDurationIndex = event.forScrollWheelIndex ?? state.forScrollWheelIndex ?? 0;

      /// There are 2 actions
      /// Every(interval) & For(Duration) horizontal Scroll Wheel
      /// If Top(interval) Scroll Wheel is changes -> Update the scroll wheel text -> & Set total duration to Text & Index

      emit(state.copyWith(
        description: event.description,
        interval: newEveryScrollValue,

        totalDuration: event.totalDuration ?? forScrollWheelText[testTotalDurationIndex]?.last,

        everyScrollText: scrollWheelText[event.everyScrollWheelIndex]?.first,
        everyScrollWheelIndex: event.everyScrollWheelIndex,
        everyController: event.forController,

        forScrollText: forScrollWheelText[testTotalDurationIndex]?.first,
        forController: event.forController,


        //interval: event.interval ?? scrollWheelText[event.everyScrollWheelIndex]?.last,
        forScrollWheelIndex: event.forScrollWheelIndex,

        emomModel: event.emomModel,

      ));


      print('state.interval ${state.interval}');
    }

    emit(state.copyWith(status:
      event.emomStatus,
      description: event.description,
      //interval: scrollWheelText[event.everyScrollWheelIndex]?.last,
      totalDuration: forScrollWheelText[event.forScrollWheelIndex]?.last,
      forScrollWheelIndex: event.forScrollWheelIndex,
      forScrollText: forScrollWheelText[event.forScrollWheelIndex]?.first,
      // everyScrollWheelIndex: event.everyScrollWheelIndex,
      everyScrollWheelIndex: 0,
      everyScrollText: scrollWheelText[event.everyScrollWheelIndex]?.first,
      emomModel: event.emomModel,
      forController: event.forController,
      everyController: event.forController,
    ));

    print('final state.interval ${state.interval}');


  }


  Map<int, List<dynamic>> everyScrollWheelDescriptionText({required int totalValues,}){

    Map<int,List<dynamic>> scrollWheelText = {};
    int index = 0;

    while(index < totalValues) {
      if (index < 3) {
        String text = '${(index * 15) + 15} secs';
        int duration = (index * 15) + 15;
        scrollWheelText[index] = [text,duration];
      }
      if (index >= 3 && index < 12) {
        int _minutes = ((index * 15) + 15) ~/ 60;
        int _seconds = ((index * 15) + 15) % 60;
        String text = _seconds == 0 ? '$_minutes:0$_seconds min' : '$_minutes:$_seconds min';
        int duration = (_minutes * 60) + _seconds;
        scrollWheelText[index] = [text,duration];
      }if(index >= 12) {
        String text = '${index - 8} min';
        int duration = (index - 8) * 60;
        scrollWheelText[index] = [text,duration];
      }
      index ++;
    }
    //print(scrollWheelText);
    return scrollWheelText;



  }





  Map<int, List<dynamic>> forScrollWheelDescriptionText({required int totalValues, bool? update, int? startingValue}) {
    Map<int, List<dynamic>> scrollWheelText = {};
    int index = 0;

    if (update == true) {
      /// Every : duration :: 1 min
      /// For Scroll Wheel Text = 1 * duration | 2 * Duration :: 1 min, 2 min, 3 min,
      /// Example 2 : Every 1:30 min
      /// For : 1:30 minutes, 3 : minutes ....
      /// Map<int, List<dynamic> = [0 : ['45 seconds' , 45] , 1 : [ '1:30 minutes, 90 ]

      /// Get Interval ->
      int? _startingValue = startingValue;
      int index = 0;
      while (index < totalValues) {
        String secondsText = _startingValue! % 60 == 0
            ? ''
            : ':${_startingValue! % 60}';

        /// Original
        //scrollWheelText[index] = ['${_startingValue! ~/ 60}:${_startingValue! % 60} min', _startingValue ];
        /// Test
        scrollWheelText[index] =
        ['${_startingValue! ~/ 60}$secondsText min', _startingValue];


        _startingValue = startingValue! * (index + 2);
        index ++;
      }
      return scrollWheelText;
    }


    int? _startingValues = startingValue;
    //int? _startingValue = state.interval;
    while (index < totalValues) {
      String secondsText = _startingValues! % 60 == 0
          ? ''
          : ':${_startingValues! % 60}';

      /// Original
      //scrollWheelText[index] = ['${_startingValue! ~/ 60}:${_startingValue! % 60} min', _startingValue ];
      /// Test
      scrollWheelText[index] =
      ['${_startingValues! ~/ 60}$secondsText min', _startingValues];


      _startingValues = startingValue! * (index + 2);
      index ++;
    }
    return scrollWheelText;

  }



  String fetchEmomWorkoutData(){
    String EmomData = '';
    if(emomWorkoutList.isNotEmpty) {
      for (EmomModel item in emomWorkoutList) {
        EmomData += '**EMOM**\n${item.totalDuration! ~/ 60} Minutes, ${item
            .rounds} Rounds\n${item.description ?? 'Custom'}\n\n';
      }
      return '\n**EMOM Review**\n\n$EmomData';
    }
    return '';
  }










  /// Original
  // Map<int, List<dynamic>> forScrollWheelDescriptionText({required int totalValues, bool? update, int? startingValue}){
  //
  //   Map<int,List<dynamic>> scrollWheelText = {};
  //   int index = 0;
  //
  //   if(update == true){
  //     /// Every : duration :: 1 min
  //     /// For Scroll Wheel Text = 1 * duration | 2 * Duration :: 1 min, 2 min, 3 min,
  //     /// Example 2 : Every 1:30 min
  //     /// For : 1:30 minutes, 3 : minutes ....
  //     /// Map<int, List<dynamic> = [0 : ['45 seconds' , 45] , 1 : [ '1:30 minutes, 90 ]
  //
  //     /// Get Interval ->
  //     int? _startingValue = startingValue;
  //     //int? _startingValue = state.interval;
  //     int index = 0;
  //     while(index < totalValues){
  //       String secondsText = _startingValue! % 60 == 0 ? '': ':${_startingValue! % 60}';
  //       /// Original
  //       //scrollWheelText[index] = ['${_startingValue! ~/ 60}:${_startingValue! % 60} min', _startingValue ];
  //       /// Test
  //       scrollWheelText[index] = ['${_startingValue! ~/ 60}$secondsText min', _startingValue ];
  //
  //
  //       _startingValue = startingValue! * (index+2);
  //       index ++;
  //     }
  //
  //     print('update == true: ${scrollWheelText}');
  //     return scrollWheelText;
  //   }
  //
  //
  //   while(index < totalValues) {
  //     if(index == 0){
  //       int duration = 60;
  //       scrollWheelText[index] = ['1:00 min', duration];
  //     }
  //     if( index > 0 && index % 2 == 0){
  //       String text = '${((index ~/ 2) + 1).toString()}:00 min';
  //       int duration  = (index~/2 + 1) * 60;
  //       scrollWheelText[index] = [text, duration];
  //     }if(index > 0 && index % 2 > 0){
  //       String text = '${((index ~/2) + 1).toString()}:30 min';
  //       int duration  = (index * 30) + 60;
  //       scrollWheelText[index] = [text,duration];
  //     }
  //     index ++;
  //   }
  //
  //   print(scrollWheelText);
  //   return scrollWheelText;
  //
  // }


}