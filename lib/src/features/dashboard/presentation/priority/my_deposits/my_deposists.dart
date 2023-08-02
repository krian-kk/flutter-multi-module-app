import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/src/features/dashboard/presentation/priority/my_deposits/chegue_and_cash_tab.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
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
              color: ColorResource.colorF7F8FA,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            height: MediaQuery.of(context).size.height * 0.85,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return WillPopScope(
                onWillPop: () async => true,
                child: Container(
                  padding: const EdgeInsets.only(top: 16),
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
                                                Languages.of(context)!.count,
                                                fontSize: FontSize.ten,
                                                color:
                                                    ColorResource.color101010,
                                              ),
                                              CustomText(
                                                widget.bloc.myDepositsData.count
                                                    .toString(),
                                                color:
                                                    ColorResource.color101010,
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
                                                Languages.of(context)!.amount,
                                                fontSize: FontSize.ten,
                                                color:
                                                    ColorResource.color101010,
                                              ),
                                              CustomText(
                                                Constants.inr +
                                                    widget.bloc.myDepositsData
                                                        .totalAmt
                                                        .toString(),
                                                color:
                                                    ColorResource.color101010,
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
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: ColorResource.colorD8D8D8))),
                              child: TabBar(
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
                                              padding: const EdgeInsets.all(20),
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
                                              padding: const EdgeInsets.all(20),
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
}
