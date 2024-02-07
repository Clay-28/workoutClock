import 'package:WorkoutClock/bloc/middle_area_bloc/middle_area_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Clock_scroll_wheel/break_time_ui.dart';
import '../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import 'middle_Amrap_widget.dart';
import 'middle_Emom_widget.dart';


class MiddleAreaBuilder extends StatelessWidget {
  const MiddleAreaBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MiddleAreaBloc, MiddleAreaState>
      (builder: (context, state){
        /// This Bloc builder will control the area between the clock and slide action widget
        if(state.status == MiddleAreaStatus.Clock){
          return BreakTimeSelector();
        }
        if(state.status == MiddleAreaStatus.Amramp){
          return MiddleAmrapWidget();
        }
        if(state.status == MiddleAreaStatus.Emom){
          return EmomMiddleAreaBuilder();
        }
        if(state.status == MiddleAreaStatus.Invisible){
          return Container(height: 220);
        }if(AMRAPBloc.Amrap_status == AMRAP_Status.finished){
          return Container(height: 220);
        }
        return Center(child: Text(state.status.toString(), style: TextStyle(fontSize: 20, color: Colors.white),),);
    });
  }
}
