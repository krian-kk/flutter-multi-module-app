import 'package:flutter/cupertino.dart';
import 'package:origa/utils/base_equatable.dart';

@immutable
abstract class HomeState extends BaseEquatable {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {}

class NavigateState extends HomeState {
  NavigateState({this.notificationData, this.context});

  final dynamic notificationData;
  final BuildContext? context;
}
