import 'package:WorkoutClock/bloc/middle_area_bloc/middle_area_bloc.dart';
import 'package:WorkoutClock/screens/intro_screen.dart';
import 'package:WorkoutClock/services/workout_note_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import 'bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import 'bloc/Amrap_Emom_Tabata_Bloc/Modes_Bloc/modes_bloc.dart';
import 'bloc/clock_bloc/clock_bloc.dart';
import 'bloc/note_bloc/note_bloc.dart';
import 'bloc/scroll_wheel_bloc/scroll_wheel_bloc.dart';
import 'items/ticks.dart';
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
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider<TimerBloc>(
              create: (BuildContext context) => TimerBloc(ticker: const Ticker()),
            ),
            BlocProvider<ScrollWheelBloc>(
              create: (BuildContext context) => ScrollWheelBloc(),
            ),
            BlocProvider<NoteBloc>(
              create: (BuildContext context) => NoteBloc()..add(RegisterHiveEvent()),
            ),
            BlocProvider<AMRAPBloc>(
                create: (BuildContext context)=> AMRAPBloc()),
            BlocProvider<MiddleAreaBloc>(
              create: (BuildContext context)=> MiddleAreaBloc()),
            BlocProvider<WorkoutModesBloc>
              (create: (BuildContext context)=> WorkoutModesBloc()),
            BlocProvider<MiddleAreaBloc>(
              create: (BuildContext context)=> MiddleAreaBloc(),
            ),
            BlocProvider<EmomBloc>(
                create: (BuildContext context)=> EmomBloc())
          ],
          child : WorkoutApp()
      ));
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
