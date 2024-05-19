import 'dart:async';

import 'package:assignment_task/features/homePage/ui/widget/form.dart';
import 'package:assignment_task/features/model/saveList.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeSaveEvent>(homeSaveEvent);
    on<HomeAddEvent>(homeAddEvent);
    on<HomeDeleteEvent>(homeDeleteEvent);
  }


  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) {
    forms.add(FormModel());
    emit(HomeLoadedState());
  }

  FutureOr<void> homeSaveEvent(HomeSaveEvent event, Emitter<HomeState> emit) {
    final _label = event.label ?? '';
    final info = event.info ?? '';
    final settings = event.settings ?? [];
    savedList.add({
      "label'": _label,
      "info": info,
      "settings": settings
    });
    print(savedList);
 emit(HomeSaveActionState(saved: savedList));
    emit(HomeLoadedState());
  }

  FutureOr<void> homeAddEvent(HomeAddEvent event, Emitter<HomeState> emit) {
    forms.add(FormModel());
    emit(HomeLoadedState());
  }

  FutureOr<void> homeDeleteEvent(HomeDeleteEvent event, Emitter<HomeState> emit) {
    if (event.index >= 1 && event.index < forms.length) {
      forms.removeAt(event.index);
      print("Form at index ${event.index} removed");
    }
    emit(HomeLoadedState());
  }
}
