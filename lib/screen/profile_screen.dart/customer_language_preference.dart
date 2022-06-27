import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/profile_screen.dart/bloc/profile_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/preference_helper.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

import '../../utils/constants.dart';

class CustomerLanguagePreference extends StatefulWidget {
  const CustomerLanguagePreference({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final ProfileBloc bloc;

  @override
  State<CustomerLanguagePreference> createState() =>
      _CustomerLanguagePreferenceState();
}

class _CustomerLanguagePreferenceState
    extends State<CustomerLanguagePreference> {
  String? setLanguageCode;
  int? ratioIndex;

  @override
  initState() {
    super.initState();
    getLanguageCode();
  }

  getLanguageCode() async {
    setState(() {
      PreferenceHelper.getInt(keyPair: Constants.s2tLangSelectedIndex)
          .then((value) {
        ratioIndex = value;
      });
      PreferenceHelper.getString(keyPair: Constants.s2tLangcode).then((value) {
        setLanguageCode = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: widget.bloc,
      listener: (BuildContext context, ProfileState state) {},
      child: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: widget.bloc,
        builder: (BuildContext context, ProfileState state) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.87,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10),
                          child: BottomSheetAppbar(
                            title: Languages.of(context)!
                                .customerLanguagePreference
                                .toUpperCase(),
                            color: ColorResource.color23375A,
                            padding: const EdgeInsets.all(0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: CustomText(
                            Languages.of(context)!.chooseLanguage.toUpperCase(),
                            fontWeight: FontWeight.w700,
                            fontSize: FontSize.twelve,
                            color: ColorResource.color23375A,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              // physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget
                                  .bloc.customerLanguagePreferenceList.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0, vertical: 4),
                                  child: Container(
                                    width: double.infinity,
                                    // height: 50,
                                    // alignment: Alignment.center,
                                    // margin: const EdgeInsets.symmetric(
                                    //     vertical: 4.0),
                                    decoration: const BoxDecoration(
                                        color: ColorResource.colorF8F9FB,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: RadioListTile<int>(
                                      activeColor: ColorResource.color23375A,
                                      title: CustomText(
                                        widget
                                            .bloc
                                            .customerLanguagePreferenceList[i]
                                            .language!,
                                        lineHeight: 1,
                                        color: ColorResource.color484848,
                                      ),
                                      groupValue: ratioIndex,
                                      value: i,
                                      onChanged: (int? val) async {
                                        setState(() {
                                          ratioIndex = val!;
                                          setLanguageCode = widget
                                              .bloc
                                              .customerLanguagePreferenceList[i]
                                              .languageCode;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
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
                                PreferenceHelper.setPreference(
                                    Constants.s2tLangSelectedIndex, ratioIndex);
                                PreferenceHelper.setPreference(
                                    Constants.s2tLangcode, setLanguageCode);
                                Navigator.pop(context);
                              },
                              cardShape: 5,
                              fontSize: FontSize.sixteen,
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
        },
      ),
    );
  }
}
