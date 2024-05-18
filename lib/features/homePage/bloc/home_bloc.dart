import 'dart:async';

import 'package:assignment_task/features/model/saveList.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
   on<HomeInitialEvent>(homeInitialEvent);
   on<HomeSaveEvent>(homeSaveEvent);

  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) {

    emit(HomeLoadedState());
  }



  FutureOr<void> homeSaveEvent(HomeSaveEvent event, Emitter<HomeState> emit) {
     savedList.add({
       "label'":event.label,
       "info": event.info,
       "settings":event.settings
     });
     print(savedList);

     emit(HomeLoadedState());

  }
}
