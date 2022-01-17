import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/dashboard_all_models/case.dart';
import 'package:origa/models/dashboard_all_models/dashboard_all_models.dart';
import 'package:origa/models/dashboard_myvisit_model/dashboard_myvisit_model.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/search_screen/search_list.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/widgets/no_case_available.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/floating_action_button.dart';

class MyVisitsBottomSheet extends StatefulWidget {
  final DashboardBloc bloc;
  const MyVisitsBottomSheet(this.bloc, {Key? key}) : super(key: key);

  @override
  _MyVisitsBottomSheetState createState() => _MyVisitsBottomSheetState();
}

class _MyVisitsBottomSheetState extends State<MyVisitsBottomSheet> {
  // late MyvisitsBloc bloc;
  @override
  void initState() {
    // bloc = MyvisitsBloc()..add(MyvisitsInitialEvent());
    super.initState();
  }

  // static List<Case>? custMet = [];
  // static List<Case>? custNotMet = [];
  // static List<Case>? custInvalid = [];

  static dynamic custMetTotalAmt = 0.0;
  static dynamic custNotMetTotalAmt = 0.0;
  static dynamic invalidTotalAmt = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is SelectedTimeperiodDataLoadingState) {
          widget.bloc.selectedFilterDataLoading = true;
        }

        if (state is SelectedTimeperiodDataLoadedState) {
          widget.bloc.selectedFilterDataLoading = false;
        }

        if (state is ReturnVisitsApiState) {
          setState(() {
            widget.bloc.myVisitsData =
                MyVisitsCaseModel.fromJson(state.returnData);
          });
        }

        if (state is GetSearchDataState) {
          setState(() {
            widget.bloc.isShowSearchResult = true;
          });
          widget.bloc.selectedFilter = '';
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: ColorResource.colorF7F8FA,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        height: MediaQuery.of(context).size.height * 0.85,
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          // custMet!.clear();
          // custNotMet!.clear();
          // custInvalid!.clear();
          // custMetTotalAmt = 0.0;
          // custNotMetTotalAmt = 0.0;
          // invalidTotalAmt = 0.0;
          // for (Case element in widget.bloc.myVisitsData.result!.cases!) {
          //   print(element.collSubStatus);
          //   if (element.collSubStatus == Constants.ptp ||
          //       element.collSubStatus == Constants.denial ||
          //       element.collSubStatus == Constants.dispute ||
          //       element.collSubStatus == 'Denial' ||
          //       element.collSubStatus == 'Dispute' ||
          //       // element.collSubStatus == 'Feedback' ||
          //       // element.collSubStatus == 'REPO' ||
          //       element.collSubStatus == Constants.remainder ||
          //       element.collSubStatus == Constants.remainder_1 ||
          //       element.collSubStatus == Constants.collections ||
          //       element.collSubStatus == Constants.receipt ||
          //       element.collSubStatus == Constants.ots ||
          //       element.telSubStatus == Constants.ptp ||
          //       element.telSubStatus == Constants.denial ||
          //       element.telSubStatus == Constants.dispute ||
          //       element.telSubStatus == 'Denial' ||
          //       element.telSubStatus == 'Dispute' ||
          //       // element.telSubStatus == 'Feedback' ||
          //       // element.telSubStatus == 'REPO' ||
          //       element.telSubStatus == Constants.remainder ||
          //       element.telSubStatus == Constants.remainder_1 ||
          //       element.telSubStatus == Constants.collections ||
          //       element.telSubStatus == Constants.receipt ||
          //       element.telSubStatus == Constants.ots) {
          //     custMet!.add(element);
          //     custMetTotalAmt = (custMetTotalAmt + element.due);
          //   }
          // }

          // for (Case element in widget.bloc.myVisitsData.result!.cases!) {
          //   if (element.collSubStatus == Constants.leftMessage ||
          //       element.collSubStatus == Constants.doorLocked ||
          //       element.collSubStatus == Constants.entryRestricted ||
          //       element.collSubStatus == 'new' ||
          //       element.telSubStatus == Constants.telsubstatuslineBusy ||
          //       element.telSubStatus == Constants.telsubstatusswitchOff ||
          //       element.telSubStatus == Constants.telsubstatusrnr ||
          //       element.telSubStatus == Constants.telsubstatusoutOfNetwork ||
          //       element.telSubStatus == Constants.telsubstatusdisconnecting ||
          //       element.telSubStatus == 'new') {
          //     custNotMet!.add(element);
          //     custNotMetTotalAmt = (custNotMetTotalAmt + element.due);
          //   }
          // }

          // for (Case element in widget.bloc.myVisitsData.result!.cases!) {
          //   if (element.collSubStatus == Constants.wrongAddress ||
          //       element.collSubStatus == Constants.shifted ||
          //       element.collSubStatus == Constants.addressNotFound ||
          //       element.telSubStatus == Constants.telsubstatusdoesNotExist ||
          //       element.telSubStatus == Constants.telsubstatusincorrectNumber ||
          //       element.telSubStatus ==
          //           Constants.telsubstatusnumberNotWorking ||
          //       element.telSubStatus == Constants.telsubstatusnotOpeartional) {
          //     custInvalid!.add(element);
          //     invalidTotalAmt = (invalidTotalAmt + element.due);
          //   }
          // }
          return WillPopScope(
            onWillPop: () async => true,
            child: Container(
              padding: const EdgeInsets.only(top: 16),
              child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  backgroundColor: ColorResource.colorF7F8FA,
                  floatingActionButton: CustomFloatingActionButton(
                    onTap: () async {
                      widget.bloc.add(NavigateSearchEvent());
                    },
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      BottomSheetAppbar(
                        title: widget.bloc.userType == Constants.fieldagent
                            ? Languages.of(context)!.myVisits
                            : Languages.of(context)!.myCalls,
                        onTap: () {
                          widget.bloc.add(SetTimeperiodValueEvent());
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          Languages.of(context)!
                                              .count
                                              .toUpperCase(),
                                          fontSize: FontSize.ten,
                                          color: ColorResource.color101010,
                                        ),
                                        CustomText(
                                          widget.bloc.myVisitsData.result!.count
                                              .toString(),
                                          fontSize: FontSize.fourteen,
                                          color: ColorResource.color101010,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          Languages.of(context)!
                                              .amount
                                              .toUpperCase(),
                                          fontSize: FontSize.ten,
                                          color: ColorResource.color101010,
                                        ),
                                        CustomText(
                                          widget.bloc.myVisitsData.result!
                                              .totalAmt
                                              .toString(),
                                          fontSize: FontSize.fourteen,
                                          color: ColorResource.color101010,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Wrap(
                              runSpacing: 0,
                              spacing: 7,
                              children: _buildFilterOptions(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: ColorResource.colorD8D8D8))),
                        child: TabBar(
                          isScrollable: true,
                          indicatorColor: ColorResource.colorD5344C,
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: ColorResource.color23375A,
                              fontSize: FontSize.fourteen,
                              fontStyle: FontStyle.normal),
                          indicatorWeight: 5.0,
                          labelColor: ColorResource.color23375A,
                          unselectedLabelColor: ColorResource.colorC4C4C4,
                          tabs: [
                            Tab(
                                text:
                                    widget.bloc.userType == Constants.fieldagent
                                        ? Languages.of(context)!.customerMet
                                        : Languages.of(context)!.connected),
                            Tab(
                                text:
                                    widget.bloc.userType == Constants.fieldagent
                                        ? Languages.of(context)!.customerNotMet
                                        : Languages.of(context)!.unreachable),
                            Tab(text: Languages.of(context)!.invalid)
                          ],
                        ),
                      ),
                      widget.bloc.isShowSearchResult
                          ? widget.bloc.searchResultList.isNotEmpty
                              ? Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 0.0),
                                    child: SearchCaseList.buildListView(
                                      widget.bloc,
                                      resultData: widget.bloc.searchResultList,
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50, right: 20, left: 20),
                                        child: NoCaseAvailble
                                            .buildNoCaseAvailable(),
                                      ),
                                    ],
                                  ),
                                )
                          : Expanded(
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  // CustomerMetNotmetInvalidTab(bloc.caseList),
                                  // Customer Met
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: buildListView(widget.bloc,
                                        widget.bloc.myVisitsData.result?.met),
                                  ),
                                  // Customer Not Met
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: buildListView(
                                        widget.bloc,
                                        widget
                                            .bloc.myVisitsData.result?.notMet),
                                  ),
                                  // Invalid
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: buildListView(
                                        widget.bloc,
                                        widget
                                            .bloc.myVisitsData.result?.invalid),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  List<Widget> _buildFilterOptions() {
    List<Widget> widgets = [];
    for (var element in widget.bloc.filterOption) {
      widgets.add(_buildFilterWidget(element));
    }
    return widgets;
  }

  Widget _buildFilterWidget(String option) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.bloc.selectedFilter = option;
        });
        // switch (option) {
        //   case 'TODAY':
        //     break;
        //   case 'WEEKLY':
        //     break;
        //   case 'MONTHLY':
        //     break;
        //   default:
        // }
        widget.bloc.add(MyVisitApiEvent(timePeiod: option));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 11),
          width: 100,
          // height: 35,
          decoration: BoxDecoration(
            border: Border.all(color: ColorResource.colorDADADA, width: 0.5),
            borderRadius: BorderRadius.circular(10),
            color: option == widget.bloc.selectedFilter
                ? ColorResource.color23375A
                : Colors.white,
          ),
          child: Center(
            child: CustomText(
              option,
              fontSize: FontSize.twelve,
              fontWeight: FontWeight.w700,
              color: option == widget.bloc.selectedFilter
                  ? Colors.white
                  : ColorResource.color101010,
            ),
          ),
        ),
      ),
    );
  }

