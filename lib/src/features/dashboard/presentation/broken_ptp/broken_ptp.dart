import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/search_screen/search_list.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/case_list_widget.dart';
import 'package:origa/widgets/floating_action_button.dart';
import 'package:origa/widgets/no_case_available.dart';

class BrokenPTPBottomSheet extends StatefulWidget {
  const BrokenPTPBottomSheet(this.bloc, {Key? key}) : super(key: key);
  final DashboardBloc bloc;

  @override
  _BrokenPTPBottomSheetState createState() => _BrokenPTPBottomSheetState();
}

class _BrokenPTPBottomSheetState extends State<BrokenPTPBottomSheet> {
  // late BrokenptpBloc bloc;

  @override
  void initState() {
    // bloc = BrokenptpBloc()..add(BrokenptpInitialEvent());
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
      child: BlocListener<DashboardBloc, DashboardState>(
        bloc: widget.bloc,
        listener: (context, state) {
          if (state is SelectedTimeperiodDataLoadingState) {
            widget.bloc.selectedFilterDataLoading = true;
          }

          if (state is SelectedTimeperiodDataLoadedState) {
            widget.bloc.selectedFilterDataLoading = false;
          }

          if (state is GetSearchDataState) {
            setState(() {
              widget.bloc.isShowSearchResult = true;
            });
          }
        },
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return WillPopScope(
            onWillPop: () async => true,
            child: Container(
              padding: const EdgeInsets.only(top: 16),
              child: Scaffold(
                backgroundColor: ColorResource.colorF7F8FA,
                floatingActionButton: CustomFloatingActionButton(
                  onTap: () async {
                    widget.bloc.add(NavigateSearchEvent());
                  },
                ),
                body: Column(
                  children: [
                    BottomSheetAppbar(
                      title: Languages.of(context)!.brokenPTP,
                    ),
                    widget.bloc.isShowSearchResult
                        ? widget.bloc.searchResultList.isNotEmpty
                            ? const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  //todo
                                  // child: SearchCaseList.buildListView(
                                  //   widget.bloc,
                                  //   resultData: widget.bloc.searchResultList,
                                  // ),
                                ),
                              )
                            : Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 50, right: 20, left: 20),
                                      child:
                                          NoCaseAvailble.buildNoCaseAvailable(),
                                    ),
                                  ],
                                ),
                              )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: CaseLists.buildListView(
                                widget.bloc,
                                widget.bloc.brokenPTPData,
                                brokenPTP: true,
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
