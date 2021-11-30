import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/widgets/case_list_widget.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/floating_action_button.dart';

class PriorityFollowUpBottomSheet extends StatefulWidget {
  final DashboardBloc bloc;
  const PriorityFollowUpBottomSheet(this.bloc, {Key? key}) : super(key: key);

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
            child: Scaffold(
              floatingActionButton: CustomFloatingActionButton(
                onTap: () async {
                  widget.bloc.add(NavigateSearchEvent());
                },
              ),
              body: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  BottomSheetAppbar(
                    title: Languages.of(context)!.priorityFollowUp,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: CaseLists.buildListView(widget.bloc),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
