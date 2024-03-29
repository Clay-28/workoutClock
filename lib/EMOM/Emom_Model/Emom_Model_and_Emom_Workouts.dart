import 'package:flutter/material.dart';



class EmomModel{

  int? interval;/// Value is seconds 1 min = 60 seconds
  int? rounds;
  int? totalDuration;
  String? description;

  EmomModel({this.interval, this.rounds, this.totalDuration, this.description});


}


class EmomWorkouts{

  List<EmomModel> fetchPopularEmomWorkouts(){
    return _EmomWorkouts;
  }

  final List<EmomModel> _EmomWorkouts = [
    EmomModel(interval: 60, rounds: 0, totalDuration: 60 * 20,
        description: 'Minute 1: 10 Toes to Bar\nMinute 2: Kettlebell Swings,'
            '\nMinute 3: 15 Calorie Row,\nMinute 4: 10 Push-Ups'),
    EmomModel(interval: 60, rounds: 0, totalDuration: 60 * 24,
        description: 'Min1: 5 Squat Clean,\nMin 2: 10 Power Clean,\n'
            'Min 3: 10 Thrusters,\nMin 4: 10 Push Press'),
    EmomModel(interval: 60, rounds: 0, totalDuration: 60 * 16,
        description: 'Min 1: 5 Heavy Back Squats,\nMin 2: 15 Jump Squats'),
    EmomModel(interval: 60, rounds: 0, totalDuration: 60 * 15,
        description: '1: 10 Thrusters,\nMinute 2: 15 Kettlebell Swings,\nMinute 3: 20 Sit-Ups'),
    EmomModel(interval: 60, rounds: 0, totalDuration: 60 * 10,
        description: 'Minute 1: 10 Jumping Lunges (total),\nMinute 2: 6 Push-Ups'),
    EmomModel(interval: 60, rounds: 0, totalDuration: 60 * 12,
        description: 'Minute 1: 150m Sprint,\nMinute 2: 12 Kettlebell Swings,\nMinute 3: 9 Pull-Ups'),
    EmomModel(interval: 60, rounds: 0, totalDuration: 60 * 12,
        description: 'Chelsea,\nMin 1: 5 Pull-Ups,\nMin 2: 10 Push-Ups,\nMin 3: 15 Air Squats'),
    EmomModel(interval: 60, rounds: 0, totalDuration: 60 * 10,
        description: 'Kettlebell Thruster x 12,\nKettlebell Row x 15,\nKettlebell Push-Up x 15'),
    EmomModel(interval: 60, rounds: 0, totalDuration: 60 * 21,
        description: 'Minute 1: 15 Wall Balls,\nMinute 2: 10 Push-Ups\n,Minute 3: 25 Double Unders'),
    EmomModel(interval: 60, rounds: 0, totalDuration: 60 * 21,
        description: 'Minute 1: 10 Dips,\nMinute 2: 10 Pull Ups\n,Minute 3: 20 Air Squats'),





  ];

}