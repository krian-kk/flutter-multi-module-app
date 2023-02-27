import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/contractor_information_model.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/date_formate_utils.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

import '../../widgets/case_status_widget.dart';

class CustomCardList {
  static Widget buildListView(AllocationBloc bloc,
      {List<Result>? resultData,
      required ScrollController listViewController}) {
    return ListView.builder(
        controller: listViewController,
        itemCount: resultData!.length,
        // shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final int listCount = index + 1;
          String? distanceValues;
          if (resultData.length >= index &&
              resultData[index].distanceMeters != null) {
            distanceValues = resultData[index].distanceMeters < 1000
                ? '${(resultData[index].distanceMeters / 1000).toStringAsFixed(1)} Km'
                : '${(resultData[index].distanceMeters / 1000).toStringAsFixed(2)} Km';
          }
          final List<Address>? address = resultData[index].address;
          List<String> maskedNumbers = [];
          debugPrint("length--->" + (address?.length ?? 0).toString());
          final ContractorResult? informationModel =
              Singleton.instance.contractorInformations?.result;
          if (address != null) {
            for (Address item in address) {
              String value = item.value ?? '';
              if (item.cType!.contains('mobile') ||
                  item.cType!.contains('phone')) {
                if (informationModel?.cloudTelephony == true &&
                    informationModel?.contactMasking == true &&
                    address != null) {
                  value = value.replaceRange(2, 7, 'XXXXX');
                }
                maskedNumbers.add(value);
              }
            }
          }
          return (resultData.length >= index)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                        visible: bloc.showFilterDistance,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 7, top: 7),
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                color: ColorResource.colorBEC4CF,
                                borderRadius: BorderRadius.circular(75),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 26,
                                    width: 26,
                                    decoration: const BoxDecoration(
                                      color: ColorResource.color23375A,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: CustomText(
                                      '$listCount',
                                      lineHeight: 1,
                                      fontSize: FontSize.twelve,
                                      fontWeight: FontWeight.w700,
                                      color: ColorResource.colorffffff,
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  if (resultData.length >= index &&
                                      resultData[index].distanceMeters != null)
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: CustomText(
                                            resultData[index].distanceMeters !=
                                                    null
                                                ? Constants.approx +
                                                    ' ' +
                                                    distanceValues!
                                                : '-',
                                            lineHeight: 1,
                                            color: ColorResource.color101010,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )
                                ],
                              )),
                        )),
                    if (index == 0 && bloc.showFilterDistance == false)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            CustomText(
                              bloc.totalCases.toString() +
                                  // resultData.length.toString() +
                                  ' ' +
                                  Languages.of(context)!.allocation,
                              color: ColorResource.color000000,
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(
                              width: 9.0,
                            ),
                            SizedBox(
                                height: 20,
                                width: 20,
                                child: SvgPicture.asset(ImageResource.star)),
                            const SizedBox(
                              width: 5.0,
                            ),
                            CustomText(
                              bloc.starCount.toString() +
                                  ' ' +
                                  Languages.of(context)!.hignPriority,
                              fontSize: FontSize.ten,
                              color: ColorResource.color101010,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                    Stack(
                      children: [
                        Padding(
                          padding: bloc.showFilterDistance
                              ? const EdgeInsets.only(bottom: 20)
                              : const EdgeInsets.only(bottom: 10, top: 19),
                          child: InkWell(
                            onTap: () async {
                              Singleton.instance.agrRef =
                                  resultData[index].agrRef ?? '';
                              bloc.add(NavigateCaseDetailEvent(paramValues: {
                                'caseID': resultData[index].caseId,
                                'isOffline': false
                              }));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: (index == resultData.length - 1)
                                  ? const EdgeInsets.only(bottom: 70)
                                  : EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: ColorResource.colorffffff,
                                border: Border.all(
                                    color: ColorResource.colorDADADA,
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 2.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 2)
                                        .copyWith(bottom: 0),
                                    child: CustomText(
                                      resultData[index].bankName! +
                                          ' / ' +
                                          resultData[index].agrRef!,
                                      fontSize: FontSize.twelve,
                                      color: ColorResource.color101010,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  AppUtils.showDivider(),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(23, 0, 10, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                Constants.inr +
                                                    resultData[index]
                                                        .due
                                                        .toString(),
                                                fontSize: FontSize.eighteen,
                                                color:
                                                    ColorResource.color101010,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              const SizedBox(height: 3.0),
                                              CustomText(
                                                resultData[index].cust!,
                                                fontSize: FontSize.sixteen,
                                                color:
                                                    ColorResource.color101010,
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (Singleton.instance.usertype ==
                                            Constants.fieldagent)
                                          resultData[index].collSubStatus ==
                                                  'new'
                                              ? CaseStatusWidget
                                                  .satusTextWidget(
                                                  context,
                                                  text: Languages.of(context)!
                                                      .new_,
                                                  width: 55,
                                                )
                                              : CaseStatusWidget
                                                  .satusTextWidget(
                                                  context,
                                                  text: resultData[index]
                                                          .collSubStatus ??
                                                      '',
                                                ),
                                        if (Singleton.instance.usertype ==
                                            Constants.telecaller)
                                          resultData[index].telSubStatus ==
                                                  'new'
                                              ? CaseStatusWidget
                                                  .satusTextWidget(
                                                  context,
                                                  text: Languages.of(context)!
                                                      .new_,
                                                  width: 55,
                                                )
                                              : CaseStatusWidget
                                                  .satusTextWidget(
                                                  context,
                                                  text: resultData[index]
                                                          .telSubStatus ??
                                                      '',
                                                ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: bloc.userType == Constants.fieldagent
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 5, 15, 5),
                                            decoration: BoxDecoration(
                                              color: ColorResource.colorF8F9FB,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  resultData[index].address !=
                                                          null
                                                      ? resultData[index]
                                                          .address!
                                                          .firstWhere((element) => (element
                                                                      .cType ==
                                                                  'residence address' ||
                                                              element.cType ==
                                                                  'office address' ||
                                                              element.cType ==
                                                                  'mobile' ||
                                                              element.cType ==
                                                                  'email'))
                                                          .value!
                                                      : '-',
                                                  color:
                                                      ColorResource.color484848,
                                                ),
                                              ],
                                            ),
                                          )
                                        : Wrap(
                                            children: [
                                              for (var item in maskedNumbers)
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 8, right: 20),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 17,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    color: ColorResource
                                                        .colorF8F9FB,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: CustomText(
                                                    item,
                                                    color: ColorResource
                                                        .color484848,
                                                    lineHeight: 1.0,
                                                  ),
                                                )
                                            ],
                                          ),
                                  ),
                                  const SizedBox(height: 0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: AppUtils.showDivider(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        23, 0, 14, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          Languages.of(context)!.followUpDate,
                                          color: ColorResource.color101010,
                                        ),
                                        Row(
                                          children: [
                                            if (Singleton.instance.usertype ==
                                                Constants.fieldagent)
                                              CustomText(
                                                resultData[index]
                                                            .fieldfollowUpDate !=
                                                        null
                                                    ? DateFormateUtils
                                                        .followUpDateFormate(
                                                            resultData[index]
                                                                .fieldfollowUpDate!)
                                                    : '-',
                                                color:
                                                    ColorResource.color101010,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            if (Singleton.instance.usertype ==
                                                Constants.telecaller)
                                              CustomText(
                                                resultData[index]
                                                            .followUpDate !=
                                                        null
                                                    ? DateFormateUtils
                                                        .followUpDateFormate(
                                                            resultData[index]
                                                                .followUpDate!)
                                                    : '-',
                                                color:
                                                    ColorResource.color101010,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                CustomText(
                                                  Languages.of(context)!.view,
                                                  lineHeight: 1,
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
                        if (bloc.showFilterDistance == false)
                          Container(
                            alignment: Alignment.topRight,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: GestureDetector(
                              onTap: () {
                                bloc.add(UpdateStaredCaseEvent(
                                    selectedStarIndex: index,
                                    caseID: resultData[index].caseId!,
                                    context: context));
                              },
                              child: resultData[index].starredCase
                                  ? SizedBox(
                                      height: 35,
                                      width: 35,
                                      child:
                                          SvgPicture.asset(ImageResource.star),
                                    )
                                  : SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: SvgPicture.asset(
                                          ImageResource.unStar),
                                    ),
                            ),
                          ),
                      ],
                    ),
                  ],
                )
              : const SizedBox();
        });
  }
}
