import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:ably_flutter/ably_flutter.dart';
import 'package:flutter/material.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/screen/message_screen/chat_screen_bloc.dart';

import 'chat_model/message_model.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatScreenBloc bloc;

  late ably.Realtime realtimeInstance;
  var newMsgFromAbly;
  late ably.RealtimeChannel chatChannel;
  late ably.RealtimeChannel receiptChannel;
  var myInputController = TextEditingController();

  // var myRandomClientId = '';
  List<Messages> messages = [];
  String? clientIDFromARef = "HAR_fos3";
  String? toARef = "HAR_tl3";
  ably.RealtimeChannel? presenceChannel;
  ably.RealtimeChannel? leaveChannel;

  @override
  void initState() {
    createAblyRealtimeInstance();
    super.initState();
    // bloc = ChatScreenBloc()..add(ChatInitialEvent());
  }

  @override
  void dispose() {
    myInputController.dispose();
    leaveChannelPresence();
    super.dispose();
  }

  Future<void> leaveChannelPresence() async {
    presenceChannel = realtimeInstance.channels.get('chat:mobile:presence');
    await presenceChannel!.presence
        .enterClient(clientIDFromARef!, PresenceAction.leave);
    debugPrint('presenceChannel->${presenceChannel!.state.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    // bloc = BlocProvidChatScreenBloc>(context)..add(ChatInitialEvent());

    /*return BlocListener(
      listener: (context, state) {},
      bloc: BlocProvider.of<ChatScreenBloc>(context),
      child: BlocBuilder(
          bloc: BlocProvider.of<ChatScreenBloc>(context),
          builder: (context, state) {
            if (state is InitialState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

          }),
    );*/
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
              onPressed: () {}),
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

  void gettingAPIKeyFromServer() {}

  void createAblyRealtimeInstance() async {
    //isi6Mw.OkTsUw:L1PnG2F-SEVG0Jc7bNnlj4Z_y8pX9IaIIeRTF0fPD1Q
    final clientOptions = ably.ClientOptions()
      ..clientId = clientIDFromARef
      ..authCallback = (ably.TokenParams tokenParams) async {
        try {
          final Map<String, dynamic> tokenRequestMap =
              await APIRepository.apiRequest(
                  APIRequestType.GET, HttpUrl.chatTokenRequest);
          debugPrint(
              'Chat token request data ===> ${tokenRequestMap['data']['result']}');
          setState(() {
            // clientIDFromARef = tokenRequestMap['data']['result']['clientId'];
          });
          return ably.TokenRequest.fromMap(tokenRequestMap['data']['result']);
        } catch (e) {
          debugPrint('Failed to createTokenRequest: $e');
          rethrow;
        }
      };
    try {
      realtimeInstance = ably.Realtime(options: clientOptions);
      chatChannel = realtimeInstance.channels
          .get('chat:mobile:messages:$clientIDFromARef-$toARef');

      realtimeInstance.connection
          .on(ably.ConnectionEvent.connected)
          .listen((ably.ConnectionStateChange stateChange) async {
        presenceChannel = realtimeInstance.channels.get('chat:mobile:presence');
        await presenceChannel!.presence.enterClient(clientIDFromARef!, 'enter');
        debugPrint('presenceChannel->${presenceChannel!.state.toString()}');

        //When click the submit button
        //Who are all in online
        presenceChannel!.presence
            .subscribe(action: PresenceAction.enter)
            .listen((ably.PresenceMessage event) async {
          debugPrint('Who are all in online--> ${event.clientId}');

          if (toARef == event.clientId) {
            //Post messages
            await chatChannel.publish(messages: [
              ably.Message(name: clientIDFromARef, data: 'Sai'),
            ]).then((value) {
              debugPrint('Success state-->');
            }).catchError((error) {
              debugPrint('Error state--> ${error.toString()}');
            });
          } else {
            // Have to integrate with FCM after that message
          }
        });

        await chatChannel.publish(messages: [
          ably.Message(name: clientIDFromARef, data: 'Sai'),
        ]).then((value) {
          debugPrint('Success state-->');
        }).catchError((error) {
          debugPrint('Error state--> ${error.toString()}');
        });

        //subscribe - For receiving the message from ably
        var messageStream = chatChannel.subscribe();
        messageStream.listen((ably.Message message) {
          debugPrint('New message arrived ${message.data}');
        });
        //to getting the history of data
        var result = await chatChannel.history(
            ably.RealtimeHistoryParams(direction: 'forwards', limit: 10));
        debugPrint('The data of history--> ${result.items}');
      });
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  void leavePresence() async {
    await chatChannel.presence.leave();
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
