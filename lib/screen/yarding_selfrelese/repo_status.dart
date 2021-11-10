// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/my_deposists/deposistion_mode/bank_tab.dart';
import 'package:origa/screen/my_deposists/deposistion_mode/company_branch.dart';
import 'package:origa/screen/yarding_selfrelese/self_release_tab.dart';
import 'package:origa/screen/yarding_selfrelese/yarding_tab.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class RepoStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              bottomNavigationBar: Container(
                height: 66,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.13)))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 5, 20, 5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomButton(
                          Languages.of(context)!.cancel.toUpperCase(),
                          fontSize: FontSize.sixteen,
                          textColor: ColorResource.colorEA6D48,
                          fontWeight: FontWeight.w600,
                          cardShape: 5,
                          buttonBackgroundColor: ColorResource.colorffffff,
                          borderColor: ColorResource.colorffffff,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: CustomButton(
                          Languages.of(context)!.submit.toUpperCase(),
                          fontSize: FontSize.sixteen,
                          fontWeight: FontWeight.w600,
                          cardShape: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                        YardingTab(),
                        SelfReleaseTab(),
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
