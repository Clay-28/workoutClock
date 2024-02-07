part of 'scroll_wheel_bloc.dart';



abstract class ScrollWheelState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ScrollWheelInitial extends ScrollWheelState{
 ScrollWheelInitial({required this.minSelected, required this.secondSelected});
 final int minSelected;
 final int secondSelected;

 @override
 List<Object> get props => [minSelected, secondSelected];
}


final class ScrollWheelInProgress extends ScrollWheelState{
  ScrollWheelInProgress();
}


final class ScrollWheelUpdate extends ScrollWheelState{
  ScrollWheelUpdate({required this.minSelected, required this.secondSelected});

  final int minSelected;
  final int secondSelected;

  @override
  List<Object> get props => [minSelected, secondSelected];
}

final class ScrollWheelVanish extends ScrollWheelState{
  ScrollWheelVanish();
}