import 'dart:convert';

import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:ably_flutter/ably_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/message_screen/chat_screen_bloc.dart';
import 'package:origa/screen/message_screen/chat_screen_event.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';
import 'chat_model/message_model.dart';
import 'chat_screen_state.dart';

class ChatScreen extends StatefulWidget {
  final String? fromARefId;
  final String? toARefId;
  final ImageProvider<Object>? agentImage;
  const ChatScreen({Key? key, this.fromARefId, this.toARefId, this.agentImage})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatScreenBloc bloc;

  late ably.Realtime realtimeInstance;
  late ably.RealtimeChannel chatChannel;
  late ably.RealtimeChannel receiptChannel;
  var messageController = TextEditingController();

  // var myRandomClientId = '';
  List<Messages> messages = [];
  String? clientIDFromARef;
  String? toARef;
  // String? clientIDFromARef = "HAR_fos1";
  // String? toARef = "har_superadmin";
  ably.RealtimeChannel? presenceChannel;
  ably.RealtimeChannel? leaveChannel;

  late final ClientOptions clientOptions;

  @override
  void initState() {
    bloc = ChatScreenBloc()..add(ChatInitialEvent(toAref: widget.toARefId!));
    clientIDFromARef = widget.fromARefId;
    toARef = widget.toARefId;
    createAblyRealtimeInstance();
    super.initState();
    // bloc = ChatScreenBloc()..add(ChatInitialEvent());
  }

  @override
  void dispose() {
    messageController.dispose();
    leaveChannelPresence();
    super.dispose();
  }

