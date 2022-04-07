import 'package:origa/utils/base_equatable.dart';

class ChatScreenEvent extends BaseEquatable {}

class ChatInitialEvent extends ChatScreenEvent {
  ChatInitialEvent({this.toAref});
  final String? toAref;
}
