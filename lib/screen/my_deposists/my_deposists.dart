import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/no_case_available.dart';

import 'chegue_and_cash_tab.dart';

class MyDeposistsBottomSheet extends StatefulWidget {
  final DashboardBloc bloc;
  const MyDeposistsBottomSheet(this.bloc, {Key? key}) : super(key: key);

  @override
  _MyDeposistsBottomSheetState createState() => _MyDeposistsBottomSheetState();
}

class _MyDeposistsBottomSheetState extends State<MyDeposistsBottomSheet> {
  // late MydeposistsBloc bloc;

  @override
  void initState() {
    // bloc = MydeposistsBloc()..add(MydeposistsInitialEvent());
    super.initState();
  }
  //   int? _selectedIndex;

  // _onSelected(int index) {
  //   setState(() => _selectedIndex = index);
  // }

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
                        // bottomNavigationBar: Container(
                        //   height: 66,
                        //   color: ColorResource.colorFFFFFF,
                        //   child: Padding(
                        //     padding: const EdgeInsets.fromLTRB(13, 5, 20, 0),
                        //     child: CustomButton(
                        //       Languages.of(context)!.enterDepositionDetails,
                        //       fontSize: FontSize.sixteen,
                        //       fontWeight: FontWeight.w600,
                        //       onTap: () {
                        //         depositionModeSheet(context);
                        //       },
                        //     ),
                        //   ),
                        // ),
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            BottomSheetAppbar(
                              title: Languages.of(context)!.myDeposists,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                widget.bloc.myDeposistsData
                                                    .result!.count
                                                    .toString(),
                                                fontSize: FontSize.fourteen,
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
                                                widget.bloc.myDeposistsData
                                                    .result!.totalAmt
                                                    .toString(),
                                                fontSize: FontSize.fourteen,
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
                                    runSpacing: 0,
                                    spacing: 7,
                                    children: _buildFilterOptions(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: ColorResource.colorD8D8D8))),
                              child: TabBar(
                                isScrollable: false,
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
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : widget.bloc.myDeposistsData.result!
                                                  .cheque!.count ==
                                              0
                                          ? Center(
                                              child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: NoCaseAvailble
                                                  .buildNoCaseAvailable(),
                                            ))
                                          : ChegueAndCasshResults(widget.bloc,
                                              // mode: "CHEQUE",
                                              result: widget
                                                  .bloc
                                                  .myDeposistsData
                                                  .result!
                                                  .cheque),
                                  // Cash Tab
                                  widget.bloc.selectedFilterDataLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : widget.bloc.myDeposistsData.result!
                                                  .cash!.count ==
                                              0
                                          ? Center(
                                              child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: NoCaseAvailble
                                                  .buildNoCaseAvailable(),
                                            ))
                                          : ChegueAndCasshResults(widget.bloc,
                                              // mode: "CASH",
                                              result: widget
                                                  .bloc
                                                  .myDeposistsData
                                                  .result!
                                                  .cash),
                                  // StatefulBuilder(
                                  //     builder: (BuildContext context, StateSetter setState) {
                                  //     return  CashResults.buildListCashAndChegue(widget.bloc, setState);
                                  //   }
                                  // ),
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
        widget.bloc.add(DeposistsApiEvent(timePeiod: option));
        print(option);
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

  // void depositionModeSheet(BuildContext buildContext) {
  //   showModalBottomSheet(
  //       context: context,
  //       isDismissible: false,
  //       isScrollControlled: true,
  //       backgroundColor: ColorResource.colorFFFFFF,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(20),
  //         ),
  //       ),
  //       clipBehavior: Clip.antiAliasWithSaveLayer,
  //       builder: (BuildContext context) => StatefulBuilder(
  //           builder: (BuildContext buildContext, StateSetter setState) =>
  //               DepositionMode()));
  // }
}
