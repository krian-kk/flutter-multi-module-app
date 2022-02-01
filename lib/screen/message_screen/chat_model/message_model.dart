class Messages {
  final String? messageIds;
  final String? deliveredOn;
  final String? seenOn;
  final bool? delivered;
  final bool? seen;

  Messages({
    this.messageIds,
    this.deliveredOn,
    this.seenOn,
    this.delivered,
    this.seen,
  });
}

class ChatHistory {
  String? name;
  dynamic data;
  DateTime? dateTime;
  String? fromID;
  String? toID;
  ChatHistory({
    this.name,
    this.data,
    this.dateTime,
    this.fromID,
    this.toID,
  });
}

class ReceivingData {
  String? dateSent;
  String? message;
  String? toId;
  dynamic type;
  String? fromId;

  ReceivingData(
      {this.dateSent, this.message, this.toId, this.type, this.fromId});

  ReceivingData.fromJson(Map<String, dynamic> json) {
    dateSent = json['dateSent'];
    message = json['message'];
    toId = json['toId'];
    type = json['type'];
    fromId = json['fromId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateSent'] = this.dateSent;
    data['message'] = this.message;
    data['toId'] = this.toId;
    data['type'] = this.type;
    data['fromId'] = this.fromId;
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
