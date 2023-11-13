
part of 'user_notes_bloc.dart';

class UserNotesEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class LoadingUserData extends UserNotesEvent{
  LoadingUserData();
}

class EditWorkoutNote extends UserNotesEvent{
  UserWorkoutNotes userWorkoutNotes;
  int index;
  EditWorkoutNote({required this.index, required this.userWorkoutNotes});
}

class DeleteWorkoutNote extends UserNotesEvent{
  int index;
  DeleteWorkoutNote({required this.index});
}

