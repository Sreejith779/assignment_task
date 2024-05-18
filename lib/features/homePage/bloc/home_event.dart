part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent{}
class HomeSaveEvent extends HomeEvent{
  final String label;
  final String info;
  final List settings;

  HomeSaveEvent({required this.label, required this.info,required this.settings});
}

class HomeAddEvent extends HomeEvent{}