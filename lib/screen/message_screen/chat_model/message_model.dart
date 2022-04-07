// class Messages {
//   final String? messageIds;
//   final String? deliveredOn;
//   final String? seenOn;
//   final bool? delivered;
//   final bool? seen;

//   Messages({
//     this.messageIds,
//     this.deliveredOn,
//     this.seenOn,
//     this.delivered,
//     this.seen,
//   });
// }

class ChatHistory {
  ChatHistory({
    this.name,
    this.data,
    this.dateTime,
    this.fromID,
    this.toID,
  });
  String? name;
  dynamic data;
  DateTime? dateTime;
  String? fromID;
  String? toID;
}

class ReceivingData {
  ReceivingData(
      {this.dateSent, this.message, this.toId, this.type, this.fromId});

  ReceivingData.fromJson(Map<String, dynamic> json) {
    dateSent = json['dateSent'];
    message = json['message'];
    toId = json['toId'];
    type = json['type'];
    fromId = json['fromId'];
  }
  String? dateSent;
  String? message;
  String? toId;
  dynamic type;
  String? fromId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateSent'] = dateSent;
    data['message'] = message;
    data['toId'] = toId;
    data['type'] = type;
    data['fromId'] = fromId;
    return data;
  }
}

// class Data {
//   String? message;
//   String? dateSend;
//   String? fromId;
//   String? toId;

//   Data({this.message, this.dateSend, this.fromId, this.toId});

//   Data.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     dateSend = json['dateSend'];
//     fromId = json['fromId'];
//     toId = json['toId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['message'] = message;
//     data['dateSend'] = dateSend;
//     data['fromId'] = fromId;
//     data['toId'] = toId;
//     return data;
//   }
// }

// // CURRENT USER
// final User currentUser = User(
//   id: 0,
//   name: 'Current User',
// );

// // OTHER USER
// final User randomChatUser = User(
//   id: 1,
//   name: 'Random Chat User',
// );

// // EXAMPLE MESSAGES IN CHAT SCREEN
// List<Message> messages = [
//   Message(
//     sender: currentUser,
//     time: '4:32 PM',
//     text: "Nothing much, just trying out Ably's new Flutter plugin",
//     unread: true,
//   ),
//   Message(
//     sender: randomChatUser,
//     time: '4:30 PM',
//     text: "Hey, how's it going?",
//     unread: true,
//   ),
// ];
