part of 'allocation_bloc.dart';

@immutable
class AllocationEvent extends BaseEquatable {}

class AllocationInitialEvent extends AllocationEvent {}

class AllocationTabLoadedEvent extends AllocationEvent {
  AllocationTabLoadedEvent({required this.tabLoaded});
  String tabLoaded = "priority";
}

class NavigateSearchPageEvent extends AllocationEvent {}

class SearchReturnDataEvent extends AllocationEvent {
  SearchReturnDataEvent({this.returnValue});

  final dynamic returnValue;
}

class InitialCurrentLocationEvent extends AllocationEvent {}

class AllocationTabClicked extends AllocationEvent {

  AllocationTabClicked({required this.tab});

  int tab;
}

class MapViewEvent extends AllocationEvent {

  MapViewEvent({required this.paramValues, required this.pageKey});
  final BuildRouteDataModel paramValues;
  int pageKey;
}

class BuildRouteFilterClickedEvent extends AllocationEvent {

  BuildRouteFilterClickedEvent(this.index);
  int index = 0;
}

class TapAreYouAtOfficeOptionsEvent extends AllocationEvent {}
