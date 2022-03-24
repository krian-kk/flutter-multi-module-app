part of 'event_details_bloc.dart';

@immutable
class EventDetailsEvent extends BaseEquatable {}

class EventDetailsInitialEvent extends EventDetailsEvent {
  final String caseId;
  final String userType;
  EventDetailsInitialEvent(this.caseId, this.userType);
}
