import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/capture_image_screen/capture_image_bottom_sheet.dart';
import 'package:origa/screen/collection_screen/collections_bottom_sheet.dart';
import 'package:origa/screen/dispute_screen/dispute_bottom_sheet.dart';
import 'package:origa/screen/other_feed_back_screen/other_feed_back_bottom_sheet.dart';
import 'package:origa/screen/ots_screen/ots_bottom_sheet.dart';
import 'package:origa/screen/ptp_screen/ptp_bottom_sheet.dart';
import 'package:origa/screen/remainder_screen/remainder_bottom_sheet.dart';
import 'package:origa/screen/repo_screen/repo_bottom_sheet.dart';
import 'package:origa/screen/rtp_screen/rtp_bottom_sheet.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
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
  String selectedOptionBottomSheetButton = '';
  @override
  Widget build(BuildContext context) {
    List<OptionBottomSheetButtonModel> optionBottomSheetButtonList = [
      OptionBottomSheetButtonModel(
          Languages.of(context)!.addNewContact, StringResource.addNewContact),
      OptionBottomSheetButtonModel(
          Languages.of(context)!.otherFeedBack, StringResource.otherFeedback),
    ];
    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is ClickPTPState) {
          openBottomSheet(context, StringResource.ptp);
        }
        if (state is ClickRTPState) {
          openBottomSheet(context, StringResource.rtp);
        }
        if (state is ClickDisputeState) {
          openBottomSheet(context, StringResource.dispute);
        }
        if (state is ClickRemainderState) {
          openBottomSheet(context, StringResource.remainder);
        }
        if (state is ClickCollectionsState) {
          openBottomSheet(context, StringResource.collections);
        }
        if (state is ClickOTSState) {
          openBottomSheet(context, StringResource.ots);
        }
      },
      child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
        bloc: widget.bloc,
        builder: (context, state) {
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
                          padding: EdgeInsets.zero,
                          itemCount:
                              widget.bloc.phoneCustomerMetGridList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int innerIndex) {
                            return Padding(
                              padding: const EdgeInsets.all(4.5),
                              child: GestureDetector(
                                onTap: widget.bloc
                                    .phoneCustomerMetGridList[innerIndex].onTap,
                                // () {
                                //   switch (widget.bloc
                                //       .addressCustomerMetGridList[innerIndex].title) {
                                //     case StringResource.ptp:
                                //       openBottomSheet(
                                //         context,
                                //         StringResource.ptp,
                                //       );
                                //       break;
                                //     case StringResource.rtp:
                                //       openBottomSheet(context, StringResource.rtp);
                                //       break;
                                //     case StringResource.dispute:
                                //       openBottomSheet(
                                //           context, StringResource.dispute);
                                //       break;
                                //     case StringResource.remainder:
                                //       openBottomSheet(
                                //           context, StringResource.remainder);
                                //       break;
                                //     case StringResource.collections:
                                //       openBottomSheet(
                                //           context, StringResource.collections);
                                //       break;
                                //     case StringResource.ots:
                                //       openBottomSheet(context, StringResource.ots);
                                //       break;
                                //     default:
                                //   }
                                // },
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(widget
                                          .bloc
                                          .phoneCustomerMetGridList[innerIndex]
                                          .icon),
                                      const SizedBox(height: 8),
                                      CustomText(
                                        widget
                                            .bloc
                                            .phoneCustomerMetGridList[
                                                innerIndex]
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
                        const SizedBox(height: 30),
                        Wrap(
                          spacing: 15,
                          runSpacing: 8,
                          children: _buildOptionBottomSheetOpenButton(
                            optionBottomSheetButtonList,
                            context,
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Expanded(
                        //       child: CustomButton(
                        //         StringResource.addNewContact.toUpperCase(),
                        //         // onTap: () => openBottomSheet(
                        //         //     context, StringResource.addNewContact),
                        //         textColor: ColorResource.colorFFFFFF,
                        //         borderColor: ColorResource.color23375A,
                        //         cardShape: 75,
                        //         buttonBackgroundColor: ColorResource.color23375A,
                        //       ),
                        //     ),
                        //     SizedBox(height: 11),
                        //     Expanded(
                        //       child: CustomButton(
                        //         Languages.of(context)!.otherFeedBack,
                        //         onTap: () => openBottomSheet(
                        //             context, StringResource.otherFeedback),
                        //         textColor: ColorResource.color23375A,
                        //         borderColor: ColorResource.color23375A,
                        //         cardShape: 75,
                        //         buttonBackgroundColor: ColorResource.colorFFFFFF,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 100)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
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
      enableDrag: false,
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
