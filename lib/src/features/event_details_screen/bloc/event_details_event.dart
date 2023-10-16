part of 'event_details_bloc.dart';

@immutable
class EventDetailsEvent extends BaseEquatable {}

class EventDetailsInitialEvent extends EventDetailsEvent {
  EventDetailsInitialEvent(this.caseId, this.userType);
  final String caseId;
  final String userType;
}
