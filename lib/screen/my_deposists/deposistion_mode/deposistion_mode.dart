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
                    title: Languages.of(context)!.depositionMode,
                  ),
                  const SizedBox(height: 7),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: ColorResource.colorD8D8D8))),
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor: ColorResource.colorD5344C,
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color23375A,
                          fontSize: FontSize.fourteen,
                          fontStyle: FontStyle.normal),
                      indicatorWeight: 5.0,
                      labelColor: ColorResource.color23375A,
                      unselectedLabelColor: ColorResource.colorC4C4C4,
                      tabs: [
                        SizedBox(
                          width: 80,
                          child: Tab(text: Languages.of(context)!.bank),
                        ),
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
                          selectedCaseIds: _ids,
                          mode: 'Bank',
                          custname: custName,
                          receiptAmt: receiptAmount,
                        ),
                        CompanyBranch(
                          bloc,
                          selectedCaseIds: _ids,
                          mode: 'Company Branch',
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
