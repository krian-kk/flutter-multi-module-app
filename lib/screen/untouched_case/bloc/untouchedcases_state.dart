part of 'untouchedcases_bloc.dart';

@immutable
abstract class UntouchedcasesState extends BaseEquatable {}

class UntouchedcasesInitial extends UntouchedcasesState {}

class UntouchedcasesLoadingState extends UntouchedcasesState {}

class UntouchedcasesLoadedState extends UntouchedcasesState {}
