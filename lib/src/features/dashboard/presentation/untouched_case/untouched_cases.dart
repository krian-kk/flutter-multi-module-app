import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/case_list_widget.dart';
import 'package:origa/widgets/floating_action_button.dart';
import 'package:origa/widgets/no_case_available.dart';

class UntouchedCasesBottomSheet extends StatefulWidget {
  const UntouchedCasesBottomSheet(this.bloc, {Key? key}) : super(key: key);
  final DashboardBloc bloc;

  @override
  UntouchedCasesBottomSheetState createState() =>
      UntouchedCasesBottomSheetState();
}

class UntouchedCasesBottomSheetState extends State<UntouchedCasesBottomSheet> {
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
        if (state is GetSearchDataState) {
          setState(() {
            widget.bloc.isShowSearchResult = true;
          });
        }
        if (state is UpdateSuccessfulState) {
          setState(() {});
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
              child: Scaffold(
                backgroundColor: ColorResourceDesign.whiteTwo,
                floatingActionButton: CustomFloatingActionButton(
                  onTap: () async {
                    widget.bloc.add(NavigateSearchEvent());
                  },
                ),
                body: Column(
                  children: [
                    BottomSheetAppbar(
                        title: Languages.of(context)!.untouchedCases),
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
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: Sizes.p50,
                                          right: Sizes.p20,
                                          left: Sizes.p20),
                                      child:
                                          NoCaseAvailble.buildNoCaseAvailable(),
                                    ),
                                  ],
                                ),
                              )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.p20, vertical: Sizes.p4),
                              child: CaseLists.buildListView(
                                widget.bloc,
                                widget.bloc.untouchedCasesData,
                                untouchedCases: true,
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
