// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/address_screen/address_screen.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class CallDetailsBottomSheetScreen extends StatelessWidget {
  const CallDetailsBottomSheetScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final CaseDetailsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 13),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  Languages.of(context)!.callDetails.toUpperCase(),
                  fontSize: FontSize.fourteen,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: ColorResource.color23375A,
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(ImageResource.close))
              ],
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              decoration: new BoxDecoration(
                  color: ColorResource.colorF7F8FA,
                  // ignore: unnecessary_new
                  borderRadius: new BorderRadius.all(Radius.circular(10.0))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      'DEBASISH PATNAIK',
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.fourteen,
                      fontStyle: FontStyle.normal,
                      lineHeight: 1,
                      color: ColorResource.color333333,
                    ),
                    SizedBox(height: 7),
                    CustomText(
                      'TVSF_BFRT6458922993',
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.fourteen,
                      fontStyle: FontStyle.normal,
                      color: ColorResource.color333333,
                    ),
                    SizedBox(height: 17),
                    CustomText(
                      Languages.of(context)!.overdueAmount,
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.twelve,
                      fontStyle: FontStyle.normal,
                      color: ColorResource.color666666,
                    ),
                    SizedBox(height: 9),
                    CustomText(
                      '397553.67',
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.twentyFour,
                      fontStyle: FontStyle.normal,
                      color: ColorResource.color333333,
                      lineHeight: 1,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: bloc.multiCallDetilsList.length,
              itemBuilder: (context, i) {
                return SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        bloc.multiCallDetilsList[i].title.toUpperCase(),
                        fontSize: FontSize.fourteen,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: ColorResource.color23375A,
                      ),
                      SizedBox(height: 7),
                      Container(
                        width: double.infinity,
                        decoration: new BoxDecoration(
                            color: bloc.multiCallDetilsList[i].isDeclinded
                                ? ColorResource.colorD5344C.withOpacity(0.17)
                                : ColorResource.colorF8F9FB,
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        CustomText(
                                          bloc.multiCallDetilsList[i].mobileNo,
                                          fontSize: FontSize.fourteen,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          color: ColorResource.color484848,
                                        ),
                                        SizedBox(width: 10),
                                        bloc.multiCallDetilsList[i].isDeclinded
                                            ? CustomText(
                                                Languages.of(context)!
                                                    .declinedCall,
                                                fontSize: FontSize.fourteen,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                color:
                                                    ColorResource.colorD5344C,
                                              )
                                            : SizedBox(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: SizedBox(
                                          width: 150,
                                          child: Container(
                                              decoration: new BoxDecoration(
                                                  color:
                                                      ColorResource.colorBEC4CF,
                                                  borderRadius:
                                                      new BorderRadius.all(
                                                          new Radius.circular(
                                                              75.0))),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      ImageResource.phone),
                                                  SizedBox(width: 12),
                                                  CustomText(
                                                    Languages.of(context)!.call,
                                                    color: ColorResource
                                                        .color23375A,
                                                    lineHeight: 1,
                                                    fontSize: FontSize.fourteen,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w700,
                                                  )
                                                ],
                                              )))),
                                  GestureDetector(
                                    // onTap: () => broPTPSheet(context),
                                    onTap: () => Navigator.pushNamed(
                                        context, AppRoutes.phoneScreen),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          Languages.of(context)!.view,
                                          lineHeight: 1,
                                          fontSize: FontSize.fourteen,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                          color: ColorResource.color23375A,
                                        ),
                                        const SizedBox(width: 10),
                                        Image.asset(ImageResource.viewShape,
                                            height: 20),
                                        SizedBox(width: 10)
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
    );
  }

  void broPTPSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
            // top: false,
            bottom: false,
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.89,
                child: AddressScreen()),
            // child: Container(
            //   width: double.infinity,
            //   height: 300,
            //   color: ColorResource.colorFFFFFF,
            // )
          );
        });
  }
}
