part of 'allocation_bloc.dart';

@immutable
class AllocationEvent extends BaseEquatable {}

class AllocationInitialEvent extends AllocationEvent {}

class AllocationTabLoadedEvent extends AllocationEvent {
  String tabLoaded = "priority";

  AllocationTabLoadedEvent({required this.tabLoaded});
}

class NavigateSearchPageEvent extends AllocationEvent {}

class SearchReturnDataEvent extends AllocationEvent {
  SearchReturnDataEvent({this.returnValue});

  final dynamic returnValue;
}

class InitialCurrentLocationEvent extends AllocationEvent {}

class AllocationTabClicked extends AllocationEvent {

  int tab;

  AllocationTabClicked({required this.tab});
}

class MapViewEvent extends AllocationEvent {
  final BuildRouteDataModel paramValues;
  int pageKey;

  MapViewEvent({required this.paramValues, required this.pageKey});
}

class BuildRouteFilterClickedEvent extends AllocationEvent {
  int index = 0;

  BuildRouteFilterClickedEvent(this.index);
}
