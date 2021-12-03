import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/widgets/case_list_widget.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/floating_action_button.dart';

class UntouchedCasesBottomSheet extends StatefulWidget {
  final DashboardBloc bloc;
  UntouchedCasesBottomSheet(this.bloc, {Key? key}) : super(key: key);

  @override
  _UntouchedCasesBottomSheetState createState() =>
      _UntouchedCasesBottomSheetState();
}

class _UntouchedCasesBottomSheetState extends State<UntouchedCasesBottomSheet> {
  // late UntouchedcasesBloc bloc;
  @override
  void initState() {
    // TODO: implement initState
    // bloc = UntouchedcasesBloc()..add(UntouchedcasesInitialEvent());
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
                    title: Languages.of(context)!.untouchedCases,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: CaseLists.buildListView(widget.bloc,widget.bloc.untouchedCasesData),
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
