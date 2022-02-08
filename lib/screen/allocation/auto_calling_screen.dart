import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/health_status_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AutoCalling {
  static Widget buildAutoCalling(BuildContext context, AllocationBloc bloc) {
    // List<Widget> _buildRouteFilterOptions() {
    //   List<Widget> widgets = [];
    //   bloc.mobileNumberList.asMap().forEach((index, element) {
    //     widgets.add(
    //       Container(
    //         width: MediaQuery.of(context).size.width,
    //         padding: const EdgeInsets.fromLTRB(20, 17, 12, 17),
    //         margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    //         decoration: BoxDecoration(
    //           color: element.callResponse != null
    //               ? ColorResource.colorF6ECEF
    //               : ColorResource.colorF8F9FB,
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 CustomText(
    //                   element.mobileNumber!,
    //                   color: ColorResource.color484848,
    //                   fontSize: FontSize.fourteen,
    //                 ),
    //                 const SizedBox(
    //                   width: 15,
    //                 ),
    //                 element.callResponse != null
    //                     ? SvgPicture.asset(ImageResource.declinedCall)
    //                     : SvgPicture.asset(ImageResource.activePerson),
    //                 const Spacer(),
    //                 InkWell(
    //                   onTap: () {
    //                     // bloc.add(NavigateCaseDetailTEvent(
    //                     //   const {
    //                     //     'caseID': '618e382004d8d040ac18841b',
    //                     //     'isAddress': true,
    //                     //   },
    //                     // ));
    //                   },
    //                   child: Row(
    //                     children: [
    //                       CustomText(
    //                         Languages.of(context)!.view,
    //                         fontSize: FontSize.fourteen,
    //                         color: ColorResource.color23375A,
    //                         fontWeight: FontWeight.w700,
    //                       ),
    //                       const SizedBox(
    //                         width: 10,
    //                       ),
    //                       SvgPicture.asset(ImageResource.forwardArrow),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //             if (element.callResponse != null)
    //               CustomText(
    //                 element.callResponse!,
    //                 color: ColorResource.colorD5344C,
    //                 fontSize: FontSize.fourteen,
    //               ),
    //           ],
    //         ),
    //       ),
    //     );
    //   });
    //   return widgets;
    // }

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              CustomText(
                Languages.of(context)!.customer.toUpperCase(),
                color: ColorResource.color23375A,
                fontSize: FontSize.ten,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 5),
              LinearPercentIndicator(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                animation: true,
                lineHeight: 12.0,
                animationDuration: 2500,
                percent: (bloc.customerCount / bloc.totalCount),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: ColorResource.colorEA6D48,
                backgroundColor: ColorResource.colorD3D7DE,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    bloc.customerCount.toString(),
                    fontSize: FontSize.sixteen,
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color23375A,
                  ),
                  CustomText(
                    bloc.totalCount.toString(),
                    fontSize: FontSize.sixteen,
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color23375A,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              CustomText(
                Languages.of(context)!.customer.toUpperCase(),
                color: ColorResource.color23375A,
                fontSize: FontSize.fourteen,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 5),
              ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bloc.resultList.length,
                  itemBuilder: (context, indexs) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: ColorResource.colorffffff,
                          border: Border.all(
                              color: ColorResource.colorDADADA, width: 0.5),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 2.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 2),
                                child: CustomText(
                                  bloc.resultList[indexs].bankName! +
                                      " / " +
                                      bloc.resultList[indexs].agrRef!,
                                  fontSize: FontSize.twelve,
                                  color: ColorResource.color101010,
                                ),
                              ),
                            ),
                            AppUtils.showDivider(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(23, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        bloc.resultList[indexs].due.toString(),
                                        fontSize: FontSize.eighteen,
                                        color: ColorResource.color101010,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      const SizedBox(
                                        height: 3.0,
                                      ),
                                      SizedBox(
                                        width: 260,
                                        child: CustomText(
                                          bloc.resultList[indexs].cust!,
                                          fontSize: FontSize.sixteen,
                                          color: ColorResource.color101010,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  // bloc.allocationList[index].newlyAdded!
                                  // ?
                                  bloc.resultList[indexs].telSubStatus == "new"
                                      ? Container(
                                          width: 55,
                                          height: 19,
                                          // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                          decoration: BoxDecoration(
                                              color: ColorResource.colorD5344C,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                            child: CustomText(
                                              Languages.of(context)!.new_,
                                              color: ColorResource.colorffffff,
                                              fontSize: FontSize.ten,
                                              lineHeight: 1,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  // : const SizedBox(),
                                ],
                              ),
                            ),
                            ListView.builder(
                                itemCount:
                                    bloc.resultList[indexs].address?.length ??
                                        0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  if (bloc.resultList[indexs].address?[i]
                                          .cType ==
                                      'mobile') {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 17, 12, 17),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                        color:
                                            // bloc.mobileNumberList[1]
                                            //             .callResponse !=
                                            //         null
                                            //     ?
                                            ColorResource.colorF6ECEF,
                                        //     :
                                        // ColorResource.colorF8F9FB,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                bloc.resultList[indexs]
                                                        .address?[i].value ??
                                                    '_',
                                                color:
                                                    ColorResource.color484848,
                                                fontSize: FontSize.fourteen,
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              ShowHealthStatus.healthStatus(bloc
                                                      .resultList[indexs]
                                                      .address?[i]
                                                      .health ??
                                                  ''),
                                              // bloc.mobileNumberList[1]
                                              //             .callResponse !=
                                              //         null
                                              //     ? SvgPicture.asset(
                                              //         ImageResource
                                              //             .declinedCall)
                                              //     : SvgPicture.asset(
                                              //         ImageResource
                                              //             .activePerson),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  // bloc.add(NavigateCaseDetailTEvent(
                                                  //   const {
                                                  //     'caseID': '618e382004d8d040ac18841b',
                                                  //     'isAddress': true,
                                                  //   },
                                                  // ));
                                                },
                                                child: Row(
                                                  children: [
                                                    CustomText(
                                                      Languages.of(context)!
                                                          .view,
                                                      fontSize:
                                                          FontSize.fourteen,
                                                      color: ColorResource
                                                          .color23375A,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    SvgPicture.asset(
                                                        ImageResource
                                                            .forwardArrow),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          // if (bloc.mobileNumberList[1]
                                          //         .callResponse !=
                                          //     null)
                                          //   CustomText(
                                          //     bloc.mobileNumberList[i]
                                          //         .callResponse!,
                                          //     color: ColorResource.colorD5344C,
                                          //     fontSize: FontSize.fourteen,
                                          //   ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                }),
                            // Container(
                            //   width: MediaQuery.of(context).size.width,
                            //   padding: const EdgeInsets.fromLTRB(20, 17, 12, 17),
                            //   margin: const EdgeInsets.symmetric(
                            //       horizontal: 15, vertical: 5),
                            //   decoration: BoxDecoration(
                            //     color:
                            //         bloc.mobileNumberList[index].callResponse !=
                            //                 null
                            //             ? ColorResource.colorF6ECEF
                            //             : ColorResource.colorF8F9FB,
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         children: [
                            //           CustomText(
                            //             bloc.mobileNumberList[index]
                            //                 .mobileNumber!,
                            //             color: ColorResource.color484848,
                            //             fontSize: FontSize.fourteen,
                            //           ),
                            //           const SizedBox(
                            //             width: 15,
                            //           ),
                            //           bloc.mobileNumberList[index].callResponse !=
                            //                   null
                            //               ? SvgPicture.asset(
                            //                   ImageResource.declinedCall)
                            //               : SvgPicture.asset(
                            //                   ImageResource.activePerson),
                            //           const Spacer(),
                            //           InkWell(
                            //             onTap: () {
                            //               // bloc.add(NavigateCaseDetailTEvent(
                            //               //   const {
                            //               //     'caseID': '618e382004d8d040ac18841b',
                            //               //     'isAddress': true,
                            //               //   },
                            //               // ));
                            //             },
                            //             child: Row(
                            //               children: [
                            //                 CustomText(
                            //                   Languages.of(context)!.view,
                            //                   fontSize: FontSize.fourteen,
                            //                   color: ColorResource.color23375A,
                            //                   fontWeight: FontWeight.w700,
                            //                 ),
                            //                 const SizedBox(
                            //                   width: 10,
                            //                 ),
                            //                 SvgPicture.asset(
                            //                     ImageResource.forwardArrow),
                            //               ],
                            //             ),
                            //           )
                            //         ],
                            //       ),
                            //       if (bloc.mobileNumberList[index].callResponse !=
                            //           null)
                            //         CustomText(
                            //           bloc.mobileNumberList[index].callResponse!,
                            //           color: ColorResource.colorD5344C,
                            //           fontSize: FontSize.fourteen,
                            //         ),
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 6),
                              child: AppUtils.showDivider(),
                            ),
                            InkWell(
                              onTap: () {
                                bloc.add(NavigateCaseDetailEvent(paramValues: {
                                  'caseID': bloc.resultList[indexs].caseId,
                                }));
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    CustomText(
                                      Languages.of(context)!
                                          .caseView
                                          .toUpperCase(),
                                      fontSize: FontSize.fourteen,
                                      color: ColorResource.color23375A,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    const SizedBox(
                                      height: 13,
                                    ),
                                    SvgPicture.asset(
                                      ImageResource.downArrow,
                                      width: 15,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
