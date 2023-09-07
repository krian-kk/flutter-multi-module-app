import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:meta/meta.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:repository/case_repository.dart';

part 'build_route_event.dart';

part 'build_route_state.dart';

class BuildRouteBloc extends Bloc<BuildRouteEvent, BuildRouteState> {
  CaseRepositoryImpl repository;
  static const _pageSize = 20;

  BuildRouteBloc({required this.repository}) : super(BuildRouteInitial()) {
    on<BuildRouteEvent>(_onEvent);
  }

  Future<void> _onEvent(
      BuildRouteEvent event, Emitter<BuildRouteState> emit) async {
    if (event is LoadBuildRouteCases) {
      final newItems =
          await repository.getBuildRouteCases(_pageSize, event.pageKey);
      await newItems.when(
          success: (List<PriorityCaseListModel>? result) async {
            if (result?.isNotEmpty == true && result != null) {
              final isLastPage = result.length < _pageSize;
              if (isLastPage) {
                emit(BuildRouteCasesCompletedState(result));
                // _pagingController.appendLastPage(newItems);
              } else {
                final nextPageKey = event.pageKey + result.length;
                emit(BuildRouteCasesCompletedState(result, nextPageKey));

                // _pagingController.appendPage(newItems, nextPageKey);
              }
            }
          },
          failure: (NetworkExceptions? error) async {});
    }
  }
}
