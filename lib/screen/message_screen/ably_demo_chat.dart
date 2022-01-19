import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';

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
  var myInputController = TextEditingController();
  // var myRandomClientId = '';

  List<Message> messages = [];
  String? clientID = "HAR_fos1";
  String? toARef = "HAR_fos3";

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
      ..clientId = clientID
      ..authCallback = (ably.TokenParams tokenParams) async {
        try {
          // Send the tokenParamsMap (Map<String, dynamic>) to your server, using it to create a TokenRequest.
          print("token params ===> ${tokenParams.toMap()}");

          final Map<String, dynamic> tokenRequestMap =
              await createTokenRequest(tokenParams.toMap());
          return ably.TokenRequest.fromMap(tokenRequestMap['data']);
        } catch (e) {
          print('Failed to createTokenRequest: $e');
          rethrow;
        }
      };
    // final realtimeInstance = ably.Realtime(options: clientOptions);

    // var clientOptions = ably.ClientOptions.fromKey(
    //     "Bhx6Fw.aCUXHg:n2zxpPV1-KGRfII2lkZDzNOfTnhkVg8Aq9tVU17-X8Y");
    // clientOptions.clientId = myRandomClientId;
    try {
      realtimeInstance = ably.Realtime(options: clientOptions);
      print('Ably instantiated');
      chatChannel = realtimeInstance.channels.get('origa-demo');
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

  Future<Map<String, dynamic>> createTokenRequest(
      Map<String, dynamic> tokenParamsMap) async {
    Map<String, dynamic> postResult = await APIRepository.apiRequest(
        APIRequestType.GET, HttpUrl.chatTokenRequest);
    print("Chat token request Response data ===> ${postResult}");
    return postResult;
  }

  void subscribeToChatChannel() {
    var messageStream = chatChannel.subscribe(names: [
      'chat:mobile:messages:$clientID-$toARef',
      'chat:mobile:receipt:$clientID-$toARef'
    ]);
    messageStream.listen((ably.Message message) {
      Message newChatMsg;
      newMsgFromAbly = message.data;
      print("New message arrived ${message.data}");
      print(message.clientId);
      print(message.name);
      print(message.id);
      print(message.connectionId);

      newChatMsg = Message(
        messageIds: '',
        deliveredOn: '',
        seenOn: '',
        delivered: false,
        seen: false,
      );

      setState(() {
        messages.insert(0, newChatMsg);
      });
    });
  }

  void publishMyMessage() async {
    var myMessage = myInputController.text;
    myInputController.clear();
    chatChannel.publish(name: "chatMsg", data: {
      "sender": "randomChatUser",
      "text": myMessage,
    });
  }

  _buildMessage(Message message, bool isMe) {
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
            message.messageIds!,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            message.deliveredOn!,
            style: TextStyle(
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
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: myInputController,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
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
            onPressed: () {},
          ),
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
                      final Message message = messages[index];
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
