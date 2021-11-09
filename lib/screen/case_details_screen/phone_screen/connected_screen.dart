// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/bottom_sheet_screen/capture_image_bottom_sheet.dart';
import 'package:origa/screen/case_details_screen/bottom_sheet_screen/collections_bottom_sheet.dart';
import 'package:origa/screen/case_details_screen/bottom_sheet_screen/dispute_bottom_sheet.dart';
import 'package:origa/screen/case_details_screen/bottom_sheet_screen/other_feed_back_bottom_sheet.dart';
import 'package:origa/screen/case_details_screen/bottom_sheet_screen/ots_bottom_sheet.dart';
import 'package:origa/screen/case_details_screen/bottom_sheet_screen/ptp_bottom_sheet.dart';
import 'package:origa/screen/case_details_screen/bottom_sheet_screen/remainder_bottom_sheet.dart';
import 'package:origa/screen/case_details_screen/bottom_sheet_screen/repo_bottom_sheet.dart';
import 'package:origa/screen/case_details_screen/bottom_sheet_screen/rtp_bottom_sheet.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class PhoneConnectedScreen extends StatefulWidget {
  const PhoneConnectedScreen({
    Key? key,
    required this.bloc,
    required this.context,
  }) : super(key: key);

  final CaseDetailsBloc bloc;
  final BuildContext context;

  @override
  State<PhoneConnectedScreen> createState() => _PhoneConnectedScreenState();
}

class _PhoneConnectedScreenState extends State<PhoneConnectedScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 20, 14, 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.builder(
                    itemCount: widget.bloc.phoneCustomerMetGridList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int innerIndex) {
                      return Padding(
                        padding: const EdgeInsets.all(4.5),
                        child: GestureDetector(
                          onTap: () {
                            switch (widget.bloc
                                .addressCustomerMetGridList[innerIndex].title) {
                              case StringResource.ptp:
                                openBottomSheet(
                                  context,
                                  StringResource.ptp,
                                );
                                break;
                              case StringResource.rtp:
                                openBottomSheet(context, StringResource.rtp);
                                break;
                              case StringResource.dispute:
                                openBottomSheet(
                                    context, StringResource.dispute);
                                break;
                              case StringResource.remainder:
                                openBottomSheet(
                                    context, StringResource.remainder);
                                break;
                              case StringResource.collections:
                                openBottomSheet(
                                    context, StringResource.collections);
                                break;
                              case StringResource.ots:
                                openBottomSheet(context, StringResource.ots);
                                break;
                              default:
                            }
                          },
                          child: Container(
                            decoration: new BoxDecoration(
                                color: ColorResource.colorF8F9FB,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorResource.color000000
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    offset: Offset(1.0,
                                        1.0), // shadow direction: bottom right
                                  )
                                ],
                                borderRadius: new BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Image.asset(widget.bloc
                                    .phoneCustomerMetGridList[innerIndex].icon),
                                SizedBox(height: 8),
                                CustomText(
                                  widget
                                      .bloc
                                      .phoneCustomerMetGridList[innerIndex]
                                      .title,
                                  color: ColorResource.color000000,
                                  fontSize: FontSize.twelve,
                                  fontWeight: FontWeight.w700,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomButton(
                          StringResource.addNewContact.toUpperCase(),
                          // onTap: () => openBottomSheet(
                          //     context, StringResource.addNewContact),
                          textColor: ColorResource.colorFFFFFF,
                          borderColor: ColorResource.color23375A,
                          cardShape: 75,
                          buttonBackgroundColor: ColorResource.color23375A,
                        ),
                      ),
                      SizedBox(height: 11),
                      Expanded(
                        child: CustomButton(
                          Languages.of(context)!.otherFeedBack,
                          onTap: () => openBottomSheet(
                              context, StringResource.otherFeedback),
                          textColor: ColorResource.color23375A,
                          borderColor: ColorResource.color23375A,
                          cardShape: 75,
                          buttonBackgroundColor: ColorResource.colorFFFFFF,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  openBottomSheet(BuildContext buildContext, String cardTitle) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: buildContext,
      backgroundColor: ColorResource.colorFFFFFF,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        switch (cardTitle) {
          case StringResource.ptp:
            return CustomPtpBottomSheet(Languages.of(context)!.ptp);
          case StringResource.rtp:
            return CustomRtpBottomSheet(Languages.of(context)!.rtp);
          case StringResource.dispute:
            return CustomDisputeBottomSheet(Languages.of(context)!.dispute);
          case StringResource.remainder:
            return CustomRemainderBottomSheet(
                Languages.of(context)!.remainderCb);
          case StringResource.collections:
            return CustomCollectionsBottomSheet(
                Languages.of(context)!.collections);
          case StringResource.ots:
            return CustomOtsBottomSheet(Languages.of(context)!.ots);
          case StringResource.repo:
            return CustomRepoBottomSheet(Languages.of(context)!.repo);
          case StringResource.captureImage:
            return CustomCaptureImageBottomSheet(
                Languages.of(context)!.captureImage);
          case StringResource.otherFeedback:
            return CustomOtherFeedBackBottomSheet(
                Languages.of(context)!.otherFeedBack, widget.bloc);
          default:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}
