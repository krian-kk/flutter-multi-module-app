import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/message_screen/chat_screen.dart';
import 'package:origa/screen/my_deposists/my_deposists.dart';
import 'package:origa/screen/my_recipts/my_receipts.dart';
import 'package:origa/screen/my_visit/my_visits.dart';
import 'package:origa/utils/color_resource.dart';

class OnclickNotificationNavigateScreen {
  messageScreenBottomSheet(BuildContext? context,
      {String? fromID, String? toID}) {
    showModalBottomSheet(
      context: context!,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: ColorResource.colorFFFFFF,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext buildContext, StateSetter setState) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.86,
          child: ChatScreen(
              fromARefId: fromID!, toARefId: toID!, agentImage: null),
        ),
      ),
    );
    // MessageChatRoomScreen(bloc)
  }

  void myVisitsSheet(BuildContext buildContext, DashboardBloc dashboardbloc) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              bottom: false, child: MyVisitsBottomSheet(dashboardbloc));
        });
  }

  void myDeposistsSheet(
      BuildContext buildContext, DashboardBloc dashboardbloc) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              bottom: false, child: MyDeposistsBottomSheet(dashboardbloc));
        });
  }

  void myReceiptsSheet(BuildContext buildContext, DashboardBloc dashboardbloc) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              bottom: false, child: MyReceiptsBottomSheet(dashboardbloc));
        });
  }
}
