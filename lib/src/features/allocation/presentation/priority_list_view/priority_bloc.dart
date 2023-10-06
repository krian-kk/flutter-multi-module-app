import 'dart:async';

import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:repository/case_repository.dart';

part 'priority_event.dart';

part 'priority_state.dart';

class PriorityBloc extends Bloc<PriorityEvent, PriorityState> {
  PriorityBloc({required this.repository}) : super(PriorityInitial()) {
    on<PriorityEvent>(_onEvent);
  }

  CaseRepositoryImpl repository;
  static const _pageSize = 10;
  List<PriorityCaseListModel> priorityResultList = <PriorityCaseListModel>[];

  Future<void> _onEvent(
      PriorityEvent event, Emitter<PriorityState> emit) async {
    if (event is LoadPriorityList) {
      emit(PriorityLoadingState());

      final newItems =
          await repository.getCasesFromServer(_pageSize, event.pageKey);
      await newItems.when(
          success: (List<PriorityCaseListModel>? result) async {
            if (result?.isNotEmpty == true && result != null) {
              priorityResultList.clear();
              priorityResultList = result;

              final isLastPage = result.length < _pageSize;
              if (isLastPage) {
                emit(PriorityCompletedState(result));
                // _pagingController.appendLastPage(newItems);
              } else {
                final nextPageKey = event.pageKey + result.length;
                emit(PriorityCompletedState(result, nextPageKey));

                // _pagingController.appendPage(newItems, nextPageKey);
              }
            }
          },
          failure: (NetworkExceptions? error) async {});
    }
  }
}

class PriorityStateListState {
  PriorityStateListState({this.itemList, this.error, this.nextPageKey = 0});

  final List<PriorityCaseListModel>? itemList;
  final dynamic error;
  final int? nextPageKey;
}
