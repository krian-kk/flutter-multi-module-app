import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/dashboard_mydeposists_model/result.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/widgets/case_list_widget.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

import '../../router.dart';
import 'deposistion_mode/deposistion_mode.dart';

class SelectedValue {
  String caseId;
  bool isSelected;
  SelectedValue(this.caseId, this.isSelected);
}

class ChegueAndCasshResults extends StatefulWidget {
  final DashboardBloc bloc;
  final String? mode;
  final DashboardMyDeposistsResult? result;
  ChegueAndCasshResults(this.bloc, {this.mode, this.result});

  @override
  _ChegueAndCasshResultsState createState() => _ChegueAndCasshResultsState();
}

class _ChegueAndCasshResultsState extends State<ChegueAndCasshResults> {
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.bloc.caseList.length; i++) {
      selectedValue
          .add(SelectedValue(widget.bloc.caseList[i].loanID.toString(), false));
    }
  }

  int? _selectedIndex;
  List<String> caseIDs = [];
  String? custName;
  List<SelectedValue> selectedValue = [];

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Scaffold(
        bottomNavigationBar: Container(
          height: 65,
          color: ColorResource.colorFFFFFF,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(13, 5, 20, 0),
            child: CustomButton(
              Languages.of(context)!.enterDepositionDetails,
              fontSize: FontSize.sixteen,
              fontWeight: FontWeight.w600,
              onTap: () {
                if (_selectedIndex != null) {
                  depositionModeSheet(context);
                } else {
                  AppUtils.showToast(
                    Constants.notSelectedCase,
                    gravity: ToastGravity.CENTER,
                  );
                }
              },
            ),
          ),
        ),
        body: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    // widget.result!.cash!.cases!.length,
                    itemCount: widget.bloc.caseList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0)
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
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
                                          widget.bloc.caseList.length
                                              .toString(),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: ColorResource.colorffffff,
                                border: Border.all(
                                    color: ColorResource.colorDADADA,
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    // spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 2.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 2),
                                        child: CustomText(
                                          Languages.of(context)!
                                              .loanAccountNumber,
                                          fontSize: FontSize.twelve,
                                          color: ColorResource.color101010,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 2),
                                        child: CustomText(
                                          widget.bloc.caseList[index].loanID!,
                                          fontSize: FontSize.fourteen,
                                          color: ColorResource.color101010,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: ColorResource.colorDADADA,
                                    thickness: 0.5,
                                  ),
                                  // const SizedBox(height: 6.0,),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(23, 0, 10, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          widget.bloc.caseList[index].amount!,
                                          fontSize: FontSize.eighteen,
                                          color: ColorResource.color101010,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        CustomText(
                                          widget.bloc.caseList[index]
                                              .customerName!,
                                          fontSize: FontSize.sixteen,
                                          color: ColorResource.color101010,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 6),
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 12, 15, 12),
                                      decoration: BoxDecoration(
                                        color: ColorResource.colorF8F9FB,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: CustomText(
                                        widget.bloc.caseList[index].address!,
                                        color: ColorResource.color484848,
                                        fontSize: FontSize.fourteen,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Divider(
                                      color: ColorResource.colorDADADA,
                                      thickness: 0.5,
                                    ),
                                  ),
                                  //  const SizedBox(height: 5,),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(23, 5, 14, 13),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              Languages.of(context)!
                                                  .receiptDate,
                                              fontSize: FontSize.fourteen,
                                              color: ColorResource.color101010,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            CustomText(
                                              widget.bloc.caseList[index].date!,
                                              fontSize: FontSize.fourteen,
                                              color: ColorResource.color101010,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: 123,
                                          height: 47,
                                          child: CustomButton(
                                            Languages.of(context)!
                                                .selected
                                                .toUpperCase(),
                                            fontSize: FontSize.twelve,
                                            buttonBackgroundColor:
                                                !selectedValue[index].isSelected
                                                    ? ColorResource.colorFEFFFF
                                                    : ColorResource.colorEA6D48,
                                            borderColor:
                                                !selectedValue[index].isSelected
                                                    ? ColorResource.colorFEFFFF
                                                    : ColorResource.colorEA6D48,
                                            textColor:
                                                !selectedValue[index].isSelected
                                                    ? ColorResource.color23375A
                                                    : ColorResource.colorFFFFFF,
                                            cardElevation: 3.0,
                                            onTap: () {
                                              _onSelected(index);
                                              setState(() {
                                                selectedValue[index]
                                                        .isSelected =
                                                    !selectedValue[index]
                                                        .isSelected;
                                                custName = widget
                                                    .bloc
                                                    .caseList[index]
                                                    .customerName;
                                              });
                                              caseIDs.clear();
                                              selectedValue.forEach((element) {
                                                if (element.isSelected) {
                                                  caseIDs.add(element.caseId);
                                                }
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            )
          ],
        ),
      );
    });
  }

  void depositionModeSheet(BuildContext buildContext) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                DepositionMode.buildDepositionMode(context, caseIDs,
                    widget.mode.toString(), widget.bloc, custName)));
  }
}
