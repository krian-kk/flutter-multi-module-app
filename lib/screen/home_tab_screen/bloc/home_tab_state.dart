import 'package:flutter/cupertino.dart';
import 'package:origa/utils/base_equatable.dart';

@immutable
abstract class HomeTabState extends BaseEquatable {}

class HomeTabInitialState extends HomeTabState {}

class HomeTabLoadingState extends HomeTabState {}

class HomeTabLoadedState extends HomeTabState {}

class NavigateTabState extends HomeTabState {
  NavigateTabState({this.notificationData, this.context});
  final dynamic notificationData;
  final BuildContext? context;
}
