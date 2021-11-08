part of 'myreceipts_bloc.dart';

@immutable
abstract class MyreceiptsState extends BaseEquatable {}

class MyreceiptsInitial extends MyreceiptsState {}

class MyreceiptsLoadingState extends MyreceiptsState {}

class MyreceiptsLoadedState extends MyreceiptsState {}