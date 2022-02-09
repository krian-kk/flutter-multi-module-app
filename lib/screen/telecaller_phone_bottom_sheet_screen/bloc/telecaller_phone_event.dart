part of 'telecaller_phone_bloc.dart';

@immutable
class TelecallerPhoneEvent extends BaseEquatable {}

class TelecallerInitialPhoneEvent extends TelecallerPhoneEvent {
  final BuildContext? context;
  TelecallerInitialPhoneEvent(this.context);
}

class ClickOpenBottomSheetEvent extends TelecallerPhoneEvent {
  final String title;
  final List? list;
  final bool? isCall;
  final String? health;
  final BuildContext? context;
  ClickOpenBottomSheetEvent(this.title, this.list, this.isCall,
      {this.health, this.context});
}
