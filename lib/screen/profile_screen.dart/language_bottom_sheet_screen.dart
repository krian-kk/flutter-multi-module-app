import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/languages/app_locale_constant.dart';
import 'package:origa/models/language_model.dart';
import 'package:origa/screen/profile_screen.dart/bloc/profile_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/preference_helper.dart';
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
  List<LanguageModel> languageList = <LanguageModel>[];
  String? setLanguageCode;
  int? ratioIndex;

  //  int? selectedLanguagesIndex;

  @override
  initState() {
    super.initState();
    getLanguageCode();
  }

  getLanguageCode() async {
    await PreferenceHelper.getInt(keyPair: 'mainLanguage').then((value) {
      setState(() {
        ratioIndex = value as int;
      });
    });
    await PreferenceHelper.getString(keyPair: 'mainLanguageCode').then((value) {
      setState(() {
        setLanguageCode = value.toString();
      });
    });
    // ratioIndex = PreferenceHelper.getInt(keyPair: 'mainLanguage') as int;
    // setLanguageCode =
    //     PreferenceHelper.getString(keyPair: 'mainLanguageCode').toString();
  }

  @override
  Widget build(BuildContext context) {
    languageList = <LanguageModel>[
      LanguageModel(StringResource.english, true,
          Languages.of(context)!.defaultLanguage, 'en'),
      LanguageModel(StringResource.hindi, true,
          Languages.of(context)!.choiceOtherLanguages, 'hi'),
      LanguageModel(StringResource.tamil, false,
          Languages.of(context)!.choiceOtherLanguages, 'ta'),

      /*Not available in First release*/

      // LanguageModel(StringResource.kannadam, false,
      //     Languages.of(context)!.choiceOtherLanguages, 'ka')
    ];
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.87,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    BottomSheetAppbar(
                      title: Languages.of(context)!.languages.toUpperCase(),
                      color: ColorResource.color23375A,
                      padding: const EdgeInsets.all(0),
                    ),
                    const SizedBox(height: 14),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: languageList.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              languageList[i].isTitle
                                  ? CustomText(
                                      languageList[i].title.toUpperCase(),
                                      fontWeight: FontWeight.w700,
                                      fontSize: FontSize.twelve,
                                      color: ColorResource.color23375A,
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                decoration: const BoxDecoration(
                                    color: ColorResource.colorF8F9FB,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: RadioListTile<int>(
                                  activeColor: ColorResource.color23375A,
                                  title: CustomText(
                                    languageList[i].language,
                                    lineHeight: 1,
                                    color: ColorResource.color484848,
                                  ),
                                  groupValue: ratioIndex,
                                  value: i,
                                  onChanged: (int? val) async {
                                    setState(() {
                                      ratioIndex = val!;
                                      setLanguageCode =
                                          languageList[i].languageCode;
                                    });
                                  },
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
              decoration: BoxDecoration(
                color: ColorResource.colorFFFFFF,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: ColorResource.color000000.withOpacity(0.2),
                    blurRadius: 2.0,
                    offset: const Offset(1.0, 1.0),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 11.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 190,
                      child: CustomButton(
                        Languages.of(context)!.okay.toUpperCase(),
                        onTap: () {
                          changeLanguage(context, setLanguageCode!);
                          PreferenceHelper.setPreference(
                              'mainLanguage', ratioIndex ?? 0);
                          PreferenceHelper.setPreference(
                              'mainLanguageCode', setLanguageCode);
                          Navigator.pop(context);
                        },
                        cardShape: 5,
                        fontSize: FontSize.sixteen,
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
      ),
    );
  }
}
