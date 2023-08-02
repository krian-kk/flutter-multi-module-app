import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/src/features/dashboard/presentation/yarding_selfrelese/repo_status.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/date_format_utils.dart';
import 'package:origa/utils/font.dart';
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
        color: ColorResource.colorF7F8FA,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      height: MediaQuery.of(context).size.height * 0.85,
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return WillPopScope(
          onWillPop: () async => true,
          child: Container(
            decoration: const BoxDecoration(
              color: ColorResource.colorF7F8FA,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            padding: const EdgeInsets.only(top: 16),
            // color: ColorResource.colorF7F8FA,
            child: SafeArea(
              child: widget.bloc.yardingAndSelfReleaseData.isEmpty
                  ? Scaffold(
                      backgroundColor: ColorResource.colorF7F8FA,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BottomSheetAppbar(
                            title: Languages.of(context)!.yardingSelfRelease,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: NoCaseAvailble.buildNoCaseAvailable(),
                            ),
                          )
                        ],
                      ),
                    )
                  : Scaffold(
                      backgroundColor: ColorResource.colorF7F8FA,
                      bottomNavigationBar: Container(
                        height: 66,
                        decoration: const BoxDecoration(
                            color: ColorResource.colorFFFFFF,
                            border: Border(
                                top: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 0.13)))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(13, 5, 20, 0),
                          child: CustomButton(
                            Languages.of(context)!.enterRepoDetails,
                            fontSize: FontSize.sixteen,
                            onTap: () {
                              if (_selectedIndex != null) {
                                repoStatusModeSheet(context);
                              } else {
                                AppUtils.showToast(
                                    Languages.of(context)!.notSelectedCase,
                                    backgroundColor: Colors.red);
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
                          const SizedBox(height: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
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
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: ColorResource.colorffffff,
                                              border: Border.all(
                                                  color:
                                                      ColorResource.colorDADADA,
                                                  width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                const SizedBox(
                                                  height: 2.0,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 24,
                                                          vertical: 2),
                                                      child: CustomText(
                                                        Languages.of(context)!
                                                            .loanAccountNumber,
                                                        fontSize:
                                                            FontSize.twelve,
                                                        color: ColorResource
                                                            .color101010,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 24,
                                                          vertical: 2),
                                                      child: CustomText(
                                                        widget
                                                                .bloc
                                                                .yardingAndSelfReleaseData[
                                                                    index]
                                                                .agrRef ??
                                                            '',
                                                        color: ColorResource
                                                            .color101010,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                AppUtils.showDivider(),
                                                // const SizedBox(height: 6.0,),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          23, 0, 10, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                            '${Languages.of(context)!.registrationNo}. ',
                                                            color: ColorResource
                                                                .color000000,
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
                                                              fontSize: FontSize
                                                                  .seventeen,
                                                              lineHeight: 1,
                                                              color: ColorResource
                                                                  .color101010,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 3.0,
                                                      ),
                                                      CustomText(
                                                        widget
                                                            .bloc
                                                            .yardingAndSelfReleaseData[
                                                                index]
                                                            .eventAttr!
                                                            .customerName!,
                                                        fontSize:
                                                            FontSize.sixteen,
                                                        color: ColorResource
                                                            .color101010,
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
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                  ),
                                                  child: Divider(
                                                    color: ColorResource
                                                        .colorDADADA,
                                                    thickness: 0.5,
                                                  ),
                                                ),
                                                //  const SizedBox(height: 5,),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          23, 5, 10, 13),
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
                                                              color: ColorResource
                                                                  .color101010,
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
                                                              color: ColorResource
                                                                  .color101010,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
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
                                                                      FontSize
                                                                          .twelve,
                                                                )
                                                              : CustomButton(
                                                                  Languages.of(
                                                                          context)!
                                                                      .select
                                                                      .toUpperCase(),
                                                                  fontSize:
                                                                      FontSize
                                                                          .twelve,
                                                                  buttonBackgroundColor:
                                                                      ColorResource
                                                                          .colorFEFFFF,
                                                                  borderColor:
                                                                      ColorResource
                                                                          .colorFEFFFF,
                                                                  textColor:
                                                                      ColorResource
                                                                          .color23375A,
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
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                RepoStatus.buildRepoSelfReleaseTab(
                    context, _id, custName, widget.bloc)));
  }
}
