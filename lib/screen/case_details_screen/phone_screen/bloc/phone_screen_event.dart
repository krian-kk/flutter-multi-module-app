part of 'phone_screen_bloc.dart';

@immutable
class PhoneScreenEvent extends BaseEquatable {}

class PhoneScreenBottomSheetIntialEvent extends PhoneScreenEvent {
  PhoneScreenBottomSheetIntialEvent(
      {required this.context, required this.caseDetailsBloc});
  final BuildContext context;
  final CaseDetailsBloc caseDetailsBloc;
}

// class PhoneScreenBottomSheetLoadingEvent extends PhoneScreenEvent {}

// class PhoneScreenBottomSheetLoadedEvent extends PhoneScreenEvent {}
