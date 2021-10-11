// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/profile_screen.dart/bloc/profile_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class NotificationBottomSheetScreen extends StatelessWidget {
  const NotificationBottomSheetScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final ProfileBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.87,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        Languages.of(context)!.notification.toUpperCase(),
                        fontSize: FontSize.fourteen,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(ImageResource.close))
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 15),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: bloc.notificationList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                        bloc.notificationList[index].date),
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: bloc.notificationList[index]
                                            .listOfNotification.length,
                                        itemBuilder: (BuildContext context,
                                            int innerIndex) {
                                          return Container(
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: double.infinity,
                                            decoration: new BoxDecoration(
                                                boxShadow: [
                                                  new BoxShadow(
                                                    color: ColorResource
                                                        .color000000
                                                        .withOpacity(.25),
                                                    blurRadius: 2.0,
                                                    offset: Offset(1.0, 1.0),
                                                  ),
                                                ],
                                                border: Border.all(
                                                    color: ColorResource
                                                        .colorDADADA,
                                                    width: 0.5),
                                                color:
                                                    ColorResource.colorF7F8FA,
                                                borderRadius:
                                                    new BorderRadius.all(
                                                        Radius.circular(10.0))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      14, 8, 30, 12),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CustomText(bloc
                                                      .notificationList[index]
                                                      .listOfNotification[
                                                          innerIndex]
                                                      .headText
                                                      .toString()),
                                                  CustomText(bloc
                                                      .notificationList[index]
                                                      .listOfNotification[
                                                          innerIndex]
                                                      .subText
                                                      .toString()),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ],
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: new BoxDecoration(
              color: ColorResource.colorFFFFFF,
              boxShadow: [
                BoxShadow(
                  color: ColorResource.color000000.withOpacity(0.2),
                  blurRadius: 2.0,
                  offset: Offset(1.0, 1.0), // shadow direction: bottom right
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 85, vertical: 11.0),
              child: Container(
                decoration: new BoxDecoration(),
                child: CustomButton(
                  Languages.of(context)!.read.toUpperCase(),
                  cardShape: 5,
                  leadingWidget: CircleAvatar(
                    radius: 13,
                    backgroundColor: ColorResource.colorFFFFFF,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
