
import 'dart:math';

class AmrapModel{

  int duration;
  int? rounds = 0;
  String? description;

  AmrapModel({required this.duration, this.rounds, this.description});

}

class AmrapWorkouts{


  List<AmrapModel> fetchPopularAmrapWorkouts(){
    return _AmrapWorkouts;
  }

  AmrapModel randomAmrapWorkout(){
    return _AmrapWorkouts[Random().nextInt(_AmrapWorkouts.length-1)];
  }

  // AmrapModel Cidney = AmrapModel(duration: 20,  description: '\nCINDY,\n5 Pull-Ups,\n10 Push-Ups,\n15 Air Squats');
  // AmrapModel Jack = AmrapModel(duration: 20,  description: '\nJACK,\n10 Push Presses 115/85,\n10 Kettelbell Swings 54/35,\n10 Box Jumps 24/20');
  // AmrapModel Rankel = AmrapModel(duration: 20, description: '\n6 Deadlifts 225/155,\n7 Burpee pull-ups,\n10 Kettlebell Swings 70/54');
  // AmrapModel Marston = AmrapModel(duration: 20, description: '\n6 Deadlifts 225/155,\n10 Toes-To-Bar,\n7 Burpees');
  // AmrapModel Danny = AmrapModel(duration: 20, description: '\n30 Box Jumps 24/20,\n20 Push Presses 115/75,\n30 Pull-Ups');
  // AmrapModel Jennifer = AmrapModel(duration: 25, description: '\n10 Pull-Ups,\n15 Kettlebell Swings,\n20 Box Jumps');
  // AmrapModel Mary = AmrapModel(duration: 20, description: '\n10 Dumbbell Thrusters\n10 Pistols,\n5 Pull-Ups');


  final Map<int,List<dynamic>> _popularAmrapWorkout = {
    0 : ['Cidney', AmrapModel(duration: 20,  description: 'CINDY,\n5 Pull-Ups,\n10 Push-Ups,\n15 Air Squats')],
    1 : ['Jack' ,AmrapModel(duration: 20,  description: 'JACK,\n10 Push Presses 115/85,\n10 Kettelbell Swings 54/35,\n10 Box Jumps 24/20')],
    2 : ['Rankel' , AmrapModel(duration: 20, description: '6 Deadlifts 225/155,\n7 Burpee pull-ups,\n10 Kettlebell Swings 70/54')],
    3 : ['Marston' , AmrapModel(duration: 20, description: '6 Deadlifts 225/155,\n10 Toes-To-Bar,\n7 Burpees')],
    4 : ['Danny' ,AmrapModel(duration: 20, description: '30 Box Jumps 24/20,\n20 Push Presses 115/75,\n30 Pull-Ups')],
    5 : ['Jennifer' ,AmrapModel(duration: 25, description: '10 Pull-Ups,\n15 Kettlebell Swings,\n20 Box Jumps')],
    6: ['Mary' ,AmrapModel(duration: 20, description: '10 Dumbbell Thrusters\n10 Pistols,\n5 Pull-Ups')]
  };

  final List<AmrapModel> _AmrapWorkouts = [
    AmrapModel(duration: 10, description: '10 Squats,\n10 Jump Squats,\n10 Lunges,\n10 Jump Lunges'),
    AmrapModel(duration: 15, description: '10 Burpees,\n10 Air Squats,\n20 Mountain Climbers'),
    AmrapModel(duration: 7, rounds: 0, description: '10 Push-Ups,\n20 Walking Lunges,\n30 Jump Rope Singles'),
    AmrapModel(duration: 10, rounds: 0, description: '15 Bx Jumps 14/20,\n12 Push Presses 115/75,\n9 toes-to-bar'),
    AmrapModel(duration: 10,  description: 'CINDY,\n5 Pull-Ups,\n10 Push-Ups,\n15 Air Squats,'),
    AmrapModel(duration: 10, description: '100 Cal Row,\n50 Toes-To-Bar-\n40 Wall Ball 20/14,\n30 Dumbbell Push Presses,\n20 Pull-Ups'),
    AmrapModel(duration: 10, description: '30 Double-Unders,\n15 Toes-To-Bar' ),
    AmrapModel(duration: 10, description: '30 Double-Unders,\n10 Dumbbell Push Press'),
    AmrapModel(duration: 10, description: '7 Push-Ups,\n50 Wall Balls,\n100 Double-Unders' ),
    AmrapModel(duration: 20, description: '4 Dumbbell Thrusters,\n6 Toes-To-Bar,\n24 Double-Unders'),
    AmrapModel(duration: 10, description: '15 Wall Balls,\n100 Cal Row,'),
    AmrapModel(duration: 10, description: '25 Kettlebell Swings\n10 Air Squats,\n5 String Push-Ups\n 100 Jump Rope Singles' ),
    AmrapModel(duration: 20,  description: 'CINDY,\n5 Pull-Ups,\n10 Push-Ups,\n15 Air Squats'),
    AmrapModel(duration: 20,  description: 'JACK,\n10 Push Presses 115/85,\n10 Kettelbell Swings 54/35,\n10 Box Jumps 24/20'),
    AmrapModel(duration: 20, description: '6 Deadlifts 225/155,\n7 Burpee pull-ups,\n10 Kettlebell Swings 70/54'),
    AmrapModel(duration: 20, description: '6 Deadlifts 225/155,\n10 Toes-To-Bar,\n7 Burpees'),
    AmrapModel(duration: 20, description: '30 Box Jumps 24/20,\n20 Push Presses 115/75,\n30 Pull-Ups'),
    AmrapModel(duration: 25, description: '10 Pull-Ups,\n15 Kettlebell Swings,\n20 Box Jumps'),
    AmrapModel(duration: 20, description: '10 Dumbbell Thrusters\n10 Pistols,\n5 Pull-Ups'),
  ];

  final List<AmrapModel> _beginnerAmraps = [
    AmrapModel(duration: 10, description: '10 Squats,\n10 Jump Squats,\n10 Lunges,\n10 Jump Lunges'),
    AmrapModel(duration: 15, description: '10 Burpees,\n10 Air Squats,\n20 Mountain Climbers'),
  ];

}