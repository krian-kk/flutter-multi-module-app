part of 'priorityfollowup_bloc.dart';

@immutable
abstract class PriorityfollowupState extends BaseEquatable {}

class PriorityfollowupInitial extends PriorityfollowupState {}

class PriorityfollowupLoadingState extends PriorityfollowupState {}

class PriorityfollowupLoadedState extends PriorityfollowupState {}
