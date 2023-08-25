import 'dart:async';

import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/case_repository.dart';
import 'package:rxdart/rxdart.dart';

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

  static const _pageSize = 20;

  final _onNewListingStateController =
      BehaviorSubject<MerchantListingState>.seeded(
    MerchantListingState(),
  );

  Stream<MerchantListingState> get onNewListingState =>
      _onNewListingStateController.stream;

  final _onPageRequest = StreamController<int>();

  Sink<int> get onPageRequestSink => _onPageRequest.sink;

  Stream<MerchantListingState> fetchPage(int pageKey) async* {
    final lastListingState = _onNewListingStateController.value;
    debugPrint("qwqeqrew");
    try {
      yield MerchantListingState(
          error: null,
          nextPageKey: lastListingState.nextPageKey,
          itemList: lastListingState.itemList);
      final newItems = await repository.getCasesFromServer(_pageSize, pageKey);
      debugPrint("data---->  ");
      final isLastPage = newItems.length < _pageSize;
      final nextPageKey = isLastPage ? null : pageKey + newItems.length;
      debugPrint("fdsfsfdf");
      yield MerchantListingState(
          error: null,
          nextPageKey: nextPageKey?.toInt(),
          itemList: [...lastListingState.itemList ?? [], ...newItems]);
    } catch (e) {
      yield MerchantListingState(
          error: e,
          nextPageKey: lastListingState.nextPageKey,
          itemList: lastListingState.itemList);
    }
  }
}

class MerchantListingState {
  MerchantListingState({this.itemList, this.error, this.nextPageKey = 0});

  final List<PriorityCaseListModel>? itemList;
  final dynamic error;
  final int? nextPageKey;
}
