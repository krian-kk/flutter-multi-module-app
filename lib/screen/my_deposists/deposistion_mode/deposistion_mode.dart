// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/my_deposists/deposistion_mode/bank_tab.dart';
import 'package:origa/screen/my_deposists/deposistion_mode/company_branch.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';

class DepositionMode {
  static Widget buildDepositionMode(BuildContext context, List<String> _ids,
      DashboardBloc bloc, String? custName, double receiptAmount) {
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
                    title: Languages.of(context)!.depositionMode,
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
                        Tab(text: Languages.of(context)!.bank),
                        Tab(text: Languages.of(context)!.companybranch),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        BankTab(
                          bloc,
                          selected_case_Ids: _ids,
                          mode: "Bank",
                          custname: custName,
                          receiptAmt: receiptAmount,
                        ),
                        CompanyBranch(
                          bloc,
                          selected_case_Ids: _ids,
                          mode: "Company Branch",
                          custname: custName,
                          receiptAmt: receiptAmount,
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
