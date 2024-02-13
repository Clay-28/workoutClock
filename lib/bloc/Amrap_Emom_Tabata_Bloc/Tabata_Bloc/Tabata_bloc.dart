import 'dart:async';
import 'dart:math';

import 'package:WorkoutClock/Tabata_Componets/Tabata_model_workouts/Tabata_model_and_workouts.dart';
import 'package:WorkoutClock/Tabata_Componets/Tabata_services/Tabata_scroll_wheel_map.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../audio/audio_handler.dart';
import '../../../items/ticks.dart';



part 'Tabata_event_bloc.dart';
part  'Tabata_state_bloc.dart';


/*
Text(
    'Custom',
    style: GoogleFonts.bebasNeue(
        fontSize: 30,
        color: Colors.white,
        textStyle: TextStyle(
          height: 1.25,
          overflow: TextOverflow.visible,
        )
    ),
 */

class TabataBloc extends Bloc<TabataEvent, TabataState>{

  List<TabataModel> tabataWorkouts =  [];
  late Map<int,List<dynamic>> _roundScrollMap;
  late Map<int,List<dynamic>> _workRestScrollMap;

  StreamSubscription<int>? tabataWorkingSubscription;
  StreamSubscription<int>? tabataRestSubscription;
  Ticker tabataWorkingController = Ticker();
  Ticker tabataRestingController = Ticker();
  MyAudioHandler EmomAudioPlayer = MyAudioHandler(false, 1);

  /// Test Counter used to


  /// need 2 ticker
  /// 2 Stream Subscriptions


  TabataBloc() : super(
      TabataState(
        description: '',
        status: TabataStatus.setup,
        rounds: 10,
        totalDuration: 10 * 60,
        interval: 60,
        restInterval: 25,
        // roundController: FixedExtentScrollController(initialItem: 9),
        // roundControllerIndex: 9,
        // durationController: FixedExtentScrollController(initialItem: 55),
        // intervalControllerIndex: 56,
        // restController: FixedExtentScrollController(initialItem: 55),
        // restControllerIndex: 55,
          /// Test
          roundController: FixedExtentScrollController(initialItem: 9),
          roundControllerIndex: 9,
          durationController: FixedExtentScrollController(initialItem: 1),
          intervalControllerIndex: 1,
          restController: FixedExtentScrollController(initialItem: 1),
          restControllerIndex: 1,
        intervalStatus: IntervalStatus.working,

        tabataModel: TabataModel(
            totalDuration: 10 * 60,
            interval: 60,
            restInterval: 30,
            rounds: 10,
            description: 'Custom'),
      )

  ){
    on<TabataStartInterval>(_onTabataStartInterval);
    on<TabataStartRestInterval>(_onTabataStartRestInterval);
    on<TabataPause>(_onTabataPause);
    on<TabataReset>(_onTabataReset);
    on<TabataTicked>(_onTabataTicked);
    on<UpdateTabata>(_onUpdateTabata);
    on<CreateTabataWorkout>(_onCreateTabataWorkout);
    on<TabataRestingTicked>(_onTabataRestingTicked);
    _roundScrollMap = TabataServices().roundScrollMap(totalRounds: 101);
    _workRestScrollMap = TabataServices().workRestRoundScrollMap(totalRounds: 152);
  }

  Map<int,List<dynamic>> testMap = TabataServices().workRestRoundScrollMap(totalRounds: 152);


  Map<int,List<dynamic>> get roundScrollText => _roundScrollMap;
  Map<int,List<dynamic>> get workRestScrollText => _workRestScrollMap;

  @override
  Future<void> close(){
    tabataWorkingSubscription?.cancel();
    tabataRestSubscription?.cancel();
    return super.close();
  }

