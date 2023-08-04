abstract class HomeEvent {}

enum HomeTabValue { allocation, dashboard, profile }

class HomeInitialEvent extends HomeEvent {
  HomeInitialEvent({this.notificationData});

  final dynamic notificationData;
}

class TabHomeEvent extends HomeEvent {
  TabHomeEvent({required this.tab});

  final HomeTabValue tab;
}
