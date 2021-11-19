import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
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
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class CustomerMetScreen extends StatefulWidget {
  const CustomerMetScreen({
    Key? key,
    required this.bloc,
    required this.context,
  }) : super(key: key);

  final CaseDetailsBloc bloc;
  final BuildContext context;

  @override
  State<CustomerMetScreen> createState() => _CustomerMetScreenState();
}

class _CustomerMetScreenState extends State<CustomerMetScreen> {
  String selectedOptionBottomSheetButton = '';
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<OptionBottomSheetButtonModel> optionBottomSheetButtonList = [
      OptionBottomSheetButtonModel(
          Languages.of(context)!.addNewContact, StringResource.addNewContact),
      OptionBottomSheetButtonModel(
          Languages.of(context)!.repo, StringResource.repo),
      OptionBottomSheetButtonModel(
          Languages.of(context)!.otherFeedBack, StringResource.otherFeedback),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 20, 14, 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.builder(
                    itemCount: widget.bloc.addressCustomerMetGridList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                            decoration: BoxDecoration(
                                color: ColorResource.colorF8F9FB,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorResource.color000000
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    offset: const Offset(1.0,
                                        1.0), // shadow direction: bottom right
                                  )
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(widget
                                    .bloc
                                    .addressCustomerMetGridList[innerIndex]
                                    .icon),
                                const SizedBox(height: 8),
                                CustomText(
                                  widget
                                      .bloc
                                      .addressCustomerMetGridList[innerIndex]
                                      .title,
                                  color: ColorResource.color000000,
                                  fontSize: FontSize.twelve,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    Languages.of(context)!.captureImage.toUpperCase(),
                    cardShape: 75.0,
                    textColor: ColorResource.color23375A,
                    fontSize: FontSize.sixteen,
                    fontWeight: FontWeight.w700,
                    padding: 15.0,
                    borderColor: ColorResource.colorBEC4CF,
                    buttonBackgroundColor: ColorResource.colorBEC4CF,
                    isLeading: true,
                    onTap: () =>
                        openBottomSheet(context, StringResource.captureImage),
                    trailingWidget:
                        SvgPicture.asset(ImageResource.captureImage),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 15,
                    runSpacing: 8,
                    children: _buildOptionBottomSheetOpenButton(
                      optionBottomSheetButtonList,
                      context,
                    ),
                    // children: [
                    //   SizedBox(
                    //     width: 179,
                    //     child: CustomButton(
                    //       StringResource.addContact.toUpperCase(),
                    //       textColor: ColorResource.colorFFFFFF,
                    //       borderColor: ColorResource.color23375A,
                    //       fontSize: FontSize.twelve,
                    //       cardShape: 75,
                    //       buttonBackgroundColor: ColorResource.color23375A,
                    //     ),
                    //   ),
                    //   SizedBox(
                    //     width: 157,
                    //     child: CustomButton(
                    //       Languages.of(context)!.repo.toUpperCase(),
                    //       onTap: () =>
                    //           openBottomSheet(context, StringResource.repo),
                    //       textColor: ColorResource.color23375A,
                    //       borderColor: ColorResource.color23375A,
                    //       fontSize: FontSize.twelve,
                    //       fontWeight: FontWeight.w700,
                    //       cardShape: 75,
                    //       buttonBackgroundColor: ColorResource.colorFFFFFF,
                    //     ),
                    //   ),
                    //   SizedBox(
                    //     width: 165,
                    //     child: CustomButton(
                    //       Languages.of(context)!.otherFeedBack.toUpperCase(),
                    //       onTap: () => openBottomSheet(
                    //           context, StringResource.otherFeedback),
                    //       cardShape: 75,
                    //       fontSize: FontSize.twelve,
                    //       textColor: ColorResource.color23375A,
                    //       borderColor: ColorResource.color23375A,
                    //       buttonBackgroundColor: ColorResource.colorFFFFFF,
                    //     ),
                    //   )
                    // ],
                  ),
                  const SizedBox(height: 120)
                ],
              ),
            ),
          ),
        ),
        // Container(
        //   decoration: BoxDecoration(
        //     color: ColorResource.colorFFFFFF,
        //     boxShadow: [
        //        BoxShadow(
        //         color: ColorResource.color000000.withOpacity(.25),
        //         blurRadius: 2.0,
        //         offset: Offset(1.0, 1.0),
        //       ),
        //     ],
        //   ),
        //   width: double.infinity,
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         SizedBox(
        //           width: 191,
        //           child: CustomButton(
        //             Languages.of(context)!.done.toUpperCase(),
        //             fontSize: FontSize.sixteen,
        //             fontWeight: FontWeight.w600,
        //             // onTap: () => bloc.add(ClickMessageEvent()),
        //             cardShape: 5,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  List<Widget> _buildOptionBottomSheetOpenButton(
      List<OptionBottomSheetButtonModel> list, BuildContext context) {
    List<Widget> widgets = [];
    for (var element in list) {
      widgets.add(InkWell(
        onTap: () {
          setState(() {
            selectedOptionBottomSheetButton = element.title;
          });

          openBottomSheet(
            context,
            element.stringResourceValue,
          );
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
              color: element.title == selectedOptionBottomSheetButton
                  ? ColorResource.color23375A
                  : ColorResource.colorFFFFFF,
              border: Border.all(color: ColorResource.color23375A, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(50.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            child: CustomText(
              element.title.toString().toUpperCase(),
              color: element.title == selectedOptionBottomSheetButton
                  ? ColorResource.colorFFFFFF
                  : ColorResource.color23375A,
              fontWeight: FontWeight.w700,
              // lineHeight: 1,
              fontSize: FontSize.thirteen,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ));
    }
    return widgets;
  }

  openBottomSheet(BuildContext buildContext, String cardTitle) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
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
          case StringResource.addNewContact:
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.89,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BottomSheetAppbar(
                        title:
                            Languages.of(context)!.addNewContact.toUpperCase(),
                        padding: const EdgeInsets.fromLTRB(23, 16, 15, 5)),
                    const Expanded(
                        child: Center(child: CircularProgressIndicator())),
                  ],
                ));
          default:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}