  void _onTabataStartInterval(TabataStartInterval event, Emitter<TabataState> emit){
    /// Controls state.interval
    /// if fullReset is true -> deletes List tabataWorkouts


    emit(state.copyWith(status: TabataStatus.inProgress));


    EmomAudioPlayer.stop();
    EmomAudioPlayer = MyAudioHandler(false, 1);
    EmomAudioPlayer.play();



    // ToDo: Remove ~/10 for publication
    tabataWorkingSubscription = tabataWorkingController.TabataWorking(seconds: event.duration)
        .listen((event) => add(TabataTicked(duration: event)));

  }


  void _onTabataTicked(TabataTicked event, Emitter<TabataState> emit){
    /// Controls Interval


    if(event.duration == 4){
      /// Setting MyAudioHandler == true: adjust the audio session configuration to duck audio
      /// Setting MyAudioHandler == false: adjust the audio session configuration to mix with others
      EmomAudioPlayer.stop();
      EmomAudioPlayer = MyAudioHandler(true, 0);
      EmomAudioPlayer.play();
    }

    // if(event.duration == 0){
    //   state.tabataModel.rounds = state.tabataModel.rounds! + 1;
    // }
    if(event.duration < 0){
      EmomAudioPlayer.stop();
      EmomAudioPlayer = MyAudioHandler(false, 1);
      EmomAudioPlayer.play();


      tabataWorkingSubscription?.cancel();
      tabataRestSubscription?.cancel();
      // ToDo: Remove ~/10 for publication

      /// Original
      //emit(state.copyWith( status: TabataStatus.resting , interval: state.tabataModel.interval ));
      state.totalDuration = state.totalDuration -1;
      emit(state.copyWith( intervalStatus: IntervalStatus.resting , status: TabataStatus.resting, interval: state.tabataModel.interval -1));


      /// Condition to restart Round

      /// Original

      add(TabataStartRestInterval(restDuration: state.tabataModel.restInterval - 1));
    }
    if(event.duration >= 0){
      emit(state.copyWith(interval: event.duration));
      state.totalDuration = state.totalDuration -1;
    }
    print('interval: ${event.duration} || resting interval: ${state.restInterval}');


  }

  void _onTabataStartRestInterval(TabataStartRestInterval event, Emitter<TabataState> emit){
    /// Controls state.restInterval
    emit(state.copyWith(status: TabataStatus.resting));

    // tabataWorkingSubscription?.cancel();
    // tabataRestSubscription?.cancel();

    tabataRestSubscription =  tabataRestingController.TabataResting(seconds:(event.restDuration))
        .listen((event) => add(TabataRestingTicked(duration: event)));

  }


