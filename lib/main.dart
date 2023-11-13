import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'models/user_workout_data.dart';
import 'models/workout_data.dart';
import 'screens/home_page.dart';
import 'screens/user_workout_notes_page.dart';
import 'screens/workout_clock_page.dart';
import 'services/workout_note_services.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserWorkoutNotesAdapter());
  runApp( const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context)=> WorkoutNotesServices())
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/WorkoutClockPage': (context) => WorkoutClockPage(),
          '/UserWorkoutNotesPage': (context) => UserWorkoutNotesPage(),
          '/UserWorkoutNotePage': (context) => UserWorkoutNotesPage(),
        }
      )
    );
  }
}
