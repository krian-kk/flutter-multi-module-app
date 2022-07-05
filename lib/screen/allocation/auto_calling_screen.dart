import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/phone_screen/phone_screen.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/case_status_widget.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/health_status_widget.dart';
import 'package:origa/widgets/no_case_available.dart';
import 'package:origa/widgets/percent_indicatior_widget.dart';

class AutoCalling {
  static Future<void> phoneBottomSheet(
    BuildContext buildContext,
    CaseDetailsBloc bloc,
    int i,
    String caseId,
    dynamic contactValue,
    String userName,
    String userId,
    dynamic userAmount,
  ) {
    return showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return PhoneScreen(bloc: bloc, index: i);
        });
  }

  static Widget buildAutoCalling(BuildContext context, AllocationBloc bloc) {
    return BlocListener<AllocationBloc, AllocationState>(
      bloc: bloc,
      listener: (BuildContext context, AllocationState state) {},
      child: BlocBuilder<AllocationBloc, AllocationState>(
        bloc: bloc,
        builder: (BuildContext context, AllocationState state) {
          if (state is AutoCallingLoadingState) {
            return const CustomLoadingWidget();
          } else {
            return bloc.autoCallingResultList.isEmpty
                ? Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, right: 20, left: 20),
                        child: NoCaseAvailble.buildNoCaseAvailable(),
                      ),
                    ],
                  )
                : Scaffold(
                    backgroundColor: Colors.transparent,
                    resizeToAvoidBottomInset: true,
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // const SizedBox(height: 10),
                            // CustomText(
                            //   Languages.of(context)!.customer.toUpperCase(),
                            //   color: ColorResource.color23375A,
                            //   fontSize: FontSize.ten,
                            //   fontWeight: FontWeight.w700,
                            // ),
                            // const SizedBox(height: 5),
                            // PercentageIndicatorWidget(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 6, vertical: 4),
                            //   animation: true,
                            //   lineHeight: 12.0,
                            //   animationDuration: 2500,
                            //   percent: (bloc.customerCount / bloc.totalCount),
                            //   linearStrokeCap: LinearStrokeCap.roundAll,
                            //   progressColor: ColorResource.colorEA6D48,
                            //   backgroundColor: ColorResource.colorD3D7DE,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: <Widget>[
                            //     CustomText(
                            //       bloc.customerCount.toString(),
                            //       fontSize: FontSize.sixteen,
                            //       fontWeight: FontWeight.w700,
                            //       color: ColorResource.color23375A,
                            //     ),
                            //     CustomText(
                            //       bloc.totalCount.toString(),
                            //       fontSize: FontSize.sixteen,
                            //       fontWeight: FontWeight.w700,
                            //       color: ColorResource.color23375A,
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(height: 15),
                            CustomText(
                              Languages.of(context)!.customer.toUpperCase(),
                              color: ColorResource.color23375A,
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(height: 5),
                            ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: bloc.autoCallingResultList.length,
                                itemBuilder:
                                    (BuildContext context, int indexs) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: ColorResource.colorffffff,
                                        border: Border.all(
                                            color: ColorResource.colorDADADA,
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.25),
                                            blurRadius: 2,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 2.0,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24,
                                                      vertical: 2),
                                              child: CustomText(
                                                bloc
                                                        .autoCallingResultList[
                                                            indexs]
                                                        .bankName! +
                                                    ' / ' +
                                                    bloc
                                                        .autoCallingResultList[
                                                            indexs]
                                                        .agrRef!,
                                                fontSize: FontSize.twelve,
                                                color:
                                                    ColorResource.color101010,
                                              ),
                                            ),
                                          ),
                                          AppUtils.showDivider(),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                23, 0, 10, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    CustomText(
                                                      bloc.resultList[indexs]
                                                                  .due !=
                                                              null
                                                          ? bloc
                                                              .resultList[
                                                                  indexs]
                                                              .due
                                                              .toString()
                                                          : '',
                                                      fontSize:
                                                          FontSize.eighteen,
                                                      color: ColorResource
                                                          .color101010,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    const SizedBox(
                                                      height: 3.0,
                                                    ),
                                                    SizedBox(
                                                      child: CustomText(
                                                        bloc
                                                            .autoCallingResultList[
                                                                indexs]
                                                            .cust!,
                                                        fontSize:
                                                            FontSize.sixteen,
                                                        color: ColorResource
                                                            .color101010,
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
                                                // bloc.autoCallingResultList[indexs]
                                                //             .telSubStatus ==
                                                //         "new"
                                                //     ? Container(
                                                //         width: 55,
                                                //         height: 19,
                                                //         decoration: BoxDecoration(
                                                //             color: ColorResource
                                                //                 .colorD5344C,
                                                //             borderRadius:
                                                //                 BorderRadius
                                                //                     .circular(
                                                //                         30)),
                                                //         child: Center(
                                                //           child: CustomText(
                                                //             Languages.of(
                                                //                     context)!
                                                //                 .new_,
                                                //             color: ColorResource
                                                //                 .colorffffff,
                                                //             fontSize:
                                                //                 FontSize.ten,
                                                //             lineHeight: 1,
                                                //           ),
                                                //         ),
                                                //       )
                                                //     : const SizedBox(),

                                                if (Singleton
                                                        .instance.usertype ==
                                                    Constants.telecaller)
                                                  bloc
                                                              .autoCallingResultList[
                                                                  indexs]
                                                              .telSubStatus ==
                                                          'new'
                                                      ? CaseStatusWidget
                                                          .satusTextWidget(
                                                          context,
                                                          text: Languages.of(
                                                                  context)!
                                                              .new_,
                                                          width: 55,
                                                        )
                                                      : CaseStatusWidget
                                                          .satusTextWidget(
                                                              context,
                                                              text: bloc
                                                                  .autoCallingResultList[
                                                                      indexs]
                                                                  .telSubStatus)
                                                // : const SizedBox(),
                                              ],
                                            ),
                                          ),
                                          ListView.builder(
                                              itemCount: bloc
                                                      .autoCallingResultList[
                                                          indexs]
                                                      .address
                                                      ?.length ??
                                                  0,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int i) {
                                                if (bloc
                                                        .autoCallingResultList[
                                                            indexs]
                                                        .address?[i]
                                                        .cType ==
                                                    'mobile') {
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      Singleton
                                                              .instance.agrRef =
                                                          bloc
                                                              .autoCallingResultList[
                                                                  indexs]
                                                              .agrRef;

                                                      final CaseDetailsBloc
                                                          caseDetailsloc =
                                                          CaseDetailsBloc(bloc)
                                                            ..add(
                                                                CaseDetailsInitialEvent(
                                                              paramValues: <
                                                                  String,
                                                                  dynamic>{
                                                                'caseID': bloc
                                                                    .autoCallingResultList[
                                                                        indexs]
                                                                    .caseId,
                                                                'customerIndex':
                                                                    i,
                                                                'phoneIndex': i,
                                                                // 'mobileList': tempMobileList,
                                                                'context':
                                                                    context,
                                                                'contactIndex':
                                                                    i,
                                                                'caseIndex':
                                                                    indexs,
                                                              },
                                                              context: context,
                                                            ));
                                                      await phoneBottomSheet(
                                                        context,
                                                        caseDetailsloc,
                                                        i,
                                                        bloc
                                                            .autoCallingResultList[
                                                                indexs]
                                                            .caseId!,
                                                        bloc
                                                            .autoCallingResultList[
                                                                indexs]
                                                            .address![i],
                                                        bloc
                                                            .autoCallingResultList[
                                                                indexs]
                                                            .cust!,
                                                        (bloc
                                                                .autoCallingResultList[
                                                                    indexs]
                                                                .bankName! +
                                                            ' / ' +
                                                            bloc
                                                                .autoCallingResultList[
                                                                    indexs]
                                                                .agrRef!),
                                                        bloc
                                                            .autoCallingResultList[
                                                                indexs]
                                                            .due,
                                                      );
                                                    },
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          20, 17, 12, 17),
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    CustomText(
                                                                  bloc
                                                                          .autoCallingResultList[
                                                                              indexs]
                                                                          .address?[
                                                                              i]
                                                                          .value ??
                                                                      '_',
                                                                  color: ColorResource
                                                                      .color484848,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 15,
                                                              ),
                                                              ShowHealthStatus.healthStatus(bloc
                                                                      .autoCallingResultList[
                                                                          indexs]
                                                                      .address?[
                                                                          i]
                                                                      .health ??
                                                                  ''),
                                                              const Spacer(),
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  CustomText(
                                                                    Languages.of(
                                                                            context)!
                                                                        .view,
                                                                    color: ColorResource
                                                                        .color23375A,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  SvgPicture.asset(
                                                                      ImageResource
                                                                          .forwardArrow),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return const SizedBox();
                                                }
                                              }),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 6),
                                            child: AppUtils.showDivider(),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              bloc.add(
                                                NavigateCaseDetailEvent(
                                                    paramValues: <String,
                                                        dynamic>{
                                                      'caseID': bloc
                                                          .autoCallingResultList[
                                                              indexs]
                                                          .caseId,
                                                    }),
                                              );
                                            },
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                children: <Widget>[
                                                  CustomText(
                                                    Languages.of(context)!
                                                        .caseView
                                                        .toUpperCase(),
                                                    color: ColorResource
                                                        .color23375A,
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
        },
      ),
    );
  }
}