  void _onTabataRestingTicked(TabataRestingTicked event, Emitter<TabataState>  emit){
    /// Controls Resting intervals

    /// Test

    if(event.duration == 4){
      /// Setting MyAudioHandler == true: adjust the audio session configuration to duck audio
      /// Setting MyAudioHandler == false: adjust the audio session configuration to mix with others
      EmomAudioPlayer.stop();
      EmomAudioPlayer = MyAudioHandler(true, 0);
      EmomAudioPlayer.play();
    }

    // if(event.duration == 0){
    //   state.tabataModel.rounds = state.tabataModel.rounds! + 1;
    // }
    if(event.duration < 0){
      EmomAudioPlayer.stop();
      EmomAudioPlayer = MyAudioHandler(false, 1);
      EmomAudioPlayer.play();


      state.tabataModel.rounds = state.tabataModel.rounds + 1;
      tabataWorkingSubscription?.cancel();
      tabataRestSubscription?.cancel();
      // ToDo: Remove ~/10 for publication

      /// Original
      // emit(state.copyWith( status: TabataStatus.inProgress , restInterval: (state.tabataModel.restInterval)), );
      /// Test
      state.totalDuration = state.totalDuration -1;
      emit(state.copyWith( intervalStatus: IntervalStatus.working ,status: TabataStatus.inProgress, restInterval: (state.tabataModel.restInterval -1)),  );


      /// Original
      if(state.tabataModel.rounds < state.rounds) {
        add(TabataStartInterval(duration: state.tabataModel.interval - 1));
      }else{
        ///add(TabataReset(fullReset: false));
        // ToDo: Create Finished Tabata Page
        emit(state.copyWith(status: TabataStatus.finished));

      }
    }
    if(event.duration >= 0){
      emit(state.copyWith(restInterval: event.duration));
      state.totalDuration = state.totalDuration - 1;
    }
    print('interval: ${state.interval} || resting interval: ${state.restInterval}');












    /// Original
    // if(event.duration == 5){
    //   /// Setting MyAudioHandler == true: adjust the audio session configuration to duck audio
    //   /// Setting MyAudioHandler == false: adjust the audio session configuration to mix with others
    //   // EmomAudioPlayer.stop();
    //   // EmomAudioPlayer = MyAudioHandler(true, 0);
    //   // EmomAudioPlayer.play();
    // }
    //
    // // if(event.duration == 0){
    // //   state.tabataModel.rounds = state.tabataModel.rounds! + 1;
    // // }
    // if(event.duration == 0){
    //   state.tabataModel.rounds = state.tabataModel.rounds! + 1;
    //   // EmomAudioPlayer.stop();
    //   // EmomAudioPlayer = MyAudioHandler(false, 1);
    //   // EmomAudioPlayer.play();
    //
    //   tabataRestSubscription?.cancel();
    //
    //   // ToDo: Remove ~/10 for publication
    //   emit(state.copyWith( status: TabataStatus.inProgress, interval: (state.tabataModel.interval ~/ 10) - 1 ) );
    //   /// Condition to restart Round
    //
    //   /// Original
    //   if(state.tabataModel.rounds < state.rounds){
    //
    //
    //     //     tabataWorkingController.TabataWorking(seconds:(state.tabataModel.interval ~/10))
    //     //         .listen((event) => add(TabataTicked(duration: event)));
    //     // state.totalDuration = state.totalDuration - 1;
    //
    //     // tabataWorkingController.Emom(seconds:(state.interval))
    //     //     .listen((event) => add(TabataRestingTicked(duration: state.restInterval ~/10)));
    //     // state.totalDuration = state.totalDuration - 1;
    //
    //     add(TabataStartInterval(duration: state.tabataModel.interval));
    //
    //   }
    //
    //
    // }
    // if(event.duration >= 0){
    //   emit(state.copyWith(restInterval: event.duration));
    //   state.totalDuration = state.totalDuration - 1;
    // }
    // print('interval: ${event.duration} || resting interval: ${state.restInterval}');




    ///
  }


  void _onTabataPause(TabataPause event, Emitter<TabataState> emit){
    /// Add Stream Controllers
    /// Might have to add bools
    // ToDo: Remove * 60 before publishing!
    emit(state.copyWith(status: TabataStatus.paused, interval: state.interval, restInterval: state.restInterval));
    tabataWorkingSubscription?.cancel();
    tabataRestSubscription?.cancel();
    print(state.interval);
  }

  void _onTabataReset(TabataReset event, Emitter<TabataState> emit){
    EmomAudioPlayer.stop();
    EmomAudioPlayer = MyAudioHandler(false, 1);
    EmomAudioPlayer.play();
    /// Resets
    if(event.fullReset){
      /// if fullReset is true -> deletes List tabataWorkouts
      tabataWorkouts = [];
      emit(state.copyWith(status: TabataStatus.setup, restControllerIndex: 6, intervalControllerIndex: 6, roundControllerIndex: 9));

      state.roundController = FixedExtentScrollController(initialItem: 9);
      state.durationController = FixedExtentScrollController(initialItem: 5);
      state.restController = FixedExtentScrollController(initialItem: 5);
      tabataWorkingSubscription?.cancel();
      tabataRestSubscription?.cancel();
    }else{
      /// Original
      //emit(state.copyWith(status: TabataStatus.setup, restControllerIndex: 26, intervalControllerIndex: 56, roundControllerIndex: 9));

      /// Test
      emit(state.copyWith(status: TabataStatus.setup, restControllerIndex: 6, intervalControllerIndex: 6, roundControllerIndex: 9));

      state.roundController = FixedExtentScrollController(initialItem: 9);
      state.durationController = FixedExtentScrollController(initialItem: 5);
      state.restController = FixedExtentScrollController(initialItem: 5);
      tabataWorkingSubscription?.cancel();
      tabataRestSubscription?.cancel();
    }

  }

