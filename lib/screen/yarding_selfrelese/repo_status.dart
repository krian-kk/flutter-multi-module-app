// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/yarding_selfrelese/self_release_tab.dart';
import 'package:origa/screen/yarding_selfrelese/yarding_tab.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';

class RepoStatus {
  static Widget buildRepoSelfReleaseTab(BuildContext context, String? caseID,
      String? custName, DashboardBloc bloc) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.83,
      child: Container(
        padding: EdgeInsets.only(top: 16),
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
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  BottomSheetAppbar(
                    title: Languages.of(context)!.repoStatus,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    // width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: ColorResource.colorD8D8D8))),
                    child: TabBar(
                      isScrollable: false,
                      indicatorColor: ColorResource.colorD5344C,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color23375A,
                          fontSize: FontSize.fourteen,
                          fontStyle: FontStyle.normal),
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
                          caseId: caseID,
                          custname: custName,
                        ),
                        SelfReleaseTab(
                          bloc,
                          caseId: caseID,
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
