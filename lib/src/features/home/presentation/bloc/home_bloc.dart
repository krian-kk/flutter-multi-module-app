import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/src/features/home/presentation/bloc/home_event.dart';
import 'package:origa/src/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeEvent>(_onEvent);
  }

  int? notificationCount = 0;
  String? userType;

  Future<void> _onEvent(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeInitialEvent) {
      emit(HomeLoadingState());

      if (event.notificationData != null) {
        emit(NavigateState(notificationData: event.notificationData));
      }
      userType = '';
      emit(HomeLoadedState());
    }
  }
}
