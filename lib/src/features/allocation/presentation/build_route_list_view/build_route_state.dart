part of 'build_route_bloc.dart';

@immutable
abstract class BuildRouteState {}

class BuildRouteInitial extends BuildRouteState {}

class BuildRouteCasesCompletedState extends BuildRouteState {
  final List<PriorityCaseListModel> listItems;
  final int? nextPageKey;

  BuildRouteCasesCompletedState(this.listItems, [this.nextPageKey]);
}
