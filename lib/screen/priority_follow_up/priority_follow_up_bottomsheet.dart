import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/search_screen/search_list.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/case_list_widget.dart';
import 'package:origa/widgets/floating_action_button.dart';
import 'package:origa/widgets/no_case_available.dart';

class PriorityFollowUpBottomSheet extends StatefulWidget {
  const PriorityFollowUpBottomSheet(this.bloc, {Key? key}) : super(key: key);
  final DashboardBloc bloc;

  @override
  _PriorityFollowUpBottomSheetState createState() =>
      _PriorityFollowUpBottomSheetState();
}

class _PriorityFollowUpBottomSheetState
    extends State<PriorityFollowUpBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      bloc: widget.bloc,
      listener: (context, state) async {
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
                      title: Languages.of(context)!.priorityFollowUp,
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
                                widget.bloc.priortyFollowUpData,
                                isPriorityFollowUp: true,
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
