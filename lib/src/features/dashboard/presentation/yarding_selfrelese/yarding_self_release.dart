import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/src/features/dashboard/presentation/yarding_selfrelese/repo_status.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/date_format_utils.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/no_case_available.dart';

class YardingAndSelfRelease extends StatefulWidget {
  const YardingAndSelfRelease(this.bloc, {Key? key}) : super(key: key);
  final DashboardBloc bloc;

  @override
  YardingAndSelfReleaseState createState() => YardingAndSelfReleaseState();
}

class YardingAndSelfReleaseState extends State<YardingAndSelfRelease> {
  @override
  void initState() {
    super.initState();
  }

  int? _selectedIndex;
  String? _id;
  String? custName;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorResourceDesign.whiteTwo,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizes.p20),
            topRight: Radius.circular(Sizes.p20)),
      ),
      height: MediaQuery.of(context).size.height * 0.85,
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return WillPopScope(
          onWillPop: () async => true,
          child: Container(
            decoration: const BoxDecoration(
              color: ColorResourceDesign.whiteTwo,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Sizes.p20),
                  topRight: Radius.circular(Sizes.p20)),
            ),
            padding: const EdgeInsets.only(top: Sizes.p16),
            // color: ColorResource.colorF7F8FA,
            child: SafeArea(
              child: widget.bloc.yardingAndSelfReleaseData.isEmpty
                  ? Scaffold(
                      backgroundColor: ColorResourceDesign.whiteTwo,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BottomSheetAppbar(
                            title: Languages.of(context)!.yardingSelfRelease,
                          ),
                          gapH32,
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(Sizes.p20),
                              child: NoCaseAvailble.buildNoCaseAvailable(),
                            ),
                          )
                        ],
                      ),
                    )
                  : Scaffold(
                      backgroundColor: ColorResourceDesign.whiteTwo,
                      bottomNavigationBar: Container(
                        height: 66,
                        decoration: const BoxDecoration(
                            color: ColorResourceDesign.whiteColor,
                            border: Border(
                                top: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 0.13)))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              Sizes.p12, Sizes.p4, Sizes.p20, Sizes.p0),
                          child: CustomButton(
                            Languages.of(context)!.enterRepoDetails,
                            fontSize: Sizes.p16,
                            onTap: () {
                              if (_selectedIndex != null) {
                                repoStatusModeSheet(context);
                              } else {
                                AppUtils.showToast(
                                    Languages.of(context)!.notSelectedCase,
                                    backgroundColor:
                                        ColorResourceDesign.redColor);
                              }
                            },
                          ),
                        ),
                      ),
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BottomSheetAppbar(
                            title: Languages.of(context)!.yardingSelfRelease,
                          ),
                          gapH12,
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.p20, vertical: Sizes.p4),
                              child: ListView.builder(
                                  itemCount: widget
                                      .bloc.yardingAndSelfReleaseData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: Sizes.p20),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: ColorResourceDesign
                                                  .whiteColor,
                                              border: Border.all(
                                                  color: ColorResourceDesign
                                                      .lightGray,
                                                  width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Sizes.p10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.25),
                                                  // spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                gapH2,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: Sizes.p24,
                                                          vertical: Sizes.p2),
                                                      child: CustomText(
                                                        Languages.of(context)!
                                                            .loanAccountNumber,
                                                        fontSize: Sizes.p12,
                                                        color: ColorResourceDesign
                                                            .appTextPrimaryColor,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: Sizes.p24,
                                                          vertical: Sizes.p2),
                                                      child: CustomText(
                                                        widget
                                                                .bloc
                                                                .yardingAndSelfReleaseData[
                                                                    index]
                                                                .agrRef ??
                                                            '',
                                                        color: ColorResourceDesign
                                                            .appTextPrimaryColor,
                                                        fontWeight:
                                                            FontResourceDesign
                                                                .textFontWeightSemiBold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                AppUtils.showDivider(),
                                                // const SizedBox(height: 6.0,),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          Sizes.p24,
                                                          Sizes.p0,
                                                          Sizes.p10,
                                                          Sizes.p0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                            '${Languages.of(context)!.registrationNo}. ',
                                                            color:
                                                                ColorResourceDesign
                                                                    .blackTwo,
                                                          ),
                                                          Flexible(
                                                            child: CustomText(
                                                              widget
                                                                      .bloc
                                                                      .yardingAndSelfReleaseData[
                                                                          index]
                                                                      .eventAttr
                                                                      ?.registrationNo ??
                                                                  '',
                                                              isSingleLine:
                                                                  true,
                                                              fontSize:
                                                                  Sizes.p16,
                                                              lineHeight: 1,
                                                              color: ColorResourceDesign
                                                                  .appTextPrimaryColor,
                                                              fontWeight:
                                                                  FontResourceDesign
                                                                      .textFontWeightSemiBold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      gapH4,
                                                      CustomText(
                                                        widget
                                                            .bloc
                                                            .yardingAndSelfReleaseData[
                                                                index]
                                                            .eventAttr!
                                                            .customerName!,
                                                        fontSize:
                                                            FontSize.sixteen,
                                                        color: ColorResourceDesign
                                                            .appTextPrimaryColor,
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                // Padding(
                                                //   padding: const EdgeInsets
                                                //           .symmetric(
                                                //       horizontal: 15,
                                                //       vertical: 6),
                                                //   child: Container(
                                                //     width: double.infinity,
                                                //     padding: const EdgeInsets
                                                //             .fromLTRB(
                                                //         20, 12, 15, 12),
                                                //     decoration: BoxDecoration(
                                                //       color: ColorResource
                                                //           .colorF8F9FB,
                                                //       borderRadius:
                                                //           BorderRadius.circular(
                                                //               10),
                                                //     ),
                                                //     child: CustomText(
                                                //       widget
                                                //           .bloc
                                                //           .yardingAndSelfReleaseData
                                                //           .result![index]
                                                //           .address![0]
                                                //           .value!,
                                                //       color: ColorResource
                                                //           .color484848,
                                                //       fontSize:
                                                //           FontSize.fourteen,
                                                //     ),
                                                //   ),
                                                // ),
                                                gapH4,
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: Sizes.p14,
                                                  ),
                                                  child: Divider(
                                                    color: ColorResourceDesign
                                                        .lightGray,
                                                    thickness: 0.5,
                                                  ),
                                                ),
                                                //  const SizedBox(height: 5,),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          Sizes.p24,
                                                          Sizes.p4,
                                                          Sizes.p10,
                                                          Sizes.p12),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CustomText(
                                                              Languages.of(
                                                                      context)!
                                                                  .repoDate,
                                                              color: ColorResourceDesign
                                                                  .appTextPrimaryColor,
                                                            ),
                                                            CustomText(
                                                              widget
                                                                          .bloc
                                                                          .yardingAndSelfReleaseData[
                                                                              index]
                                                                          .eventAttr!
                                                                          .date !=
                                                                      null
                                                                  ? DateFormatUtils.followUpDateFormate(widget
                                                                      .bloc
                                                                      .yardingAndSelfReleaseData[
                                                                          index]
                                                                      .eventAttr!
                                                                      .date!)
                                                                  : '-',
                                                              color: ColorResourceDesign
                                                                  .appTextPrimaryColor,
                                                              fontWeight:
                                                                  FontResourceDesign
                                                                      .textFontWeightSemiBold,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // const Spacer(),
                                                      Expanded(
                                                        child: SizedBox(
                                                          // width: 123,
                                                          height: 53,
                                                          child: _selectedIndex !=
                                                                      null &&
                                                                  _selectedIndex ==
                                                                      index
                                                              ? CustomButton(
                                                                  Languages.of(
                                                                          context)!
                                                                      .selected,
                                                                  isSingleLine:
                                                                      true,
                                                                  padding: 3,
                                                                  fontSize:
                                                                      Sizes.p12,
                                                                )
                                                              : CustomButton(
                                                                  Languages.of(
                                                                          context)!
                                                                      .select
                                                                      .toUpperCase(),
                                                                  fontSize:
                                                                      Sizes.p12,
                                                                  buttonBackgroundColor:
                                                                      ColorResourceDesign
                                                                          .whiteThree,
                                                                  borderColor:
                                                                      ColorResourceDesign
                                                                          .whiteThree,
                                                                  textColor:
                                                                      ColorResourceDesign
                                                                          .textColor,
                                                                  cardElevation:
                                                                      3.0,
                                                                  onTap: () {
                                                                    _onSelected(
                                                                        index);
                                                                    setState(
                                                                        () {
                                                                      _id = widget
                                                                          .bloc
                                                                          .yardingAndSelfReleaseData[
                                                                              index]
                                                                          .sId!;
                                                                      custName = widget
                                                                              .bloc
                                                                              .yardingAndSelfReleaseData[index]
                                                                              .eventAttr!
                                                                              .customerName ??
                                                                          '';
                                                                    });
                                                                  },
                                                                ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      }),
    );
  }

  void repoStatusModeSheet(BuildContext buildContext) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: ColorResourceDesign.whiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Sizes.p20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                RepoStatus.buildRepoSelfReleaseTab(
                    context, _id, custName, widget.bloc)));
  }
}
