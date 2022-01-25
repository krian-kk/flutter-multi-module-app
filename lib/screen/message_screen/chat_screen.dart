import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:ably_flutter/ably_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/message_model.dart';
import 'package:origa/screen/message_screen/chat_screen_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';

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

  List<ChatHistory> messageHistory = [
    ChatHistory(data: "Is there any thing wrong?", name: "HAR_fos3"),
    ChatHistory(data: "ehhhh, doing OK.", name: "HAR_tl3"),
    ChatHistory(
        data: "Hey Kriss, I am doing fine dude. wbu?", name: "HAR_fos3"),
    ChatHistory(data: "How have you been?", name: "HAR_tl3"),
    ChatHistory(data: "Hello, Dude", name: "HAR_tl3"),
  ];

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResource.colorffffff,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 13,
                  ),
                  BottomSheetAppbar(
                      title: Languages.of(context)!.message.toUpperCase()),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: ColorResource.colorF7F8FA,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              child: SvgPicture.asset(ImageResource.profile),
                              width: 38,
                              height: 40,
                              decoration: BoxDecoration(
                                color: ColorResource.color23375A,
                                borderRadius: BorderRadius.circular(52.5),
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                CustomText(
                                  'Mr. Debashish',
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.sixteen,
                                  fontStyle: FontStyle.normal,
                                  color: ColorResource.color101010,
                                ),
                                CustomText(
                                  'Sr. Manager',
                                  fontWeight: FontWeight.w700,
                                  fontSize: FontSize.fourteen,
                                  fontStyle: FontStyle.normal,
                                  color: ColorResource.color333333,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.only(top: 15.0),
                      itemCount: messageHistory.length,
                      itemBuilder: (BuildContext context, int index) {
                        final ChatHistory message = messageHistory[index];
                        // final bool isMe = message.sender!.id == currentUser.id;
                        // message.name == clientIDFromARef;
                        return _buildMessage(message,
                            message.name == clientIDFromARef ? true : false);
                      },
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
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

  _buildMessage(ChatHistory message, bool isMe) {
    final Container msg = Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 10),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMe
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Container(
                    child: SvgPicture.asset(ImageResource.profile),
                    width: 22,
                    height: 23,
                    decoration: BoxDecoration(
                      color: ColorResource.color23375A,
                      borderRadius: BorderRadius.circular(52.5),
                    ),
                  )),
          Align(
            alignment: (isMe ? Alignment.topRight : Alignment.topLeft),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isMe
                        ? ColorResource.colorFFDBD0
                        : ColorResource.colorF8F9FB,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  child: CustomText(
                    message.data,
                    fontWeight: FontWeight.w400,
                    fontSize: FontSize.fourteen,
                    fontStyle: FontStyle.normal,
                    color: ColorResource.color484848,
                  ),
                ),
                // CustomText(
                //   message.deliveredOn!,
                //   fontWeight: FontWeight.w400,
                //   fontSize: FontSize.ten,
                //   fontStyle: FontStyle.normal,
                //   color: ColorResource.color484848,
                // ),
              ],
            ),
          ),
          isMe
              ? Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Container(
                    child: SvgPicture.asset(ImageResource.profile),
                    width: 22,
                    height: 23,
                    decoration: BoxDecoration(
                      color: ColorResource.color23375A,
                      borderRadius: BorderRadius.circular(52.5),
                    ),
                  ))
              : const SizedBox(),
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
            color: ColorResource.colorffffff,
            border:
                Border(top: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.13)))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomTextField(
                  Languages.of(context)!.typeYourMessage,
                  myInputController,
                  isBorder: true,
                  borderColor: ColorResource.colorDADADA,
                  keyBoardType: TextInputType.multiline,
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    // createAblyRealtimeInstance();
                    setState(() {
                      messageHistory.add(
                          ChatHistory(data: "Hello, Dude", name: "HAR_tl3"));
                    });
                    myInputController.clear();
                  },
                  child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorResource.colorEA6D48,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Center(
                        child: CustomText(
                          Languages.of(context)!.send.toUpperCase(),
                          fontSize: FontSize.sixteen,
                          color: ColorResource.colorffffff,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
