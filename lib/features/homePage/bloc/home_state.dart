part of 'home_bloc.dart';

@immutable
abstract class HomeState {}
abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadedState extends HomeState{}

class HomeSaveActionState extends HomeActionState{
  final List saved;

  HomeSaveActionState({required this.saved});

}