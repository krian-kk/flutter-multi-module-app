import 'package:origa/utils/base_equatable.dart';

class ChatScreenEvent extends BaseEquatable {}

class ChatInitialEvent extends ChatScreenEvent {
  final String? toAref;
  ChatInitialEvent({this.toAref});
}
