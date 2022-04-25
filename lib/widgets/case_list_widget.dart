import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/dashboard_all_models/address.dart';
import 'package:origa/models/dashboard_all_models/dashboard_all_models.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/date_formate_utils.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/no_case_available.dart';

import 'case_status_widget.dart';

class CaseLists {
  static Widget buildListView(
    DashboardBloc bloc,
    DashboardAllModels listData, {
    bool untouchedCases = false,
    bool isPriorityFollowUp = false,
    bool brokenPTP = false,
  }) {
    return bloc.selectedFilterDataLoading
        ? const CustomLoadingWidget()
        : listData.result == null || listData.result!.cases!.isEmpty
            ? Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: NoCaseAvailble.buildNoCaseAvailable(),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: listData.result!.cases!.length,
                // itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  // int listCount = index + 1;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (index == 0)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CustomText(
                                      Languages.of(context)!
                                          .count
                                          .toUpperCase(),
                                      fontSize: FontSize.ten,
                                      color: ColorResource.color101010,
                                    ),
                                    CustomText(
                                      listData.result!.count.toString(),
                                      color: ColorResource.color101010,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CustomText(
                                      Languages.of(context)!
                                          .amount
                                          .toUpperCase(),
                                      fontSize: FontSize.ten,
                                      color: ColorResource.color101010,
                                    ),
                                    CustomText(
                                      Constants.inr +
                                          listData.result!.totalAmt.toString(),
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
                        child: InkWell(
                          onTap: () {
                            bloc.add(NavigateCaseDetailEvent(
                              paramValues: <String, dynamic>{
                                'caseID': listData.result!.cases![index].caseId,
                              },
                              isUnTouched: untouchedCases,
                              isPriorityFollowUp: isPriorityFollowUp,
                            ));
                            Singleton.instance.agrRef =
                                listData.result!.cases![index].agrRef ?? '';
                          },
                          child: Container(
                            margin:
                                (index == listData.result!.cases!.length - 1)
                                    ? const EdgeInsets.only(bottom: 70)
                                    : EdgeInsets.zero,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: ColorResource.colorffffff,
                              border: Border.all(
                                  color: ColorResource.colorDADADA, width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const <BoxShadow>[
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
                              children: <Widget>[
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 2),
                                  child: CustomText(
                                    listData.result!.cases![index].bankName! +
                                        ' / ' +
                                        listData.result!.cases![index].agrRef!,
                                    fontSize: FontSize.twelve,
                                    fontWeight: FontWeight.w500,
                                    color: ColorResource.color101010,
                                  ),
                                ),
                                AppUtils.showDivider(),
                                // Divider(
                                //   color: ColorResource.colorDADADA,
                                //   thickness: 0.5,
                                // ),
                                // const SizedBox(height: 6.0,),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 0, 10, 0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            CustomText(
                                              Constants.inr +
                                                  listData
                                                      .result!.cases![index].due
                                                      .toString(),
                                              fontSize: FontSize.eighteen,
                                              color: ColorResource.color101010,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            const SizedBox(
                                              height: 3.0,
                                            ),
                                            CustomText(
                                              listData
                                                  .result!.cases![index].cust!,
                                              fontSize: FontSize.sixteen,
                                              color: ColorResource.color101010,
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (Singleton.instance.usertype ==
                                          Constants.fieldagent)
                                        listData.result!.cases![index]
                                                    .collSubStatus ==
                                                'new'
                                            ? CaseStatusWidget.satusTextWidget(
                                                context,
                                                text:
                                                    Languages.of(context)!.new_,
                                                width: 55,
                                              )
                                            : CaseStatusWidget.satusTextWidget(
                                                context,
                                                text: listData
                                                        .result!
                                                        .cases![index]
                                                        .collSubStatus ??
                                                    '',
                                              ),
                                      // : const SizedBox(),
                                      if (Singleton.instance.usertype ==
                                          Constants.telecaller)
                                        listData.result!.cases![index]
                                                    .telSubStatus ==
                                                'new'
                                            ? CaseStatusWidget.satusTextWidget(
                                                context,
                                                text:
                                                    Languages.of(context)!.new_,
                                                width: 55,
                                              )
                                            : CaseStatusWidget.satusTextWidget(
                                                context,
                                                text: listData
                                                        .result!
                                                        .cases![index]
                                                        .telSubStatus ??
                                                    '',
                                              ),
                                      // : const SizedBox(),
                                      // const Spacer(),
                                      // if (listData.result!.cases![index]
                                      //         .collSubStatus ==
                                      //     'new')
                                    ],
                                  ),
                                ),
                                // listData.result!.cases![index].collSubStatus!,

                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 15, vertical: 6),
                                //   child: Container(
                                //     width: double.infinity,
                                //     padding: const EdgeInsets.fromLTRB(
                                //         20, 12, 15, 12),
                                //     decoration: BoxDecoration(
                                //       color: ColorResource.colorF8F9FB,
                                //       borderRadius: BorderRadius.circular(10),
                                //     ),
                                //     child: CustomText(
                                //       listData.result!.cases![index].address![0]
                                //           .value!,
                                //       color: ColorResource.color484848,
                                //       fontSize: FontSize.fourteen,
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 6),
                                  child: bloc.userType == Constants.fieldagent
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 12, 15, 12),
                                          decoration: BoxDecoration(
                                            color: ColorResource.colorF8F9FB,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              CustomText(
                                                listData.result!.cases![index]
                                                    .address![0].value!,
                                                color:
                                                    ColorResource.color484848,
                                              ),
                                              // CustomText(
                                              //   resultData[index].address![1].value!,
                                              //   color: ColorResource.color484848,
                                              //   fontSize: FontSize.fourteen,
                                              // ),
                                            ],
                                          ),
                                        )
                                      : Wrap(
                                          children: <Widget>[
                                            for (Address item in listData
                                                .result!.cases![index].address!)
                                              item.cType!.contains('mobile') ||
                                                      item.cType!
                                                          .contains('phone')
                                                  ? Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              right: 20),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 17,
                                                          vertical: 6),
                                                      decoration: BoxDecoration(
                                                        color: ColorResource
                                                            .colorF8F9FB,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: CustomText(
                                                        item.value!,
                                                        color: ColorResource
                                                            .color484848,
                                                        lineHeight: 1.0,
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                          ],
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
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 5, 14, 13),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CustomText(
                                        Languages.of(context)!.followUpDate,
                                        color: ColorResource.color101010,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          //here check Fieldagent 'collSubSatus'
                                          if (Singleton.instance.usertype ==
                                              Constants.fieldagent)
                                            listData.result!.cases![index]
                                                        .collSubStatus!
                                                        .toLowerCase() ==
                                                    'new'
                                                ? CustomText(
                                                    DateFormateUtils
                                                        .followUpDateFormate(
                                                            DateTime.now()
                                                                .toString()),
                                                    color: ColorResource
                                                        .color101010,
                                                    fontWeight: FontWeight.w700,
                                                  )
                                                : CustomText(
                                                    listData
                                                                .result!
                                                                .cases![index]
                                                                .fieldfollowUpDate !=
                                                            '-'
                                                        ? DateFormateUtils
                                                            .followUpDateFormate(
                                                                listData
                                                                    .result!
                                                                    .cases![
                                                                        index]
                                                                    .fieldfollowUpDate!)
                                                        : '-',
                                                    color: ColorResource
                                                        .color101010,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                          //here check telecaller 'tellSubSatus'
                                          if (Singleton.instance.usertype ==
                                              Constants.telecaller)
                                            listData.result!.cases![index]
                                                        .telSubStatus!
                                                        .toLowerCase() ==
                                                    'new'
                                                ? CustomText(
                                                    DateFormateUtils
                                                        .followUpDateFormate(
                                                            DateTime.now()
                                                                .toString()),
                                                    color: ColorResource
                                                        .color101010,
                                                    fontWeight: FontWeight.w700,
                                                  )
                                                : CustomText(
                                                    listData
                                                                .result!
                                                                .cases![index]
                                                                .followUpDate !=
                                                            '-'
                                                        ? DateFormateUtils
                                                            .followUpDateFormate(
                                                                listData
                                                                    .result!
                                                                    .cases![
                                                                        index]
                                                                    .followUpDate!)
                                                        : '-',
                                                    color: ColorResource
                                                        .color101010,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                          const Spacer(),
                                          Row(
                                            children: <Widget>[
                                              CustomText(
                                                Languages.of(context)!.view,
                                                color:
                                                    ColorResource.color23375A,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SvgPicture.asset(
                                                  ImageResource.forwardArrow)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
  }
}
