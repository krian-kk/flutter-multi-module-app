import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/case_repository.dart';

part 'priority_event.dart';

part 'priority_state.dart';

class PriorityBloc extends Bloc<PriorityEvent, PriorityState> {
  PriorityBloc({required this.repository}) : super(PriorityInitial()) {
    on<PriorityEvent>(_onEvent);
  }

  CaseRepositoryImpl repository;

  FutureOr<void> _onEvent(PriorityEvent event, Emitter<PriorityState> emit) {
    if (event is InitialPriorityEvent) {}
  }
}
