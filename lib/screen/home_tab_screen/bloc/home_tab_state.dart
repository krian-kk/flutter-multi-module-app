import 'package:flutter/cupertino.dart';
import 'package:origa/utils/base_equatable.dart';

@immutable
abstract class HomeTabState extends BaseEquatable {}

class HomeTabInitialState extends HomeTabState {}

class HomeTabLoadingState extends HomeTabState {}

class HomeTabLoadedState extends HomeTabState {}
// class NavigateAllocationState extends HomeTabState {}
// class NavigateHomeTabState extends HomeTabState {}
// class NavigateProfileState extends HomeTabState {}

// class MapViewState extends HomeTabState {}

// class MessageState extends HomeTabState {}

// class PriorityFollowState extends HomeTabState {}

// class UntouchedCasesState extends HomeTabState {}

// class BrokenPTPState extends HomeTabState {}

// class MyReceiptsState extends HomeTabState {}

// class MyVisitsState extends HomeTabState {}

// class MyDeposistsState extends HomeTabState {}

// class YardingAndSelfReleaseState extends HomeTabState {}
