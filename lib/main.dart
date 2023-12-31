import 'package:WorkoutClock/screens/intro_screen.dart';
import 'package:WorkoutClock/services/workout_note_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'models/user_workout_data.dart';
import 'screens/home_page.dart';
import 'screens/user_workout_notes_page.dart';
import 'screens/workout_clock_page.dart';



//late AudioHandler audioHandler;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserWorkoutNotesAdapter());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => IntroScreen(), //HomePage(),
          '/WorkoutClockPage': (context) => const WorkoutClockPage(),
          '/UserWorkoutNotesPage': (context) => const UserWorkoutNotesPage(),
          '/HomePage': (context) => const HomePage(),
        }
      )
    );
  }
}
