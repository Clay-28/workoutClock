import 'package:flutter/material.dart';

import '../widgets/workout_Notes/user_workout_notes.dart';

class UserWorkoutNotesPage extends StatelessWidget {
  const UserWorkoutNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pushNamed(context, '/');},
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Notes',),
      ),
      body:
      /// Add Note Bloc Provider
      UserWorkoutNotes(),
    );
  }
}
