import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:intl/intl.dart';
import 'chat_model/message_model.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ably.Realtime realtimeInstance;
  var newMsgFromAbly;
  late ably.RealtimeChannel chatChannel;
  late ably.RealtimeChannel receiptChannel;
  var myInputController = TextEditingController();
  // var myRandomClientId = '';

  List<Messages> messages = [];
  String? clientIDFromARef = "HAR_fos1";
  String? toARef = "isi6Mw.OkTsUw";

  @override
  void initState() {
    super.initState();
    createAblyRealtimeInstance();
  }

  @override
  void dispose() {
    myInputController.dispose();
    super.dispose();
  }

  void createAblyRealtimeInstance() async {
    // Used to create a clientId when a client first doesn't have one.
// Note: you should implement `createTokenRequest`, which makes a request to your server that uses your Ably API key directly.
    final clientOptions = ably.ClientOptions()
      // If a clientId was set in ClientOptions, it will be available in the authCallback's first parameter (ably.TokenParams).
      ..clientId = clientIDFromARef
      ..authCallback = (ably.TokenParams tokenParams) async {
        try {
          final Map<String, dynamic> tokenRequestMap =
              await createTokenRequest();
          print(
              "Chat token request data ===> ${tokenRequestMap['data']['result']}");
          setState(() {
            clientIDFromARef = tokenRequestMap['data']['result']['clientId'];
          });
          return ably.TokenRequest.fromMap(tokenRequestMap['data']['result']);
        } catch (e) {
          print('Failed to createTokenRequest: $e');
          rethrow;
        }
      };

    try {
      realtimeInstance = ably.Realtime(options: clientOptions);
      print('Ably instantiated');
      //
      chatChannel = realtimeInstance.channels
          .get('chat:mobile:messages:$clientIDFromARef-$toARef');
      receiptChannel = realtimeInstance.channels
          .get('chat:mobile:receipt:$clientIDFromARef-$toARef');
      //
      subscribeToChatChannel();
      realtimeInstance.connection
          .on(ably.ConnectionEvent.connected)
          .listen((ably.ConnectionStateChange stateChange) async {
        print('Realtime connection state changed: ${stateChange.event}');
      });
    } catch (error) {
      print('Error creating Ably Realtime Instance: $error');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createTokenRequest() async {
    Map<String, dynamic> postResult = await APIRepository.apiRequest(
        APIRequestType.GET, HttpUrl.chatTokenRequest);
    // print("Chat token request Response data ===> ${postResult}");
    return postResult;
  }

// 'chat:mobile:messages:$clientIDFromARef-$toARef',
//       'chat:mobile:receipt:$clientIDFromARef-$toARef'
  void subscribeToChatChannel() {
    var messageStream = chatChannel.subscribe();
    var receiptStream = receiptChannel.subscribe();

    messageStream.listen((ably.Message message) {
      Messages newChatMsg;
      newMsgFromAbly = message.data;
      print("New message arrived messageStream ${message.data}");
      print(message.clientId);
      print(message.name);
      print(message.id);
      print(message.connectionId);

      newChatMsg = Messages(
        messageIds: message.id,
        deliveredOn: newMsgFromAbly['messageIds'],
        seenOn: message.timestamp.toString(),
        delivered: false,
        seen: false,
      );

      setState(() {
        messages.insert(0, newChatMsg);
      });
    });

    // receiptStream.listen((ably.Message message) {
    //   Messages newChatMsg;
    //   newMsgFromAbly = message.data;
    //   print("New message arrived receiptStream ${message.data}");
    //   print(message.clientId);
    //   print(message.name);
    //   print(message.id);
    //   print(message.connectionId);

    //   newChatMsg = Messages(
    //     messageIds: '000',
    //     deliveredOn: '000',
    //     seenOn: '123',
    //     delivered: false,
    //     seen: false,
    //   );

    //   setState(() {
    //     messages.insert(0, newChatMsg);
    //   });
    // });
    enterPresence();
  }

  void enterPresence() async {
    print("presence entered===>");
    await chatChannel.presence.enter();
  }

  void leavePresence() async {
    await chatChannel.presence.leave();
  }

  void publishMyMessage() async {
    print("publish message here--->");
    realtimeInstance.channels
        .get('chat:mobile:receipt:$clientIDFromARef-$toARef');

    var myMessage = myInputController.text;

    await chatChannel.publish(
        // message: ably.Message(),
        name: "${realtimeInstance.options.clientId}",
        data:
            // {
            //   "sender": "${realtimeInstance.options.clientId}",
            //   "text": myMessage,
            // }
            {
          'messageIds': [myMessage],
          'delivered': true,
          'deliveredOn': '6:25 PM',
          'seen': true,
          'seenOn': '6:25 PM'
        });
    myInputController.clear();
  }

  _buildMessage(Messages message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
        borderRadius: isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.deliveredOn!,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            message.deliveredOn!,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: myInputController,
              onChanged: (value) {},
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              publishMyMessage();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          'Ably Chat',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.more_horiz),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {
                print("current time");
                print(TimeOfDay.now().format(context).toString());
                print("current Date");
                print(DateFormat('dd/MM/yyyy').format(DateTime.now()));
              }),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.only(top: 15.0),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Messages message = messages[index];
                      // final bool isMe = message.sender!.id == currentUser.id;
                      return _buildMessage(message, false);
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
