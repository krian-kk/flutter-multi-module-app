import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/src/features/dashboard/presentation/yarding_selfrelese/self_release_tab.dart';
import 'package:origa/src/features/dashboard/presentation/yarding_selfrelese/yarding_tab.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';

class RepoStatus {
  static Widget buildRepoSelfReleaseTab(
      BuildContext context, String? _id, String? custName, DashboardBloc bloc) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.83,
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        child: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Scaffold(
              // floatingActionButton: CustomFloatingActionButton(
              //   onTap: () async {
              //     await Navigator.pushNamed(
              //         context, AppRoutes.searchAllocationDetailsScreen);
              //   },
              // ),
              backgroundColor: ColorResource.colorFFFFFF,

              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BottomSheetAppbar(
                    title: Languages.of(context)!.repoStatus,
                  ),
                  const SizedBox(height: 7),
                  Container(
                    // width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: ColorResource.colorD8D8D8))),
                    child: TabBar(
                      indicatorColor: ColorResource.colorD5344C,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ColorResource.color23375A,
                        fontSize: FontSize.fourteen,
                        fontStyle: FontStyle.normal,
                      ),
                      indicatorWeight: 5.0,
                      labelColor: ColorResource.color23375A,
                      unselectedLabelColor: ColorResource.colorC4C4C4,
                      tabs: [
                        Tab(text: Languages.of(context)!.yarding),
                        Tab(text: Languages.of(context)!.selfRelease),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        YardingTab(
                          bloc,
                          id: _id,
                          custname: custName,
                        ),
                        SelfReleaseTab(
                          bloc,
                          id: _id,
                          custname: custName,
                        ),
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
  }
}
