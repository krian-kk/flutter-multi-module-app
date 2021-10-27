// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/language_model.dart';
import 'package:origa/screen/profile_screen.dart/bloc/profile_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class LanguageBottomSheetScreen extends StatefulWidget {
  const LanguageBottomSheetScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final ProfileBloc bloc;

  @override
  State<LanguageBottomSheetScreen> createState() =>
      _LanguageBottomSheetScreenState();
}

class _LanguageBottomSheetScreenState extends State<LanguageBottomSheetScreen> {
  List<LanguageModel> languageList = [];
  @override
  Widget build(BuildContext context) {
    languageList = [
      LanguageModel(StringResource.english, true,
          Languages.of(context)!.defaultLaunguage),
      LanguageModel(StringResource.hindi, true,
          Languages.of(context)!.choiceOtherLanguages),
      LanguageModel(StringResource.tamil, false,
          Languages.of(context)!.choiceOtherLanguages),
      LanguageModel(StringResource.kannadam, false,
          Languages.of(context)!.choiceOtherLanguages)
    ];
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.87,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BottomSheetAppbar(
                      title: Languages.of(context)!.launguage.toUpperCase(),
                      padding: EdgeInsets.all(0),
                      color: ColorResource.color23375A,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     CustomText(
                    //       Languages.of(context)!.launguage.toUpperCase(),
                    //       fontSize: FontSize.fourteen,
                    //       fontWeight: FontWeight.w700,
                    //       fontStyle: FontStyle.normal,
                    //       color: ColorResource.color23375A,
                    //     ),
                    //     Spacer(),
                    //     GestureDetector(
                    //         onTap: () {
                    //           Navigator.pop(context);
                    //         },
                    //         child: Image.asset(ImageResource.close))
                    //   ],
                    // ),
                    SizedBox(height: 14),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: languageList.length,
                        itemBuilder: (context, i) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              languageList[i].isTitle
                                  ? CustomText(
                                      languageList[i].title.toUpperCase(),
                                      fontWeight: FontWeight.w700,
                                      fontSize: FontSize.twelve,
                                      fontStyle: FontStyle.normal,
                                      color: ColorResource.color23375A,
                                    )
                                  : SizedBox(),
                              SizedBox(height: 6),
                              GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  widget.bloc.languageValue = i;
                                },
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  decoration: new BoxDecoration(
                                      color: ColorResource.colorF8F9FB,
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: ListTile(
                                    title: CustomText(
                                      languageList[i].language,
                                      lineHeight: 1,
                                      fontSize: FontSize.fourteen,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      color: ColorResource.color484848,
                                    ),
                                    leading: (widget.bloc.languageValue == i)
                                        ? Image.asset(ImageResource.radioOn)
                                        : Image.asset(ImageResource.radioOff),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
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
                    offset: Offset(1.0, 1.0),
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 11.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 190,
                      child: CustomButton(
                        Languages.of(context)!.okay.toUpperCase(),
                        onTap: () => Navigator.pop(context),
                        cardShape: 5,
                        fontSize: FontSize.sixteen,
                        leadingWidget: CircleAvatar(
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
      ),
    );
  }
}
