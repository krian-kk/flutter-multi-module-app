import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/widgets/case_list_widget.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/floating_action_button.dart';

import 'bloc/priorityfollowup_bloc.dart';

class PriorityFollowUpBottomSheet extends StatefulWidget {
  final DashboardBloc bloc;
  PriorityFollowUpBottomSheet(this.bloc, {Key? key}) : super(key: key);

  @override
  _PriorityFollowUpBottomSheetState createState() =>
      _PriorityFollowUpBottomSheetState();
}

class _PriorityFollowUpBottomSheetState
    extends State<PriorityFollowUpBottomSheet> {
  late PriorityfollowupBloc bloc;
  @override
  void initState() {
    // TODO: implement initState
    bloc = PriorityfollowupBloc()..add(PriorityFollowUpInitialEvent());
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
            child: BlocListener<PriorityfollowupBloc, PriorityfollowupState>(
              bloc: bloc,
              listener: (context, state) {
                // TODO: implement listener
              },
              child: BlocBuilder<PriorityfollowupBloc, PriorityfollowupState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is PriorityfollowupLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                  return Scaffold(
                    floatingActionButton: CustomFloatingActionButton(
                      onTap: () async {
                        await Navigator.pushNamed(
                            context, AppRoutes.searchAllocationDetailsScreen);
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
                            child: Column(
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
                                              bloc.caseList.length.toString(),
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
                                Expanded(
                                    child: CaseLists.buildListView(bloc.caseList))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
