import 'package:domain_models/response_models/dashboard/dashboard_mydeposists_model/dashboard_mydeposists_model.dart';
import 'package:flutter/material.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/src/features/dashboard/presentation/priority/my_deposits/deposistion_mode/deposistion_mode.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/date_format_utils.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class SelectedValue {
  SelectedValue(this._id, this.isSelected);

  final String _id;
  bool isSelected;
}

class ChequeAndCashResults extends StatefulWidget {
  const ChequeAndCashResults(
    this.bloc, {
    Key? key,
    // this.mode,
    this.result,
  }) : super(key: key);
  final DashboardBloc bloc;
  final Cheque? result;

  @override
  ChequeAndCashResultsState createState() => ChequeAndCashResultsState();
}

class ChequeAndCashResultsState extends State<ChequeAndCashResults> {
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.result!.cases!.length; i++) {
      selectedValue
          .add(SelectedValue(widget.result!.cases![i].sId.toString(), false));
    }
  }

  // int? _selectedIndex;
  List<String> ids = [];
  String? custName;
  List<SelectedValue> selectedValue = [];

  double receiptAmount = 0.0;

  _onSelected(int index) {
    setState(() {
      // _selectedIndex = index;
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
              onTap: () {
                if (ids.isNotEmpty) {
                  depositionModeSheet(context);
                } else {
                  AppUtils.showToast(
                      Languages.of(context)!
                          .notSelectedCase
                          .replaceAll('case', 'receipt'),
                      backgroundColor: Colors.red);
                }
              },
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ListView.builder(
                    // widget.result!.cash!.cases!.length,
                    itemCount: widget.result!.cases!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0)
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
                              child: Row(
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
                                          widget.result!.count!.toString(),
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
                                          Constants.inr +
                                              widget.result!.totalAmt!
                                                  .toString(),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 2),
                                        child: CustomText(
                                          Languages.of(context)!
                                              .loanAccountNumber,
                                          fontSize: FontSize.twelve,
                                          color: ColorResource.color101010,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 2),
                                        child: CustomText(
                                          widget.result!.cases![index].agrRef ??
                                              '',
                                          color: ColorResource.color101010,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: ColorResource.colorDADADA,
                                    thickness: 0.5,
                                  ),
                                  // const SizedBox(height: 6.0,),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(23, 0, 10, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          Constants.inr +
                                              widget.result!.cases![index]
                                                  .eventAttr!.amountCollected
                                                  .toString(),
                                          fontSize: FontSize.eighteen,
                                          color: ColorResource.color101010,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        CustomText(
                                          widget.result!.cases![index]
                                                  .eventAttr!.customerName ??
                                              '',
                                          fontSize: FontSize.sixteen,
                                          color: ColorResource.color101010,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 15, vertical: 6),
                                  //   child: Container(
                                  //     padding: const EdgeInsets.fromLTRB(
                                  //         20, 12, 15, 12),
                                  //     decoration: BoxDecoration(
                                  //       color: ColorResource.colorF8F9FB,
                                  //       borderRadius: BorderRadius.circular(10),
                                  //     ),
                                  //     child: CustomText(
                                  //       widget.result!.cases![index].address![0]
                                  //           .value!
                                  //           .toString(),
                                  //       color: ColorResource.color484848,
                                  //       fontSize: FontSize.fourteen,
                                  //     ),
                                  //   ),
                                  // ),
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
                                    padding: const EdgeInsets.fromLTRB(
                                        23, 5, 14, 13),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                Languages.of(context)!
                                                    .receiptDate,
                                                color:
                                                    ColorResource.color101010,
                                              ),
                                              CustomText(
                                                widget.result!.cases![index]
                                                            .eventAttr!.date !=
                                                        null
                                                    ? DateFormatUtils
                                                        .followUpDateFormate(
                                                            widget
                                                                .result!
                                                                .cases![index]
                                                                .eventAttr!
                                                                .date!)
                                                    : '-',
                                                color:
                                                    ColorResource.color101010,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // const Spacer(),
                                        Expanded(
                                          child: SizedBox(
                                            // width: 123,
                                            height: 53,
                                            child: CustomButton(
                                              selectedValue[index].isSelected
                                                  ? Languages.of(context)!
                                                      .selected
                                                      .toUpperCase()
                                                  : Languages.of(context)!
                                                      .select
                                                      .toUpperCase(),
                                              fontSize: FontSize.twelve,
                                              padding: 3,
                                              buttonBackgroundColor:
                                                  !selectedValue[index]
                                                          .isSelected
                                                      ? ColorResource
                                                          .colorFEFFFF
                                                      : ColorResource
                                                          .colorEA6D48,
                                              borderColor: !selectedValue[index]
                                                      .isSelected
                                                  ? ColorResource.colorFEFFFF
                                                  : ColorResource.colorEA6D48,
                                              textColor: !selectedValue[index]
                                                      .isSelected
                                                  ? ColorResource.color23375A
                                                  : ColorResource.colorFFFFFF,
                                              cardElevation: 3.0,
                                              onTap: () {
                                                _onSelected(index);
                                                setState(() {
                                                  // widget.result!.cases!
                                                  //     .removeAt(index);

                                                  selectedValue[index]
                                                          .isSelected =
                                                      !selectedValue[index]
                                                          .isSelected;
                                                  custName = widget
                                                          .result!
                                                          .cases![index]
                                                          .eventAttr!
                                                          .customerName ??
                                                      '';
                                                  if (!selectedValue[index]
                                                      .isSelected) {
                                                    receiptAmount =
                                                        receiptAmount -
                                                            double.parse(widget
                                                                .result!
                                                                .cases![index]
                                                                .eventAttr!
                                                                .amountCollected
                                                                .toString());

                                                    // widget.bloc.listOfIndex
                                                    //     .removeAt(index);
                                                  } else {
                                                    receiptAmount =
                                                        receiptAmount +
                                                            double.parse(widget
                                                                .result!
                                                                .cases![index]
                                                                .eventAttr!
                                                                .amountCollected
                                                                .toString());

                                                    // widget.bloc.listOfIndex
                                                    //     .add(index);
                                                  }
                                                });
                                                ids.clear();

                                                for (var element
                                                    in selectedValue) {
                                                  if (element.isSelected) {
                                                    ids.add(element._id);
                                                  }
                                                }
                                              },
                                            ),
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
                DepositionMode.buildDepositionMode(
                    context, ids, widget.bloc, custName, receiptAmount)));
  }
}