// static List<Case>? resultValue = [];

  // static List customerMet = [
  //   Constants.ptp,
  //   Constants.denial,
  //   Constants.dispute,
  //   Constants.remainder,
  //   Constants.collections,
  //   Constants.receipt,
  //   Constants.ots,
  // ];
  // static List customerNotMet = [
  //   Constants.leftMessage,
  //   Constants.doorLocked,
  //   Constants.entryRestricted,
  // ];
  // static List invalid = [
  //   Constants.wrongAddress,
  //   Constants.shifted,
  //   Constants.addressNotFound,
  // ];

  static Widget buildListView(DashboardBloc bloc, Met? caseLists) {
    return bloc.selectedFilterDataLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : caseLists!.cases!.isEmpty
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: NoCaseAvailble.buildNoCaseAvailable(),
                  ),
                ],
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: caseLists.cases?.length ?? 0,
                // itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      Languages.of(context)!
                                          .count
                                          .toUpperCase(),
                                      fontSize: FontSize.ten,
                                      color: ColorResource.color101010,
                                    ),
                                    CustomText(
                                      caseLists.count.toString(),
                                      fontSize: FontSize.fourteen,
                                      color: ColorResource.color101010,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      Languages.of(context)!
                                          .amount
                                          .toUpperCase(),
                                      fontSize: FontSize.ten,
                                      color: ColorResource.color101010,
                                    ),
                                    CustomText(
                                      caseLists.totalAmt.toString(),
                                      fontSize: FontSize.fourteen,
                                      color: ColorResource.color101010,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: () {
                            bloc.add(NavigateCaseDetailEvent(paramValues: {
                              'caseID': caseLists.cases![index].caseId
                            }));
                            Singleton.instance.agrRef =
                                caseLists.cases![index].agrRef ?? '';
                          },
                          child: Container(
                            margin: (index == caseLists.cases!.length - 1)
                                ? const EdgeInsets.only(bottom: 70)
                                : EdgeInsets.zero,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: ColorResource.colorffffff,
                              border: Border.all(
                                  color: ColorResource.colorDADADA, width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 2),
                                  child: CustomText(
                                    caseLists.cases![index].bankName! +
                                        ' / ' +
                                        caseLists.cases![index].agrRef!,
                                    fontSize: FontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                    color: ColorResource.color101010,
                                  ),
                                ),
                                AppUtils.showDivider(),
                                // Divider(
                                //   color: ColorResource.colorDADADA,
                                //   thickness: 0.5,
                                // ),
                                // const SizedBox(height: 6.0,),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 0, 10, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              caseLists.cases![index].due
                                                  .toString(),
                                              fontSize: FontSize.eighteen,
                                              color: ColorResource.color101010,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            const SizedBox(
                                              height: 3.0,
                                            ),
                                            CustomText(
                                              caseLists.cases![index].cust!,
                                              fontSize: FontSize.sixteen,
                                              color: ColorResource.color101010,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // const Spacer(),
                                      // if (resultValue[index].collSubStatus ==
                                      //     'new')
                                      caseLists.cases![index].collSubStatus ==
                                                  "new" &&
                                              Singleton.instance.usertype ==
                                                  Constants.fieldagent
                                          ? Container(
                                              width: 55,
                                              height: 19,
                                              // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                              decoration: BoxDecoration(
                                                  color:
                                                      ColorResource.colorD5344C,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Center(
                                                child: CustomText(
                                                  Languages.of(context)!.new_,
                                                  color:
                                                      ColorResource.colorffffff,
                                                  fontSize: FontSize.ten,
                                                  lineHeight: 1,
                                                ),
                                              ),
                                            )
                                          : caseLists.cases![index]
                                                          .telSubStatus ==
                                                      "new" &&
                                                  Singleton.instance.usertype ==
                                                      Constants.telecaller
                                              ? Container(
                                                  width: 55,
                                                  height: 19,
                                                  // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                  decoration: BoxDecoration(
                                                      color: ColorResource
                                                          .colorD5344C,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Center(
                                                    child: CustomText(
                                                      Languages.of(context)!
                                                          .new_,
                                                      color: ColorResource
                                                          .colorffffff,
                                                      fontSize: FontSize.ten,
                                                      lineHeight: 1,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 6),
                                  child: bloc.userType == Constants.fieldagent
                                      ? Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 12, 15, 12),
                                          decoration: BoxDecoration(
                                            color: ColorResource.colorF8F9FB,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: CustomText(
                                            caseLists.cases![index].contact![0]
                                                .value!,
                                            color: ColorResource.color484848,
                                            fontSize: FontSize.fourteen,
                                          ),
                                        )
                                      : Wrap(
                                          children: [
                                            for (var item in caseLists
                                                .cases![index].contact!)
                                              item.cType!.contains('mobile') ||
                                                      item.cType!
                                                          .contains('phone')
                                                  ? Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              right: 20),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 17,
                                                          vertical: 6),
                                                      decoration: BoxDecoration(
                                                        color: ColorResource
                                                            .colorF8F9FB,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: CustomText(
                                                        item.value!,
                                                        color: ColorResource
                                                            .color484848,
                                                        fontSize:
                                                            FontSize.fourteen,
                                                        lineHeight: 1.0,
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                          ],
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
                                    color: ColorResource.colorDADADA,
                                    thickness: 0.5,
                                  ),
                                ),
                                //  const SizedBox(height: 5,),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 5, 14, 13),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        Languages.of(context)!.followUpDate,
                                        fontSize: FontSize.fourteen,
                                        color: ColorResource.color101010,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      Row(
                                        children: [
                                          CustomText(
                                            caseLists
                                                .cases![index].followUpDate!,
                                            fontSize: FontSize.fourteen,
                                            color: ColorResource.color101010,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              CustomText(
                                                Languages.of(context)!.view,
                                                fontSize: FontSize.fourteen,
                                                color:
                                                    ColorResource.color23375A,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SvgPicture.asset(
                                                  ImageResource.forwardArrow)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
  }
}
