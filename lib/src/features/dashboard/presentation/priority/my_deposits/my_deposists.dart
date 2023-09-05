import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/src/features/dashboard/presentation/priority/my_deposits/chegue_and_cash_tab.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/no_case_available.dart';

class MyDepositsBottomSheet extends StatefulWidget {
  const MyDepositsBottomSheet(this.bloc, {Key? key}) : super(key: key);
  final DashboardBloc bloc;

  @override
  MyDepositsBottomSheetState createState() => MyDepositsBottomSheetState();
}

class MyDepositsBottomSheetState extends State<MyDepositsBottomSheet> {
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
      },
      child: BlocBuilder<DashboardBloc, DashboardState>(
        bloc: widget.bloc,
        builder: (context, state) {
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
                  padding: const EdgeInsets.only(top: Sizes.p16),
                  child: DefaultTabController(
                    length: 2,
                    child: SafeArea(
                      child: Scaffold(
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BottomSheetAppbar(
                              title: Languages.of(context)!.myDeposists,
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
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(Sizes.p4),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                Languages.of(context)!.count,
                                                fontSize: Sizes.p10,
                                                color: ColorResourceDesign
                                                    .appTextPrimaryColor,
                                              ),
                                              CustomText(
                                                widget.bloc.myDepositsData.count
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
                                            children: [
                                              CustomText(
                                                Languages.of(context)!.amount,
                                                fontSize: Sizes.p10,
                                                color: ColorResourceDesign
                                                    .appTextPrimaryColor,
                                              ),
                                              CustomText(
                                                Constants.inr +
                                                    widget.bloc.myDepositsData
                                                        .totalAmt
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
                                    spacing: 7,
                                    children: _buildFilterOptions(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: ColorResourceDesign
                                              .lightGrayTwo))),
                              child: TabBar(
                                indicatorColor: ColorResourceDesign.redColor,
                                labelStyle: const TextStyle(
                                    fontWeight: FontResourceDesign
                                        .textFontWeightSemiBold,
                                    color: ColorResourceDesign.textColor,
                                    fontSize: Sizes.p14,
                                    fontStyle: FontStyle.normal),
                                indicatorWeight: Sizes.p5,
                                labelColor: ColorResourceDesign.textColor,
                                unselectedLabelColor:
                                    ColorResourceDesign.grayColor,
                                tabs: [
                                  Tab(text: Languages.of(context)!.cheque),
                                  Tab(text: Languages.of(context)!.cash)
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  // Cheque Tab
                                  widget.bloc.selectedFilterDataLoading
                                      ? const CustomLoadingWidget()
                                      : widget.bloc.myDepositsData.cheque
                                                  ?.count ==
                                              0
                                          ? Center(
                                              child: Padding(
                                              padding: const EdgeInsets.all(
                                                  Sizes.p20),
                                              child: NoCaseAvailble
                                                  .buildNoCaseAvailable(),
                                            ))
                                          : ChequeAndCashResults(widget.bloc,
                                              result: widget
                                                  .bloc.myDepositsData.cheque),
                                  // Cash Tab
                                  widget.bloc.selectedFilterDataLoading
                                      ? const CustomLoadingWidget()
                                      : widget.bloc.myDepositsData.cash
                                                  ?.count ==
                                              0
                                          ? Center(
                                              child: Padding(
                                              padding: const EdgeInsets.all(
                                                  Sizes.p20),
                                              child: NoCaseAvailble
                                                  .buildNoCaseAvailable(),
                                            ))
                                          : ChequeAndCashResults(widget.bloc,
                                              // mode: "CASH",
                                              result: widget
                                                  .bloc.myDepositsData.cash),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
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
        // setState(() {
        //   widget.bloc.selectedFilter = option;
        // });
        switch (option) {
          case '0':
            setState(() {
              widget.bloc.selectedFilter = Constants.today;
              widget.bloc.selectedFilterIndex = '0';
            });
            widget.bloc.add(DepositsApiEvent(timePeriod: Constants.today));
            break;
          case '1':
            setState(() {
              widget.bloc.selectedFilter = Constants.weeklY;
              widget.bloc.selectedFilterIndex = '1';
            });
            widget.bloc.add(DepositsApiEvent(timePeriod: Constants.weeklY));
            break;
          case '2':
            setState(() {
              widget.bloc.selectedFilter = Constants.monthly;
              widget.bloc.selectedFilterIndex = '2';
            });
            widget.bloc.add(DepositsApiEvent(timePeriod: Constants.monthly));
            break;
          default:
        }
        // widget.bloc.add(DeposistsApiEvent(timePeiod: option));
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
                : ColorResourceDesign.whiteColor,
          ),
          child: Center(
            child: CustomText(
              filterTitle,
              fontSize: Sizes.p12,
              fontWeight: FontResourceDesign.textFontWeightSemiBold,
              color: option == widget.bloc.selectedFilterIndex
                  ? ColorResourceDesign.whiteColor
                  : ColorResourceDesign.appTextPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
