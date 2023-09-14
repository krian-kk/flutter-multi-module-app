part of 'build_route_bloc.dart';

@immutable
abstract class BuildRouteEvent {}

class LoadBuildRouteCases extends BuildRouteEvent {
  final int pageKey;
  final BuildRouteDataModel paramValues;

  LoadBuildRouteCases({
    required this.pageKey,
    required this.paramValues,
  });
}

class BuildRouteFilterClicked extends BuildRouteEvent {
  String? selectedDistance;
  BuildRouteDataModel paramValues;
  int pageKey;

  BuildRouteFilterClicked(
      {required this.selectedDistance,
      required this.paramValues,
      required this.pageKey});
}
