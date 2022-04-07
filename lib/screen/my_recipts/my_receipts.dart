import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/my_receipts_model.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/search_screen/search_list.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/date_formate_utils.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/floating_action_button.dart';
import 'package:origa/widgets/no_case_available.dart';

import '../../widgets/case_status_widget.dart';

class MyReceiptsBottomSheet extends StatefulWidget {
  const MyReceiptsBottomSheet(this.bloc, {Key? key}) : super(key: key);
  final DashboardBloc bloc;

  @override
  _MyReceiptsBottomSheetState createState() => _MyReceiptsBottomSheetState();
}

class _MyReceiptsBottomSheetState extends State<MyReceiptsBottomSheet> {
  // late MyreceiptsBloc bloc;

  // String? selectedFilter;

  //  List<String> filterOption = [];

  @override
  void initState() {
    super.initState();
  }

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

        if (state is ReturnReceiptsApiState) {
          setState(() {
            widget.bloc.myReceiptsData =
                MyReceiptsCaseModel.fromJson(state.returnData);
          });
        }

        if (state is GetSearchDataState) {
          setState(() {
            widget.bloc.isShowSearchResult = true;
            widget.bloc.selectedFilter = '';
            widget.bloc.selectedFilterIndex = '';
          });
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
                    children: [
                      BottomSheetAppbar(
                        title: Languages.of(context)!.myReceipts,
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
                                          widget.bloc.myReceiptsData.result!
                                              .totalCount
                                              .toString(),
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
                                          Constants.inr +
                                              widget.bloc.myReceiptsData.result!
                                                  .totalAmt
                                                  .toString(),
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
                        child: Center(
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
                              Tab(text: Languages.of(context)!.approved),
                              Tab(text: Languages.of(context)!.pendingApproval),
                              Tab(text: Languages.of(context)!.rejected),
                            ],
                          ),
                        ),
                      ),
                      widget.bloc.isShowSearchResult
                          ? widget.bloc.searchResultList.isNotEmpty
                              ? Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
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
                                  // Approved
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: buildListView(
                                        widget.bloc,
                                        widget.bloc.myReceiptsData.result
                                            ?.approved),
                                  ),
                                  // Pending ApprovaL
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: buildListView(
                                        widget.bloc,
                                        widget.bloc.myReceiptsData.result
                                            ?.newCase),
                                  ),
                                  // Rejected
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: buildListView(
                                        widget.bloc,
                                        widget.bloc.myReceiptsData.result
                                            ?.rejected),
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
    final List<Widget> widgets = [];
    for (var element in widget.bloc.filterOption) {
      widgets.add(_buildFilterWidget(element.value!, element.timeperiodText!));
    }
    return widgets;
  }

  Widget _buildFilterWidget(String option, String filterTitle) {
    return InkWell(
      onTap: () {
        switch (option) {
          case '0':
            setState(() {
              widget.bloc.selectedFilter = Constants.today;
              widget.bloc.selectedFilterIndex = '0';
            });
            widget.bloc.add(ReceiptsApiEvent(timePeiod: Constants.today));
            break;
          case '1':
            setState(() {
              widget.bloc.selectedFilter = Constants.weeklY;
              widget.bloc.selectedFilterIndex = '1';
            });
            widget.bloc.add(ReceiptsApiEvent(timePeiod: Constants.weeklY));
            break;
          case '2':
            setState(() {
              widget.bloc.selectedFilter = Constants.monthly;
              widget.bloc.selectedFilterIndex = '2';
            });
            widget.bloc.add(ReceiptsApiEvent(timePeiod: Constants.monthly));
            break;
          default:
        }
        // setState(() {
        //   widget.bloc.selectedFilter = option;
        // });
        // widget.bloc.add(ReceiptsApiEvent(timePeiod: option));
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
            color: option == widget.bloc.selectedFilterIndex
                ? ColorResource.color23375A
                : Colors.white,
          ),
          child: Center(
            child: CustomText(
              filterTitle,
              fontSize: FontSize.twelve,
              fontWeight: FontWeight.w700,
              color: option == widget.bloc.selectedFilterIndex
                  ? Colors.white
                  : ColorResource.color101010,
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildListView(DashboardBloc bloc, ReceiptCases? caseLists) {
    return bloc.selectedFilterDataLoading
        ? const CustomLoadingWidget()
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
                                      Constants.inr +
                                          caseLists.totalAmt.toString(),
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
                            }, isMyReceipts: true));
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
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              Constants.inr +
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
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (Singleton.instance.usertype ==
                                          Constants.fieldagent)
                                        caseLists.cases![index].collSubStatus ==
                                                'new'
                                            ? CaseStatusWidget.satusTextWidget(
                                                context,
                                                text:
                                                    Languages.of(context)!.new_,
                                                width: 55,
                                              )
                                            : CaseStatusWidget.satusTextWidget(
                                                context,
                                                text: caseLists.cases![index]
                                                        .collSubStatus ??
                                                    '',
                                              ),
                                      // : const SizedBox(),
                                      if (Singleton.instance.usertype ==
                                          Constants.telecaller)
                                        caseLists.cases![index].telSubStatus ==
                                                'new'
                                            ? CaseStatusWidget.satusTextWidget(
                                                context,
                                                text:
                                                    Languages.of(context)!.new_,
                                                width: 55,
                                              )
                                            : CaseStatusWidget.satusTextWidget(
                                                context,
                                                text: caseLists.cases![index]
                                                        .telSubStatus ??
                                                    '',
                                              ),
                                      // : const SizedBox(),
                                      // const Spacer(),
                                      // if (resultValue[index].collSubStatus ==
                                      //     'new')
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
                                        color: ColorResource.color101010,
                                      ),
                                      Row(
                                        children: [
                                          if (Singleton.instance.usertype ==
                                              Constants.fieldagent)
                                            CustomText(
                                              caseLists.cases![index]
                                                              .fieldfollowUpDate !=
                                                          null &&
                                                      caseLists.cases![index]
                                                              .fieldfollowUpDate !=
                                                          '-'
                                                  ? DateFormateUtils
                                                      .followUpDateFormate(
                                                          caseLists
                                                              .cases![index]
                                                              .fieldfollowUpDate!)
                                                  : '-',
                                              color: ColorResource.color101010,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          if (Singleton.instance.usertype ==
                                              Constants.telecaller)
                                            CustomText(
                                              caseLists.cases![index]
                                                              .followUpDate !=
                                                          null &&
                                                      caseLists.cases![index]
                                                              .followUpDate !=
                                                          '-'
                                                  ? DateFormateUtils
                                                      .followUpDateFormate(
                                                          caseLists
                                                              .cases![index]
                                                              .followUpDate!)
                                                  : '-',
                                              color: ColorResource.color101010,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          // CustomText(
                                          //   caseLists.cases![index]
                                          //               .followUpDate !=
                                          //           '-'
                                          //       ? DateFormateUtils
                                          //           .followUpDateFormate(
                                          //               caseLists.cases![index]
                                          //                   .followUpDate!)
                                          //       : '-',
                                          //   fontSize: FontSize.fourteen,
                                          //   color: ColorResource.color101010,
                                          //   fontWeight: FontWeight.w700,
                                          // ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              CustomText(
                                                Languages.of(context)!.view,
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
