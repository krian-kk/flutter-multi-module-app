import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:domain_models/common/language_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/src/features/profile/bloc/profile_bloc.dart';
import 'package:origa/utils/preference_helper.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import '../../../../../utils/constants.dart';

class CustomerLanguagePreference extends StatefulWidget {
  final BuildContext mcontext;
  final List<CustomerLanguagePreferenceModel> customerLanguagePreferenceList;

  const CustomerLanguagePreference({
    Key? key,
    required this.mcontext,
    required this.customerLanguagePreferenceList,
  }) : super(key: key);

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

    ratioIndex =
        BlocProvider.of<ProfileBloc>(widget.mcontext).ratioIndexS2T ?? 0;
    setLanguageCode =
        BlocProvider.of<ProfileBloc>(widget.mcontext).setLangCodeS2T ?? 'en';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: BlocProvider.of<ProfileBloc>(widget.mcontext),
      listener: (BuildContext context, ProfileState state) {},
      child: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: BlocProvider.of<ProfileBloc>(widget.mcontext),
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
                          padding: const EdgeInsets.fromLTRB(
                            Sizes.p20,
                            Sizes.p20,
                            Sizes.p20,
                            Sizes.p10,
                          ),
                          child: BottomSheetAppbar(
                            title: Languages.of(context)!
                                .customerLanguagePreference
                                .toUpperCase(),
                            color: ColorResourceDesign.textColor,
                            padding: const EdgeInsets.all(Sizes.p0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.p20, vertical: Sizes.p4),
                          child: CustomText(
                            Languages.of(context)!.chooseLanguage.toUpperCase(),
                            fontWeight:
                                FontResourceDesign.textFontWeightSemiBold,
                            fontSize: Sizes.p12,
                            color: ColorResourceDesign.textColor,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  widget.customerLanguagePreferenceList.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.p24,
                                    vertical: Sizes.p4,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color:
                                            ColorResourceDesign.lightWhiteGray,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Sizes.p10))),
                                    child: RadioListTile<int>(
                                      activeColor:
                                          ColorResourceDesign.textColor,
                                      title: CustomText(
                                        widget.customerLanguagePreferenceList[i]
                                            .language!,
                                        lineHeight: Sizes.p1,
                                        color: ColorResourceDesign.darkGray,
                                      ),
                                      groupValue: ratioIndex,
                                      value: i,
                                      onChanged: (int? val) async {
                                        setState(() {
                                          ratioIndex = val!;
                                          setLanguageCode = widget
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
                      color: ColorResourceDesign.whiteColor,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: ColorResourceDesign.blackTwo.withOpacity(0.2),
                          blurRadius: Sizes.p2,
                          offset: const Offset(Sizes.p1, Sizes.p1),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Sizes.p10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 190,
                            child: CustomButton(
                              Languages.of(context)!.okay.toUpperCase(),
                              onTap: () {
                                BlocProvider.of<ProfileBloc>(widget.mcontext)
                                    .ratioIndexS2T = ratioIndex;
                                BlocProvider.of<ProfileBloc>(widget.mcontext)
                                    .setLangCodeS2T = setLanguageCode;
                                BlocProvider.of<ProfileBloc>(widget.mcontext)
                                    .add(CustomerLanguagePreferenceEvent());
                                Navigator.pop(context);
                              },
                              cardShape: Sizes.p4, //5
                              fontSize: Sizes.p16,
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
