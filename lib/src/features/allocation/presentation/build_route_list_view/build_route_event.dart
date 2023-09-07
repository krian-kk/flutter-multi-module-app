part of 'build_route_bloc.dart';

@immutable
abstract class BuildRouteEvent {}

class LoadBuildRouteCases extends BuildRouteEvent {
  final int pageKey;

  LoadBuildRouteCases(this.pageKey);
}
