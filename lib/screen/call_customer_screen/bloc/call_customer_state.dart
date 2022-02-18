part of 'call_customer_bloc.dart';

@immutable
class CallCustomerState extends BaseEquatable {}

class CallCustomerInitial extends CallCustomerState {}

class CallCustomerLoadingState extends CallCustomerState {}

class CallCustomerLoadedState extends CallCustomerState {}

class CallCustomerSuccessState extends CallCustomerState {}

class NoInternetState extends CallCustomerState {}

class NavigationPhoneBottomSheetState extends CallCustomerState {
  final String callId;
  NavigationPhoneBottomSheetState(this.callId);
}
