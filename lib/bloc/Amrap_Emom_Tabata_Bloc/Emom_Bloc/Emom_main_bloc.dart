import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../EMOM/Emom_Model/Emom_Model_and_Emom_Workouts.dart';

part 'Emom_state_bloc.dart';
part 'Emom_event_bloc.dart';

class EmomBloc extends Bloc<EmomEvent, EmomState>{

  late Map<int,List<dynamic>>scrollWheelText;
  late Map<int,List<dynamic>>forScrollWheelText;


  /// Initial State should start at 1 min intervals for 10 mins
  EmomBloc() : super(EmomState(
    emomModel: EmomModel(interval: 60, totalDuration: 10 * 60, description: ''),
    interval: 1,
    totalDuration: 10,
    status: EmomStatus.setup,
    description: 'Initial',
    everyScrollWheelIndex: 3,
    everyScrollText: '1 min',
    forScrollWheelIndex: 9,
    forScrollText: '10 min',
    everyController: FixedExtentScrollController(initialItem: 2),
    forController: FixedExtentScrollController(initialItem: 9),
  )){
    /// Helper Functions
    /// Paused, Start, Update....
    on<EmomStart>(_onEmomStart);
    on<EmomPaused>(_onEmomPaused);
    on<EmomUpdate>(_onEmomUpdate);
    on<EmomReset>(_onEmomReset);
    /// Sets the display of the Top or "Every" Scroll Wheel
    scrollWheelText = everyScrollWheelDescriptionText(totalValues: 30);
    /// Sets the display of the Bottom or "For" Scroll Wheel
    forScrollWheelText = forScrollWheelDescriptionText(totalValues: 30, startingValue: 60);
  }

  void _onEmomReset(EmomReset event, Emitter<EmomState> emit){

    forScrollWheelText = forScrollWheelDescriptionText(totalValues: 30, startingValue: 60);

      emit(state.copyWith(
      totalDuration: 10 * 60,
      interval: 60,
      everyController: FixedExtentScrollController(initialItem: 2),
      forController: FixedExtentScrollController(initialItem: 9),
      description: '',
      status: EmomStatus.setup,
      everyScrollWheelIndex: 3,
      forScrollWheelIndex: 9,
      forScrollText: '10 min',
      everyScrollText: '1 min',
      emomModel: EmomModel(interval: 60, totalDuration: 10*60, rounds: 0, description: ''),

    ));
  }

  void _onEmomStart(EmomStart event, Emitter<EmomState> emit){
    emit(state.copyWith(status: EmomStatus.inProgressed,));
  }

  void _onEmomPaused(EmomPaused event, Emitter<EmomState> emit){
    emit(state.copyWith(status: EmomStatus.paused));
  }

  void _onEmomUpdate(EmomUpdate event, Emitter<EmomState> emit){

    if(event.emomStatus == EmomStatus.helper){

      print('helper initial : state.Status: ${state.status} || event.status${state.status}');
      print('helper activated');
      print('event.total Duraion: ${event.totalDuration}');
      print('event.interval: ${event.interval}');
      emit(state.copyWith(
        status: EmomStatus.helper,
        description: event.description,
        interval: event.interval ?? scrollWheelText[event.everyScrollWheelIndex]?.last,
        totalDuration: event.totalDuration,
        everyScrollText: scrollWheelText[event.everyScrollWheelIndex]?.first,
        everyScrollWheelIndex: event.everyScrollWheelIndex,
        everyController: event.forController,

        // forScrollText: forScrollWheelText[testTotalDurationIndex]?.first,
        forController: event.forController,
        forScrollWheelIndex: event.forScrollWheelIndex,
        emomModel: event.emomModel,
      ));

      print('state.duration: ${state.totalDuration}');
      print('state.interval: ${state.interval}');
      print('helper final : state.Status: ${state.status} || event.status${state.status}');
      Future.delayed(const Duration(milliseconds: 100), (){
        print('Yeahhhh Buddy');
        print('future before : state.Status: ${state.status} || event.status${state.status}');
        //add(EmomUpdate(emomStatus: EmomStatus.selectingWorkout, forScrollWheelIndex: event.forScrollWheelIndex));
        add(EmomUpdate(emomStatus: EmomStatus.selectingWorkout,));
        print('future after : state.Status: ${state.status} || event.status${state.status}');
      });
    }

    if((state.status == EmomStatus.selectingWorkout || state.status == EmomStatus.setup) && state.everyScrollWheelIndex != event.everyScrollWheelIndex) {
      print('Emom Update Yeeeeeee Hawwww');
      //print('state.everyScrollWheelIndex: ${state.everyScrollWheelIndex} != event.everyScrollWheelIndex ${event.everyScrollWheelIndex}');
      /// Want to update the ForScrollWheelText
      /// forScrollWheelText =
      /// Used for testing
      //forScrollWheelDescriptionText(totalValues: 30,update: true, startingValue: 30);

      /// Works Great

      print('event.interval ${event.interval} ??  scrollWheelText[event.everyScrollWheelIndex]?.last ${scrollWheelText[event.everyScrollWheelIndex]?.last} ?? state.interval ${state.interval}');
      forScrollWheelText = forScrollWheelDescriptionText(totalValues: 30,update: true, startingValue: event.interval ?? state.interval ?? scrollWheelText[event.everyScrollWheelIndex]?.last);

      print(forScrollWheelText);

      //int testTotalDurationIndex  = event.everyScrollWheelIndex == null ? event.forScrollWheelIndex! : state.forScrollWheelIndex!;

      int testTotalDurationIndex = event.forScrollWheelIndex ?? state.forScrollWheelIndex ?? 0;

      /// There are 2 actions
      /// Every & For horizontal Scroll Wheel
      /// If every Scroll Wheel is changes -> Update the scroll wheel text -> & Set total duration to Text & Index


      emit(state.copyWith(
        description: event.description,
        interval: event.interval ?? scrollWheelText[event.everyScrollWheelIndex]?.last,
        totalDuration: event.totalDuration ?? forScrollWheelText[testTotalDurationIndex]?.last,

        everyScrollText: scrollWheelText[event.everyScrollWheelIndex]?.first,
        everyScrollWheelIndex: event.everyScrollWheelIndex,
        everyController: event.forController,

        forScrollText: forScrollWheelText[testTotalDurationIndex]?.first,
        forController: event.forController,
        forScrollWheelIndex: event.forScrollWheelIndex,

        emomModel: event.emomModel,

      ));


    }

    print('final emit before : state.Status: ${state.status} || event.status${state.status}');
    emit(state.copyWith(status:
      event.emomStatus,
      description: event.description,
      interval: scrollWheelText[event.everyScrollWheelIndex]?.last,
      totalDuration: forScrollWheelText[event.forScrollWheelIndex]?.last,
      forScrollWheelIndex: event.forScrollWheelIndex,
      forScrollText: forScrollWheelText[event.forScrollWheelIndex]?.first,
      everyScrollWheelIndex: event.everyScrollWheelIndex,
      everyScrollText: scrollWheelText[event.everyScrollWheelIndex]?.first,
      emomModel: event.emomModel,
      forController: event.forController,
      everyController: event.forController,
    ));
    print('final emit after : state.Status: ${state.status} || event.status${state.status}');


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
      //int? _startingValue = state.interval;
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
}