  void _onUpdateTabata(UpdateTabata event, Emitter<TabataState> emit) {
    emit(state.copyWith(
        totalDuration: event.totalDuration,
        interval: workRestScrollText[event.intervalControllerIndex ?? state.intervalControllerIndex]?.last,
        restInterval: workRestScrollText[event.restControllerIndex ?? state.restControllerIndex]?.last,
        status: event.status,
        description: event.description,
        rounds: event.rounds,

        /// Index Updates on each scroll wheel update
        roundControllerIndex: event.roundControllerIndex,
        intervalControllerIndex: event.intervalControllerIndex,
        restControllerIndex: event.restControllerIndex,

        durationController: event.workController,
        restController: event.restController,
    ));

    //print('interval: ${state.interval}:${testMap[event.interval]}: event.interval: ${event.interval}');
    //print('restInterval: ${state.restInterval}:${workRestScrollText[state.restInterval]?.first}');
    //print('state.round: ${state.rounds} | event.round: ${event.rounds}');
    print('total Duration: ${state.rounds} * ${workRestScrollText[state.intervalControllerIndex]?.last} + ${workRestScrollText[state.restControllerIndex]?.last} = ${(workRestScrollText[state.intervalControllerIndex]?.last + workRestScrollText[state.restControllerIndex]?.last ) * state.rounds}');
  }
  void _onCreateTabataWorkout(CreateTabataWorkout event, Emitter<TabataState> emit){
    /// After the setUp state TabataWorkout is created and its also placed in the tabataWorkouts []

    TabataModel newTabataModel = TabataModel(
        totalDuration:(workRestScrollText[state.intervalControllerIndex]?.last + workRestScrollText[state.restControllerIndex]?.last )  * state.rounds,
        interval: state.interval, //workRestScrollText[state.intervalControllerIndex]?.last,
        restInterval: state.restInterval, //workRestScrollText[state.restControllerIndex]?.last,
        rounds: 0,
        description: state.description == '' ? 'Custom\nWork: ${workRestScrollText[state.intervalControllerIndex]?.first}\nRest: ${workRestScrollText[state.restControllerIndex]?.first}' : state.description

      //description: state.description == '' ? 'Custom\n${state.rounds} Rounds\nWork: ${workRestScrollText[state.intervalControllerIndex]?.first}\nRest: ${workRestScrollText[state.restControllerIndex]?.first}' : state.description
    );
    /// Update the state Tabata Model & tabataWorkoutList

    state.totalDuration = newTabataModel.totalDuration;
    state.tabataModel = newTabataModel;
    tabataWorkouts.add(newTabataModel);
    print('state.TabataModel.TotalDuration :${state.tabataModel.totalDuration}|| State.interval: ${state.interval} || state.restInterval ${state.restInterval} || rounds: ${state.rounds}');
  }

  String fetchTabataWorkoutData(){
    String EmomData = '';
    if(tabataWorkouts.isNotEmpty) {
      for (TabataModel item in tabataWorkouts) {
        EmomData += '**TABATA**\n${item.totalDuration ~/ 60} Minutes, ${item
            .rounds} Rounds\n${item.description ?? 'Custom'}\n\n';
      }
      return '\n**TABATA Review**\n\n$EmomData';
    }
    return '';
  }


}