  List<ChatHistory> messageHistory = [];

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
              return const CustomLoadingWidget();
            }

          }),
    );*/
    return BlocListener<ChatScreenBloc, ChatScreenState>(
      bloc: bloc,
      listener: (context, state) {},
      child: BlocBuilder<ChatScreenBloc, ChatScreenState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ChatScreenInitial) {
            return const CustomLoadingWidget();
          }
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
                            title:
                                Languages.of(context)!.message.toUpperCase()),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 7),
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
                                    child:
                                        SvgPicture.asset(ImageResource.profile),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                        bloc.agentDetails.result?[0].name ??
                                            '-',
                                        fontWeight: FontWeight.w400,
                                        fontSize: FontSize.sixteen,
                                        fontStyle: FontStyle.normal,
                                        color: ColorResource.color101010,
                                      ),
                                      CustomText(
                                        bloc.agentDetails.result?[0].type ??
                                            '-',
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
                          child: messageHistory.isNotEmpty
                              ? ListView.builder(
                                  reverse: true,
                                  padding: const EdgeInsets.only(top: 15.0),
                                  itemCount: messageHistory.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final ChatHistory message =
                                        messageHistory[index];
                                    // final bool isMe = message.sender!.id == currentUser.id;
                                    // message.name == clientIDFromARef;
                                    return _buildMessage(
                                        message,
                                        message.name != clientIDFromARef
                                            ? true
                                            : false);
                                  },
                                )
                              : Center(
                                  child: CustomText(
                                    Constants.statrtConverstation,
                                    color: Colors.grey.shade300,
                                    fontSize: FontSize.fifteen,
                                    fontWeight: FontWeight.w500,
                                  ),
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
        },
      ),
    );
  }

  void gettingAPIKeyFromServer() {}

  void createAblyRealtimeInstance() async {
    //isi6Mw.OkTsUw:L1PnG2F-SEVG0Jc7bNnlj4Z_y8pX9IaIIeRTF0fPD1Q
    clientOptions = ably.ClientOptions()
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

      presenceChannel = realtimeInstance.channels.get('chat:mobile:presence');
      await presenceChannel!.presence.enterClient(clientIDFromARef!, 'enter');
      debugPrint('presenceChannel->${presenceChannel!.state.toString()}');
      //When click the submit button
      //Who are all in online
      presenceChannel!.presence
          .subscribe(action: PresenceAction.enter)
          .listen((ably.PresenceMessage event) async {
        debugPrint('Who are all in online--> ${event.clientId}');
        debugPrint('New message arrived ${event.data}');
        if (toARef == event.clientId) {
          //Post messages
          // await chatChannel.publish(messages: [
          //   ably.Message(name: clientIDFromARef, data: 'Sai'),
          // ]).then((value) {
          //   debugPrint('Success state-->');
          // }).catchError((error) {
          //   debugPrint('Error state--> ${error.toString()}');
          // });
        } else {
          // Have to integrate with FCM after that message
        }
      });

      chatChannel.subscribe(name: clientIDFromARef).listen((event) {
        debugPrint('New Message arrived from $clientIDFromARef ${event.data}');

        // if (event.data is String) {
        //   debugPrint("event data is String");
        //   messageHistory.insert(
        //     0,
        //     ChatHistory(
        //         data: event.data.toString(),
        //         name: event.name,
        //         dateTime: event.timestamp),
        //   );
        // }
        setState(() {
          ReceivingData receivedData =
              ReceivingData.fromJson(jsonDecode(jsonEncode(event.data)));
          messageHistory.insert(
            0,
            ChatHistory(
                data: receivedData.message,
                name: event.name,
                dateTime: event.timestamp),
          );
        });
      }).onData((data) {
        debugPrint('New daTA arrived from $clientIDFromARef ${data.data}');

        setState(() {
          ReceivingData receivedData =
              ReceivingData.fromJson(jsonDecode(jsonEncode(data.data)));
          debugPrint(receivedData.dateSent);
          debugPrint("received data2 value ==> ${receivedData.message}");
          messageHistory.insert(
            0,
            ChatHistory(
                data: receivedData.message,
                name: data.name,
                dateTime: data.timestamp),
          );
        });
      });

      //to getting the history of data
      var result = await chatChannel.history(
          ably.RealtimeHistoryParams(direction: 'forwards', limit: 10));
      debugPrint('The data of history--> ${result.items}');

      setState(() {
        result.items.forEach((element) {
          if (element.data is String) {
            print("is String====>");
            messageHistory.insert(
              0,
              ChatHistory(
                  data: element.data,
                  name: element.name,
                  dateTime: element.timestamp),
            );
          } else {
            print("is ObjectData====>");
            ReceivingData receivedData =
                ReceivingData.fromJson(jsonDecode(jsonEncode(element.data)));
            messageHistory.insert(
              0,
              ChatHistory(
                  data: receivedData.message,
                  name: element.name,
                  dateTime: element.timestamp),
            );
          }
        });
      });
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  void sendMessage({String? messageContent}) async {
    print("send message clicked");
    chatChannel.publish(messages: [
      ably.Message(name: toARef, data: messageContent),
    ]).then((value) {
      debugPrint('Success state-->111');
      setState(() {
        messageHistory.insert(
          0,
          ChatHistory(
              data: messageContent, name: toARef, dateTime: DateTime.now()),
        );
      });
      messageController.clear();
    }).catchError((error) {
      debugPrint('Error state--> ${error.toString()}');
      messageController.clear();
    });
    // try {
    //   realtimeInstance = ably.Realtime(options: clientOptions);
    //   chatChannel = realtimeInstance.channels
    //       .get('chat:mobile:messages:$clientIDFromARef-$toARef');

    //   presenceChannel = realtimeInstance.channels.get('chat:mobile:presence');
    //   await presenceChannel!.presence.enterClient(clientIDFromARef!, 'enter');
    //   debugPrint('presenceChannel->${presenceChannel!.state.toString()}');
    //   presenceChannel!.presence
    //       .subscribe(action: PresenceAction.enter)
    //       .listen((ably.PresenceMessage event) async {
    //     debugPrint('Who are all in online--> ${event.clientId}');
    //     debugPrint('New message arrived ${event.data}');
    //     if (toARef == event.clientId) {
    //       print("message sending progress---->");
    //       chatChannel.publish(messages: [
    //         ably.Message(name: toARef, data: messageContent),
    //       ]).then((value) {
    //         debugPrint('Success state-->111');
    //         setState(() {
    //           messageHistory.insert(
    //             0,
    //             ChatHistory(
    //                 data: messageContent,
    //                 name: toARef,
    //                 dateTime: DateTime.now()),
    //           );
    //         });
    //         messageController.clear();
    //       }).catchError((error) {
    //         debugPrint('Error state--> ${error.toString()}');
    //         messageController.clear();
    //       });
    //     } else {
    //       print("Message publish with notification ---->${event.data}");
    //       chatChannel.publish(messages: [
    //         ably.Message(
    //           name: toARef,
    //           data: messageContent,
    //           // extras: ably.MessageExtras({
    //           //   'push': {
    //           //     'notification': {
    //           //       'title': clientIDFromARef,
    //           //       'body': messageContent,
    //           //       'sound': 'default',
    //           //     },
    //           //   },
    //           // })
    //         )
    //       ]).then((value) {
    //         debugPrint('Success state-->fem');
    //         setState(() {
    //           messageHistory.insert(
    //             0,
    //             ChatHistory(
    //                 data: messageContent,
    //                 name: toARef,
    //                 dateTime: DateTime.now()),
    //           );
    //         });
    //         messageController.clear();
    //       }).catchError((error) {
    //         debugPrint('Error state fcm --> ${error.toString()}');
    //         messageController.clear();
    //       });
    //       messageController.clear();
    //       // Have to integrate with FCM after that message
    //     }
    //   });
    // } catch (error) {
    //   debugPrint(error.toString());
    //   rethrow;
    // }
  }

  void leavePresence() async {
    await chatChannel.presence.leave();
  }

  _buildMessage(ChatHistory message, bool isMe) {
    final Container msg = Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 2, bottom: 10),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMe
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    child: SvgPicture.asset(ImageResource.profile),
                    width: 22,
                    height: 23,
                    decoration: BoxDecoration(
                      color: ColorResource.color23375A,
                      borderRadius: BorderRadius.circular(52.5),
                    ),
                  )),
          SizedBox(
            width: 250,
            child: Align(
              alignment: (isMe ? Alignment.topRight : Alignment.topLeft),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                        const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                    child: CustomText(
                      message.data.toString(),
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.fourteen,
                      fontStyle: FontStyle.normal,
                      color: ColorResource.color484848,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  CustomText(
                    // DateFormat('yyyy-MM-dd').format(message.dateTime!),
                    DateFormat.MMMd().format(message.dateTime!) +
                        " / " +
                        DateFormat.jm().format(message.dateTime!),
                    fontWeight: FontWeight.w400,
                    fontSize: FontSize.eight,
                    fontStyle: FontStyle.normal,
                    color: ColorResource.color484848,
                  ),
                ],
              ),
            ),
          ),
          isMe
              ? Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Container(
                    child: widget.agentImage != null
                        ? CircleAvatar(
                            radius: 10, backgroundImage: widget.agentImage)
                        : SvgPicture.asset(ImageResource.profile),
                    width: 23,
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
                  messageController,
                  isBorder: true,
                  borderColor: ColorResource.colorDADADA,
                  keyBoardType: TextInputType.multiline,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 7.0),
                  // inputformaters: [
                  //   BlacklistingTextInputFormatter(RegExp(r"\s\b|\b\s"))
                  // ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: GestureDetector(
                    onTap: () {
                      if (messageController.text.trim().isNotEmpty) {
                        sendMessage(messageContent: messageController.text);
                      } else {
                        debugPrint("space removed");
                      }
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
                            lineHeight: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
