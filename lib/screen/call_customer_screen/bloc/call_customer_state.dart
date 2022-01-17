part of 'call_customer_bloc.dart';

@immutable
class CallCustomerState extends BaseEquatable {}

class CallCustomerInitial extends CallCustomerState {}

class CallCustomerLoadingState extends CallCustomerState {}

class CallCustomerLoadedState extends CallCustomerState {}

class CallCustomerFailureState extends CallCustomerState {}

class CallCustomerSuccessState extends CallCustomerState {}

class NoInternetState extends CallCustomerState {}

class DisableSubmitState extends CallCustomerState {}

class EnableSubmitState extends CallCustomerState {}
