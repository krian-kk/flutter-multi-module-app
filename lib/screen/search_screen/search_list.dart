import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class SearchCaseList {
  static Widget buildListView(
    DashboardBloc bloc, {
    List<Result>? resultData,
  }) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: resultData!.length,
        itemBuilder: (BuildContext context, int index) {
          int listCount = index + 1;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 19),
                child: InkWell(
                  onTap: () {
                    bloc.add(NavigateCaseDetailEvent(paramValues: {
                      'caseID': resultData[index].caseId!,
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
                          color: ColorResource.colorDADADA, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          // spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 2.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 2),
                          child: CustomText(
                            resultData[index].caseId!,
                            fontSize: FontSize.twelve,
                            color: ColorResource.color101010,
                          ),
                        ),
                        AppUtils.showDivider(),
                        // const SizedBox(height: 6.0,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(23, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    Constants.inr +
                                        resultData[index].due.toString(),
                                    fontSize: FontSize.eighteen,
                                    color: ColorResource.color101010,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  const SizedBox(
                                    height: 3.0,
                                  ),
                                  CustomText(
                                    resultData[index].cust!,
                                    fontSize: FontSize.sixteen,
                                    color: ColorResource.color101010,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              if (resultData[index].collSubStatus == "new")
                                Container(
                                  width: 55,
                                  height: 19,
                                  // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: ColorResource.colorD5344C,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: CustomText(
                                      Languages.of(context)!.new_,
                                      color: ColorResource.colorffffff,
                                      fontSize: FontSize.ten,
                                      lineHeight: 1,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 6),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(20, 12, 15, 12),
                            decoration: BoxDecoration(
                              color: ColorResource.colorF8F9FB,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  resultData[index].address![0].value!,
                                  color: ColorResource.color484848,
                                  fontSize: FontSize.fourteen,
                                ),
                                // CustomText(
                                //   resultData[index].address![1].value!,
                                //   color: ColorResource.color484848,
                                //   fontSize: FontSize.fourteen,
                                // ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: AppUtils.showDivider(),
                        ),
                        //  const SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(23, 5, 14, 13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                Languages.of(context)!.followUpDate,
                                fontSize: FontSize.fourteen,
                                color: ColorResource.color101010,
                                fontWeight: FontWeight.w400,
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    resultData[index].fieldfollowUpDate ??
                                        resultData[index].followUpDate ??
                                        '-',
                                    fontSize: FontSize.fourteen,
                                    color: ColorResource.color101010,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      CustomText(
                                        Languages.of(context)!.view,
                                        fontSize: FontSize.fourteen,
                                        color: ColorResource.color23375A,
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
