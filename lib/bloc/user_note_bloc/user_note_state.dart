part of 'user_notes_bloc.dart';


enum UserNoteStatus{loading, loaded}
class UserNoteState extends Equatable{

  List<UserWorkoutNotes>? userWorkoutData;
  UserNoteStatus status;


  UserNoteState({this.userWorkoutData, required this.status});

  UserNoteState copyWith({
    List<UserWorkoutNotes>? userWorkoutData,
    UserNoteStatus? status
  }) => UserNoteState(
      userWorkoutData: userWorkoutData ?? this.userWorkoutData,
      status: status ?? this.status
  );

  @override
  List<Object?> get props => [userWorkoutData, status];
}
