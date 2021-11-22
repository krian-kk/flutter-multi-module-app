import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/yarding_selfrelese/repo_status.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class YardingAndSelfRelease extends StatefulWidget {
  final DashboardBloc bloc;
  YardingAndSelfRelease(this.bloc, {Key? key}) : super(key: key);

  @override
  _YardingAndSelfReleaseState createState() => _YardingAndSelfReleaseState();
}

class _YardingAndSelfReleaseState extends State<YardingAndSelfRelease> {
  // late YardingandselfreleaseBloc bloc;
  @override
  void initState() {
    // TODO: implement initState
    // bloc = YardingandselfreleaseBloc()
    //   ..add(YardingandselfreleaseInitialEvent());
    super.initState();
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
          onWillPop: () async => false,
          child: Container(
                padding: const EdgeInsets.only(top: 16),
                child: SafeArea(
                  child: Scaffold(
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
                          Languages.of(context)!.enterDepositionDetails,
                          fontSize: FontSize.sixteen,
                          fontWeight: FontWeight.w600,
                          onTap: () {
                            repoStatusModeSheet(context);
                          },
                        ),
                      ),
                    ),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        BottomSheetAppbar(
                          title: Languages.of(context)!.yardingSelfRelease,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: widget.bloc.caseList.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  int listCount = index + 1;
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
                                            boxShadow: [
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
                                                    padding:
                                                        const EdgeInsets.symmetric(
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
                                                    padding:
                                                       const EdgeInsets.symmetric(
                                                            horizontal: 24,
                                                            vertical: 2),
                                                    child: CustomText(
                                                      widget
                                                          .bloc
                                                          .caseList[index]
                                                          .loanID!,
                                                      fontSize:
                                                          FontSize.fourteen,
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
                                                padding: const EdgeInsets.fromLTRB(
                                                    23, 0, 10, 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    CustomText(
                                                      widget
                                                          .bloc
                                                          .caseList[index]
                                                          .amount!,
                                                      fontSize:
                                                          FontSize.eighteen,
                                                      color: ColorResource
                                                          .color101010,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    const SizedBox(
                                                      height: 3.0,
                                                    ),
                                                    CustomText(
                                                      widget
                                                          .bloc
                                                          .caseList[index]
                                                          .customerName!,
                                                      fontSize:
                                                          FontSize.sixteen,
                                                      color: ColorResource
                                                          .color101010,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 6),
                                                child: Container(
                                                  padding:
                                                     const EdgeInsets.fromLTRB(
                                                          20, 12, 15, 12),
                                                  decoration: BoxDecoration(
                                                    color: ColorResource
                                                        .colorF8F9FB,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: CustomText(
                                                    widget
                                                        .bloc
                                                        .caseList[index]
                                                        .address!,
                                                    color: ColorResource
                                                        .color484848,
                                                    fontSize:
                                                        FontSize.fourteen,
                                                  ),
                                                ),
                                              ),
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
                                                padding: const EdgeInsets.fromLTRB(
                                                    23, 5, 14, 13),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomText(
                                                          Languages.of(
                                                                  context)!
                                                              .repoDate,
                                                          fontSize: FontSize
                                                              .fourteen,
                                                          color: ColorResource
                                                              .color101010,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        CustomText(
                                                          widget
                                                              .bloc
                                                              .caseList[index]
                                                              .date!,
                                                          fontSize: FontSize
                                                              .fourteen,
                                                          color: ColorResource
                                                              .color101010,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    SizedBox(
                                                      width: 123,
                                                      height: 47,
                                                      child: CustomButton(
                                                        Languages.of(context)!
                                                            .select
                                                            .toUpperCase(),
                                                        fontSize:
                                                            FontSize.twelve,
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
                RepoStatus()));
  }
}
