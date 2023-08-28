part of 'priority_bloc.dart';

class PriorityState extends BaseEquatable {}

class PriorityInitial extends PriorityState {}

class PriorityLoadingState extends PriorityState {}

class PriorityCompletedState extends PriorityState {
  PriorityCompletedState(this.listItems, [this.nextPageKey]);

  final int? nextPageKey;
  final List<PriorityCaseListModel> listItems;
}

class PriorityListErrorState extends PriorityState {
  PriorityListErrorState(this.error);

  final String error;
}
