// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class AddressDetailsBottomSheetScreen extends StatelessWidget {
  const AddressDetailsBottomSheetScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final CaseDetailsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.87,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 13),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  Languages.of(context)!.addressDetails.toUpperCase(),
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
                    ),
                    SizedBox(height: 7),
                    CustomText(
                      'TVSF_BFRT6458922993',
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.fourteen,
                      fontStyle: FontStyle.normal,
                    ),
                    SizedBox(height: 17),
                    CustomText(
                      'Overdue Amount',
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.twelve,
                      fontStyle: FontStyle.normal,
                    ),
                    SizedBox(height: 9),
                    CustomText(
                      '397553.67',
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.twentyFour,
                      fontStyle: FontStyle.normal,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: bloc.multiAddressDetilsList.length,
              itemBuilder: (context, i) {
                return SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                          bloc.multiAddressDetilsList[i].title.toUpperCase()),
                      SizedBox(height: 7),
                      Container(
                        width: double.infinity,
                        decoration: new BoxDecoration(
                            color: ColorResource.colorF8F9FB,
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: CustomText(
                                      bloc.multiAddressDetilsList[i].address,
                                      fontSize: FontSize.fourteen,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: ColorResource.color484848,
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                          ImageResource.activePerson)),
                                ],
                              ),
                              SizedBox(height: 10),
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
                                                      ImageResource.direction),
                                                  SizedBox(width: 12),
                                                  CustomText(
                                                    Languages.of(context)!
                                                        .viewMap,
                                                    color: ColorResource
                                                        .color23375A,
                                                  )
                                                ],
                                              )))),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        Languages.of(context)!.view,
                                        lineHeight: 1,
                                        color: ColorResource.color23375A,
                                      ),
                                      const SizedBox(width: 10),
                                      Image.asset(ImageResource.viewShape,
                                          height: 20),
                                      SizedBox(width: 10)
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
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
}
