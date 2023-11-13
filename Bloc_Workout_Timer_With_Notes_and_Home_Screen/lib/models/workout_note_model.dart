
import 'package:equatable/equatable.dart';

class WorkoutNoteModel extends Equatable{

  /// When should the date time be created?
  /// When the event is triggered to make a Note Model

  /*
  String day = DateTime.now().day.toString();
  String month = DateTime.now().month.toString();
  String year = DateTime.now().year.toString();

   */

  @override
  initState(){
    String day = DateTime.now().day.toString();
    String month = DateTime.now().month.toString();
    String year = DateTime.now().year.toString();
  }

  @override
  List<Object> get props => [];
}