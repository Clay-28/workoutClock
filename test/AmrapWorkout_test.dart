


import 'package:WorkoutClock/ARAMP_Componets/AMRAP_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  AmrapWorkouts workouts = AmrapWorkouts();
  test("Testing AmrapWorkout Class if randomAmrapWorkout() returns an AmrapModel" , (){

    AmrapModel mockWorkout = workouts.randomAmrapWorkout();

    expect(mockWorkout, isA<AmrapModel>());
  });

}