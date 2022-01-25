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
  String name;
  String data;
  ChatHistory({
    required this.name,
    required this.data,
  });
}


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
