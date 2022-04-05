import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/profile_screen.dart/bloc/profile_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.87,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  BottomSheetAppbar(
                    title: Languages.of(context)!.notification.toUpperCase(),
                    color: ColorResource.color23375A,
                    padding: const EdgeInsets.all(0),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 15),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: bloc.notificationList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10.0),
                                    child: CustomText(
                                      bloc.notificationList[index].date,
                                      color: ColorResource.color484848,
                                      fontSize: FontSize.ten,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: bloc.notificationList[index]
                                          .listOfNotification.length,
                                      itemBuilder: (BuildContext context,
                                          int innerIndex) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 20),
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                              color: ColorResource.colorF7F8FA,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                14, 8, 30, 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomText(
                                                  bloc
                                                      .notificationList[index]
                                                      .listOfNotification[
                                                          innerIndex]
                                                      .headText
                                                      .toString(),
                                                  color:
                                                      ColorResource.color101010,
                                                  fontSize: FontSize.sixteen,
                                                ),
                                                CustomText(
                                                  bloc
                                                      .notificationList[index]
                                                      .listOfNotification[
                                                          innerIndex]
                                                      .subText
                                                      .toString(),
                                                  color:
                                                      ColorResource.color484848,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              );
                            },
                          ),
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
            decoration: BoxDecoration(
              color: ColorResource.colorFFFFFF,
              boxShadow: [
                BoxShadow(
                  color: ColorResource.color000000.withOpacity(0.2),
                  blurRadius: 2.0,
                  offset: const Offset(1.0, 1.0),
                )
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 11.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 190,
                    child: CustomButton(
                      Languages.of(context)!.read.toUpperCase(),
                      onTap: () => Navigator.pop(context),
                      fontSize: FontSize.sixteen,
                      cardShape: 5,
                      leadingWidget: const CircleAvatar(
                        radius: 13,
                        backgroundColor: ColorResource.colorFFFFFF,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
