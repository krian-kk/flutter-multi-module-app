part of 'call_customer_bloc.dart';

@immutable
class CallCustomerEvent extends BaseEquatable {}

class CallCustomerInitialEvent extends CallCustomerEvent {}

class DisableSubmitEvent extends CallCustomerEvent {}

class EnableSubmitEvent extends CallCustomerEvent {}
