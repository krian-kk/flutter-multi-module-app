import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/widgets/case_list_widget.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/floating_action_button.dart';

class MyReceiptsBottomSheet extends StatefulWidget {

  final DashboardBloc bloc;
  const MyReceiptsBottomSheet(this.bloc, {Key? key}) : super(key: key);

  @override
  _MyReceiptsBottomSheetState createState() => _MyReceiptsBottomSheetState();
}

class _MyReceiptsBottomSheetState extends State<MyReceiptsBottomSheet> {
  // late MyreceiptsBloc bloc;

  // String? selectedFilter;

  //  List<String> filterOption = [];
   
  @override
  void initState() {
    // TODO: implement initState
    
    // bloc = MyreceiptsBloc()..add(MyreceiptsInitialEvent(context));
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
                padding: EdgeInsets.only(top: 16),
                child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    floatingActionButton: CustomFloatingActionButton(
                      onTap: () async {
                        await Navigator.pushNamed(
                            context, AppRoutes.searchAllocationDetailsScreen);
                      },
                    ),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        BottomSheetAppbar(
                          title: Languages.of(context)!.myReceipts,
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
                                            '200',
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
                                            '₹ 3,97,553.67',
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
                              Tab(text: Languages.of(context)!.customerMet),
                              Tab(
                                  text:
                                      Languages.of(context)!.customerNotMet),
                              Tab(text: Languages.of(context)!.invalid)
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                child: CaseLists.buildListView(widget.bloc),
                              ),
                              // CustomerMetNotmetInvalidTab(bloc.caseList),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                child: CaseLists.buildListView(widget.bloc),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                child: CaseLists.buildListView(widget.bloc),
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
    );
  }

  List<Widget> _buildFilterOptions() {
    List<Widget> widgets = [];
    widget.bloc.filterOption.forEach((element) {
      widgets.add(_buildFilterWidget(element));
    });
    return widgets;
  }

  Widget _buildFilterWidget(String option) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.bloc.selectedFilter = option;
        });
        // switch (option) {
        //   case 'WEEKLY':
        //     break;
        //   case 'MONTHLY':
        //     break;
        //   default:
        // }
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
}
