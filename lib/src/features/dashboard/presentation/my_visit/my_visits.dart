import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:domain_models/response_models/dashboard/dashboard_myvisit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/singleton.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/date_format_utils.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/case_status_widget.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/floating_action_button.dart';
import 'package:origa/widgets/no_case_available.dart';

class MyVisitsBottomSheet extends StatefulWidget {
  const MyVisitsBottomSheet(this.bloc, {Key? key}) : super(key: key);
  final DashboardBloc bloc;

  @override
  MyVisitsBottomSheetState createState() => MyVisitsBottomSheetState();
}

class MyVisitsBottomSheetState extends State<MyVisitsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      bloc: widget.bloc,
      listener: (BuildContext context, DashboardState state) {
        if (state is SelectedTimeperiodDataLoadingState) {
          widget.bloc.selectedFilterDataLoading = true;
        }

        if (state is SelectedTimeperiodDataLoadedState) {
          widget.bloc.selectedFilterDataLoading = false;
        }

        if (state is ReturnVisitsApiState) {
          setState(() {});
        }

        if (state is GetSearchDataState) {
          setState(() {
            widget.bloc.isShowSearchResult = true;
          });
          widget.bloc.selectedFilter = '';
          widget.bloc.selectedFilterIndex = '';
        }
      },
      child: Container(
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
              padding: const EdgeInsets.only(top: Sizes.p16),
              child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  backgroundColor: ColorResourceDesign.whiteTwo,
                  floatingActionButton: CustomFloatingActionButton(
                    onTap: () async {
                      widget.bloc.add(NavigateSearchEvent());
                    },
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      BottomSheetAppbar(
                        title: widget.bloc.userType == Constants.fieldagent
                            ? Languages.of(context)!.myVisits
                            : Languages.of(context)!.myCalls,
                        onTap: () {
                          widget.bloc.add(SetTimePeriodValueEvent());
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.p20, vertical: Sizes.p4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(Sizes.p4),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomText(
                                          Languages.of(context)!
                                              .count
                                              .toUpperCase(),
                                          fontSize: Sizes.p10,
                                          color: ColorResourceDesign
                                              .appTextPrimaryColor,
                                        ),
                                        CustomText(
                                          widget.bloc.myVisitsData.count
                                              .toString(),
                                          color: ColorResourceDesign
                                              .appTextPrimaryColor,
                                          fontWeight: FontResourceDesign
                                              .textFontWeightSemiBold,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomText(
                                          Languages.of(context)!
                                              .amount
                                              .toUpperCase(),
                                          fontSize: Sizes.p10,
                                          color: ColorResourceDesign
                                              .appTextPrimaryColor,
                                        ),
                                        CustomText(
                                          Constants.inr +
                                              widget.bloc.myVisitsData.totalAmt
                                                  .toString(),
                                          color: ColorResourceDesign
                                              .appTextPrimaryColor,
                                          fontWeight: FontResourceDesign
                                              .textFontWeightSemiBold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            gapH12,
                            Wrap(
                              spacing: Sizes.p6,
                              children: _buildFilterOptions(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: ColorResourceDesign.lightGrayTwo))),
                        child: TabBar(
                          isScrollable: true,
                          indicatorColor: ColorResourceDesign.redColor,
                          labelStyle: const TextStyle(
                              fontWeight:
                                  FontResourceDesign.textFontWeightSemiBold,
                              color: ColorResourceDesign.textColor,
                              fontSize: Sizes.p14,
                              fontStyle: FontStyle.normal),
                          indicatorWeight: Sizes.p5,
                          labelColor: ColorResourceDesign.textColor,
                          unselectedLabelColor: ColorResourceDesign.grayColor,
                          tabs: <Widget>[
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
                              ? const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Sizes.p20),
                                    //todo
                                    // child: SearchCaseList.buildListView(
                                    //   widget.bloc,
                                    //   resultData: widget.bloc.searchResultList,
                                    // ),
                                  ),
                                )
                              : Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: Sizes.p50,
                                            right: Sizes.p20,
                                            left: Sizes.p20),
                                        child: NoCaseAvailble
                                            .buildNoCaseAvailable(),
                                      ),
                                    ],
                                  ),
                                )
                          : Expanded(
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  // CustomerMetNotmetInvalidTab(bloc.caseList),
                                  // Customer Met
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Sizes.p20,
                                        vertical: Sizes.p4),
                                    child: buildListView(widget.bloc,
                                        widget.bloc.myVisitsData.met),
                                  ),
                                  // Customer Not Met
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Sizes.p20,
                                        vertical: Sizes.p4),
                                    child: buildListView(widget.bloc,
                                        widget.bloc.myVisitsData.notMet),
                                  ),
                                  // Invalid
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Sizes.p20,
                                        vertical: Sizes.p4),
                                    child: buildListView(widget.bloc,
                                        widget.bloc.myVisitsData.invalid),
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
      widgets.add(_buildFilterWidget(element.value!, element.timePeriodText!));
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
            widget.bloc.add(MyVisitApiEvent(timePeriod: Constants.today));
            break;
          case '1':
            setState(() {
              widget.bloc.selectedFilter = Constants.weeklY;
              widget.bloc.selectedFilterIndex = '1';
            });
            widget.bloc.add(MyVisitApiEvent(timePeriod: Constants.weeklY));
            break;
          case '2':
            setState(() {
              widget.bloc.selectedFilter = Constants.monthly;
              widget.bloc.selectedFilterIndex = '2';
            });
            widget.bloc.add(MyVisitApiEvent(timePeriod: Constants.monthly));
            break;
          default:
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.p10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.p4, vertical: Sizes.p10),
          width: 100,
          // height: 35,
          decoration: BoxDecoration(
            border:
                Border.all(color: ColorResourceDesign.lightGray, width: 0.5),
            borderRadius: BorderRadius.circular(Sizes.p10),
            color: option == widget.bloc.selectedFilterIndex
                ? ColorResourceDesign.textColor
                : Colors.white,
          ),
          child: Center(
            child: CustomText(
              filterTitle,
              fontSize: Sizes.p12,
              fontWeight: FontResourceDesign.textFontWeightSemiBold,
              color: option == widget.bloc.selectedFilterIndex
                  ? Colors.white
                  : ColorResourceDesign.appTextPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildListView(DashboardBloc bloc, Met? caseLists) {
    return bloc.selectedFilterDataLoading
        ? const CustomLoadingWidget()
        : caseLists!.cases!.isEmpty
            ? Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: Sizes.p40),
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
                    children: <Widget>[
                      if (index == 0)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              Sizes.p4, Sizes.p4, Sizes.p4, Sizes.p0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CustomText(
                                      Languages.of(context)!
                                          .count
                                          .toUpperCase(),
                                      fontSize: Sizes.p10,
                                      color: ColorResourceDesign
                                          .appTextPrimaryColor,
                                    ),
                                    CustomText(
                                      caseLists.count.toString(),
                                      color: ColorResourceDesign
                                          .appTextPrimaryColor,
                                      fontWeight: FontResourceDesign
                                          .textFontWeightSemiBold,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CustomText(
                                      Languages.of(context)!
                                          .amount
                                          .toUpperCase(),
                                      fontSize: Sizes.p10,
                                      color: ColorResourceDesign
                                          .appTextPrimaryColor,
                                    ),
                                    CustomText(
                                      Constants.inr +
                                          caseLists.totalAmt.toString(),
                                      color: ColorResourceDesign
                                          .appTextPrimaryColor,
                                      fontWeight: FontResourceDesign
                                          .textFontWeightSemiBold,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: Sizes.p20),
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
                              color: ColorResourceDesign.whiteColor,
                              border: Border.all(
                                  color: ColorResourceDesign.lightGray,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(Sizes.p10),
                              boxShadow: const <BoxShadow>[
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
                                gapH2,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Sizes.p24,
                                      vertical: Sizes.p2),
                                  child: CustomText(
                                    caseLists.cases?[index].agrRef ?? '',
                                    fontSize: Sizes.p12,
                                    fontWeight:
                                        FontResourceDesign.textFontWeightNormal,
                                    color:
                                        ColorResourceDesign.appTextPrimaryColor,
                                  ),
                                ),
                                AppUtils.showDivider(),
                                // Divider(
                                //   color: ColorResource.colorDADADA,
                                //   thickness: 0.5,
                                // ),
                                // const SizedBox(height: 6.0,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      Sizes.p24, Sizes.p0, Sizes.p10, Sizes.p0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            CustomText(
                                              Constants.inr +
                                                  caseLists.cases![index].due
                                                      .toString(),
                                              fontSize: Sizes.p18,
                                              color: ColorResourceDesign
                                                  .appTextPrimaryColor,
                                              fontWeight: FontResourceDesign
                                                  .textFontWeightSemiBold,
                                            ),
                                            gapH2,
                                            CustomText(
                                              caseLists.cases![index].cust!,
                                              fontSize: Sizes.p16,
                                              color: ColorResourceDesign
                                                  .appTextPrimaryColor,
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
                                      horizontal: Sizes.p14,
                                      vertical: Sizes.p6),
                                  child: bloc.userType == Constants.fieldagent
                                      ? Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.fromLTRB(
                                              Sizes.p20,
                                              Sizes.p12,
                                              Sizes.p14,
                                              Sizes.p12),
                                          decoration: BoxDecoration(
                                            color: ColorResourceDesign
                                                .lightWhiteGray,
                                            borderRadius: BorderRadius.circular(
                                                Sizes.p10),
                                          ),
                                          child: CustomText(
                                            caseLists.cases![index].contact![0]
                                                .value!,
                                            color: ColorResourceDesign.darkGray,
                                          ),
                                        )
                                      : Wrap(
                                          children: <Widget>[
                                            for (var item in caseLists
                                                .cases![index].contact!)
                                              item.cType!.contains('mobile') ||
                                                      item.cType!
                                                          .contains('phone')
                                                  ? Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: Sizes.p10,
                                                              right: Sizes.p20),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: Sizes.p16,
                                                          vertical: Sizes.p6),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            ColorResourceDesign
                                                                .lightWhiteGray,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    Sizes.p30),
                                                      ),
                                                      child: CustomText(
                                                        item.value!,
                                                        color:
                                                            ColorResourceDesign
                                                                .darkGray,
                                                        lineHeight: Sizes.p1,
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                          ],
                                        ),
                                ),
                                gapH4,
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Sizes.p14,
                                  ),
                                  child: Divider(
                                    color: ColorResourceDesign.lightGray,
                                    thickness: 0.5,
                                  ),
                                ),
                                //  const SizedBox(height: 5,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(Sizes.p24,
                                      Sizes.p4, Sizes.p14, Sizes.p12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CustomText(
                                        Languages.of(context)!.followUpDate,
                                        color: ColorResourceDesign
                                            .appTextPrimaryColor,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          if (Singleton.instance.usertype ==
                                              Constants.fieldagent)
                                            CustomText(
                                              caseLists.cases![index]
                                                              .fieldfollowUpDate !=
                                                          null &&
                                                      caseLists.cases![index]
                                                              .fieldfollowUpDate !=
                                                          '-'
                                                  ? DateFormatUtils
                                                      .followUpDateFormate(
                                                          caseLists
                                                              .cases![index]
                                                              .fieldfollowUpDate!)
                                                  : '-',
                                              color: ColorResourceDesign
                                                  .appTextPrimaryColor,
                                              fontWeight: FontResourceDesign
                                                  .textFontWeightSemiBold,
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
                                                  ? DateFormatUtils
                                                      .followUpDateFormate(
                                                          caseLists
                                                              .cases![index]
                                                              .followUpDate!)
                                                  : '-',
                                              color: ColorResourceDesign
                                                  .appTextPrimaryColor,
                                              fontWeight: FontResourceDesign
                                                  .textFontWeightSemiBold,
                                            ),
                                          const Spacer(),
                                          Row(
                                            children: <Widget>[
                                              CustomText(
                                                Languages.of(context)!.view,
                                                color: ColorResourceDesign
                                                    .textColor,
                                                fontWeight: FontResourceDesign
                                                    .textFontWeightSemiBold,
                                              ),
                                              gapW12,
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
