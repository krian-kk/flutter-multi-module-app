import 'package:origa/utils/base_equatable.dart';

class HomeState extends BaseEquatable {}

class HomeInitialState extends HomeState {
  String error;
  HomeInitialState({required this.error});
}

class HomeLoadingState extends HomeState {}

class HomeRefreshState extends HomeState {}
