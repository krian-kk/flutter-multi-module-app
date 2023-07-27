import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeEvent { allocation, dashboard, profile }

class HomeBloc extends Bloc<HomeEvent, String> {
  HomeBloc() : super('Allocation') {
    on<HomeEvent>(_onEvent);
  }

  Future<void> _onEvent(HomeEvent event, Emitter<String> emit) async {
    switch (event) {
      case HomeEvent.allocation:
        emit('Allocation');
        break;
      case HomeEvent.dashboard:
        emit('Dashboard');
        break;
      case HomeEvent.profile:
        emit('Profile');
        break;
    }
  }
}
