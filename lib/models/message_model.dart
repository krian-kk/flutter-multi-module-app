import 'package:flutter/cupertino.dart';

class ChatMessage{
  String messageContent;
  String dateTime;
  String messageType;
  ChatMessage({required this.messageContent,required this.dateTime, required this.messageType});
}