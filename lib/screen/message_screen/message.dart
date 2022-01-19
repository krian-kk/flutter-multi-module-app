import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/message_model.dart';
import 'package:origa/screen/profile_screen.dart/bloc/profile_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';

class MessageChatRoomScreen extends StatefulWidget {
  final ProfileBloc bloc;
  const MessageChatRoomScreen(this.bloc, {Key? key}) : super(key: key);

  @override
  _MessageChatRoomScreenState createState() => _MessageChatRoomScreenState();
}

class _MessageChatRoomScreenState extends State<MessageChatRoomScreen> {
  late TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  List<ChatMessage> messages = [
    ChatMessage(
        messageContent: "Hello, Dude",
        dateTime: "Sep 20 7:04 PM",
        messageType: "receiver"),
    ChatMessage(
        messageContent: "How have you been?",
        dateTime: "Sep 20 7:04 PM",
        messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        dateTime: "Sep 20 7:04 PM",
        messageType: "sender"),
    ChatMessage(
        messageContent: "ehhhh, doing OK.",
        dateTime: "Sep 20 7:04 PM",
        messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?",
        dateTime: "Sep 20 7:04 PM",
        messageType: "sender"),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: widget.bloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: widget.bloc,
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorResource.colorffffff,
              body: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 13,
                      ),
                      BottomSheetAppbar(
                          title: Languages.of(context)!.message.toUpperCase()),
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
                          itemCount: messages.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 8, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    messages[index].messageType == "receiver"
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (messages[index].messageType == "receiver")
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: Container(
                                          child: SvgPicture.asset(
                                              ImageResource.profile),
                                          width: 22,
                                          height: 23,
                                          decoration: BoxDecoration(
                                            color: ColorResource.color23375A,
                                            borderRadius:
                                                BorderRadius.circular(52.5),
                                          ),
                                        )),
                                  Align(
                                    alignment: (messages[index].messageType ==
                                            "receiver"
                                        ? Alignment.topLeft
                                        : Alignment.topRight),
                                    child: Column(
                                      crossAxisAlignment:
                                          messages[index].messageType ==
                                                  "receiver"
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (messages[index]
                                                        .messageType ==
                                                    "receiver"
                                                ? ColorResource.colorF8F9FB
                                                : ColorResource.colorFFDBD0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 15),
                                          child: CustomText(
                                            messages[index].messageContent,
                                            fontWeight: FontWeight.w400,
                                            fontSize: FontSize.fourteen,
                                            fontStyle: FontStyle.normal,
                                            color: ColorResource.color484848,
                                          ),
                                        ),
                                        CustomText(
                                          messages[index].dateTime,
                                          fontWeight: FontWeight.w400,
                                          fontSize: FontSize.ten,
                                          fontStyle: FontStyle.normal,
                                          color: ColorResource.color484848,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (messages[index].messageType != "receiver")
                                    Padding(
                                        padding: const EdgeInsets.only(left: 7),
                                        child: Container(
                                          child: SvgPicture.asset(
                                              ImageResource.profile),
                                          width: 22,
                                          height: 23,
                                          decoration: BoxDecoration(
                                            color: ColorResource.color23375A,
                                            borderRadius:
                                                BorderRadius.circular(52.5),
                                          ),
                                        )),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      decoration: const BoxDecoration(
                          color: ColorResource.colorffffff,
                          border: Border(
                              top: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.13)))),
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
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  messageController.clear();
                                },
                                child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: ColorResource.colorEA6D48,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Center(
                                      child: CustomText(
                                        Languages.of(context)!
                                            .send
                                            .toUpperCase(),
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
