// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/cupertino.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/phone_screen/phone_screen.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_text.dart';

class CallDetailsBottomSheetScreen extends StatefulWidget {
  const CallDetailsBottomSheetScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final CaseDetailsBloc bloc;

  @override
  State<CallDetailsBottomSheetScreen> createState() =>
      _CallDetailsBottomSheetScreenState();
}

class _CallDetailsBottomSheetScreenState
    extends State<CallDetailsBottomSheetScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Column(
        children: [
          BottomSheetAppbar(
            title: Languages.of(context)!.callDetails.toUpperCase(),
            padding: EdgeInsets.fromLTRB(21, 13, 21, 12),
            color: ColorResource.color23375A,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(21, 0, 21, 12),
            child: CustomLoanUserDetails(
              userName:
                  widget.bloc.caseDetailsResult.result?.caseDetails?.cust ?? '',
              userId:
                  widget.bloc.caseDetailsResult.result?.caseDetails?.accNo ??
                      '',
              userAmount: widget.bloc.caseDetailsResult.result?.caseDetails?.due
                      ?.toDouble() ??
                  0,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 13)
                  .copyWith(top: 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget
                          .bloc.caseDetailsResult.result!.callDetails!.length,
                      itemBuilder: (context, i) {
                        return SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                (i + 1 > 9)
                                    ? Languages.of(context)!
                                            .phoneNumber
                                            .toUpperCase() +
                                        '${i + 1}'
                                    : Languages.of(context)!
                                            .phoneNumber
                                            .toUpperCase() +
                                        '0'
                                            '${i + 1}',
                                fontSize: FontSize.fourteen,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: ColorResource.color23375A,
                              ),
                              SizedBox(height: 7),
                              Container(
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                    color: ColorResource.colorF8F9FB,
                                    // color: widget
                                    //         .bloc.multiCallDetilsList[i].isDeclinded
                                    //     ? ColorResource.colorD5344C
                                    //         .withOpacity(0.17)
                                    //     : ColorResource.colorF8F9FB,
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(10.0))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 12, 12, 12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Row(
                                              children: [
                                                CustomText(
                                                  widget
                                                      .bloc
                                                      .caseDetailsResult
                                                      .result!
                                                      .callDetails![i]['value'],
                                                  fontSize: FontSize.fourteen,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      ColorResource.color484848,
                                                ),
                                                SizedBox(width: 10),
                                                // widget.bloc.multiCallDetilsList[i]
                                                //         .isDeclinded
                                                //     ? CustomText(
                                                //         Languages.of(context)!
                                                //             .declinedCall,
                                                //         fontSize: FontSize.fourteen,
                                                //         fontWeight: FontWeight.w400,
                                                //         fontStyle: FontStyle.normal,
                                                //         color: ColorResource
                                                //             .colorD5344C,
                                                //       )
                                                //     : SizedBox(),
                                              ],
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Image.asset(
                                                  ImageResource.activePerson)),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                      color: ColorResource
                                                          .colorBEC4CF,
                                                      borderRadius:
                                                          new BorderRadius.all(
                                                              new Radius
                                                                      .circular(
                                                                  75.0))),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                          ImageResource.phone),
                                                      SizedBox(width: 12),
                                                      CustomText(
                                                        Languages.of(context)!
                                                            .call,
                                                        color: ColorResource
                                                            .color23375A,
                                                        lineHeight: 1,
                                                        fontSize:
                                                            FontSize.fourteen,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      SizedBox(width: 40),
                                                    ],
                                                  ))),
                                          Spacer(),
                                          SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                              phoneBottomSheet(context);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  Languages.of(context)!.view,
                                                  lineHeight: 1,
                                                  fontSize: FontSize.fourteen,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      ColorResource.color23375A,
                                                ),
                                                const SizedBox(width: 10),
                                                Image.asset(
                                                    ImageResource.viewShape,
                                                    height: 20),
                                                SizedBox(width: 5)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15)
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void phoneBottomSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
            // top: false,
            bottom: false,
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.89,
                child: PhoneScreen(bloc: widget.bloc)),
          );
        });
  }
}
