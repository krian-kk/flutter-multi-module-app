part of 'phone_screen_bloc.dart';

@immutable
class PhoneScreenEvent extends BaseEquatable {}

class PhoneScreenBottomSheetIntialEvent extends PhoneScreenEvent {
  final BuildContext context;
  final CaseDetailsBloc caseDetailsBloc;
  PhoneScreenBottomSheetIntialEvent(
      {required this.context, required this.caseDetailsBloc});
}

class PhoneScreenBottomSheetLoadingEvent extends PhoneScreenEvent {}

class PhoneScreenBottomSheetLoadedEvent extends PhoneScreenEvent {}
