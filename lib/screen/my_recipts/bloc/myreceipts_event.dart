part of 'myreceipts_bloc.dart';

@immutable
abstract class MyreceiptsEvent extends BaseEquatable {}

class MyreceiptsInitialEvent extends MyreceiptsEvent {
   BuildContext context;
  MyreceiptsInitialEvent(this.context);
}
