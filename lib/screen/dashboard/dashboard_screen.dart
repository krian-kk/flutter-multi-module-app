import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/case_details_navigation_model.dart';
import 'package:origa/models/return_value_model.dart';
import 'package:origa/screen/broken_ptp/broken_ptp.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/my_deposists/my_deposists.dart';
import 'package:origa/screen/my_recipts/my_receipts.dart';
import 'package:origa/screen/my_visit/my_visits.dart';
import 'package:origa/screen/priority_follow_up/priority_follow_up_bottomsheet.dart';
import 'package:origa/screen/untouched_case/untouched_cases.dart';
import 'package:origa/screen/yarding_selfrelese/yarding_self_release.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/skeleton.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/percent_indicatior_widget.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../router.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = DashboardBloc()..add(DashboardInitialEvent(context));
  }

  Widget userActivity(
      {String? header,
      String? count,
      Color? backgrountColor,
      required Color leadingColor}) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
          color: backgrountColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 5,
            decoration: BoxDecoration(
              color: leadingColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(7, 5, 2, 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(
                  header!,
                  color: ColorResource.color23375A,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  lineHeight: 1.0,
                ),
                CustomText(
                  count ?? '0',
                  color: ColorResource.color23375A,
                  fontSize: FontSize.sixteen,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  void priorityFollowUpSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              bottom: false, child: PriorityFollowUpBottomSheet(bloc));
        });
  }

  void brokenPTPSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(bottom: false, child: BrokenPTPBottomSheet(bloc));
        });
  }

  void untouchedCasesSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              bottom: false, child: UntouchedCasesBottomSheet(bloc));
        });
  }

  void myVisitsSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(bottom: false, child: MyVisitsBottomSheet(bloc));
        });
  }

  void myReceiptsSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(bottom: false, child: MyReceiptsBottomSheet(bloc));
        });
  }

  void myDeposistsSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(bottom: false, child: MyDeposistsBottomSheet(bloc));
        });
  }

  void yardingSelfReleaseSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(bottom: false, child: YardingAndSelfRelease(bloc));
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocListener<DashboardBloc, DashboardState>(
        bloc: bloc,
        listener: (BuildContext context, DashboardState state) async {
          if (state is SetTimeperiodValueState) {
            bloc.selectedFilter = Constants.today;
            bloc.selectedFilterIndex = '0';
          }

          if (state is ClickToCardLoadingState) {
            bloc.isClickToCardLoading = !bloc.isClickToCardLoading;
          }

          if (state is PostDataApiSuccessState) {
            while (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            AppUtils.topSnackBar(context, Constants.successfullySubmitted);
          }
          if (state is NoInternetConnectionState) {
            AppUtils.noInternetSnackbar(context);
          }
          if (state is PriorityFollowState) {
            priorityFollowUpSheet(context);
          }
          if (state is UntouchedCasesState) {
            untouchedCasesSheet(context);
          }
          if (state is UpdateSuccessfulState) {
            setState(() {});
          }
          if (state is BrokenPTPState) {
            brokenPTPSheet(context);
          }
          if (state is MyReceiptsState) {
            myReceiptsSheet(context);
          }

          if (state is MyVisitsState) {
            myVisitsSheet(context);
          }

          if (state is MyDeposistsState) {
            myDeposistsSheet(context);
          }

          if (state is YardingAndSelfReleaseState) {
            yardingSelfReleaseSheet(context);
          }

          if (state is NavigateCaseDetailState) {
            final dynamic returnValue = await Navigator.pushNamed(
              context,
              AppRoutes.caseDetailsScreen,
              arguments: CaseDetailsNaviagationModel(state.paramValues),
            );
            final RetrunValueModel retrunModelValue = RetrunValueModel.fromJson(
                Map<String, dynamic>.from(returnValue));

            if (retrunModelValue.isSubmitForMyVisit) {
              bloc.add(UpdateMyVisitCasesEvent(
                  retrunModelValue.caseId, retrunModelValue.returnCaseAmount,
                  isNotMyReceipts: !(state.isMyReceipts)));
              if (state.unTouched) {
                bloc.add(UpdateUnTouchedCasesEvent(retrunModelValue.caseId,
                    retrunModelValue.returnCaseAmount));
              }
              if (state.isPriorityFollowUp) {
                bloc.add(UpdatePriorityFollowUpCasesEvent(
                    retrunModelValue.caseId,
                    retrunModelValue.returnCaseAmount));
              }
              if (state.isBrokenPTP) {
                bloc.add(UpdateBrokenCasesEvent(
                  retrunModelValue.caseId,
                  retrunModelValue.returnCaseAmount,
                ));
              }
              if (retrunModelValue.eventType == Constants.collections) {
                bloc.add(UpdateMyReceiptsCasesEvent(retrunModelValue.caseId,
                    retrunModelValue.returnCollectionAmount));
              }
            }
          }

          if (state is NavigateSearchState) {
            final dynamic returnValue =
                await Navigator.pushNamed(context, AppRoutes.searchScreen);
            if (returnValue != null) {
              bloc.add(SearchReturnDataEvent(returnValue: returnValue));
            }
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
            bloc: bloc,
            builder: (BuildContext context, DashboardState state) {
              if (state is DashboardLoadingState) {
                // return const CustomLoadingWidget();
                return const SkeletonLoading();
              }
              return bloc.isNoInternetAndServerError
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(bloc.noInternetAndServerErrorMsg!),
                          const SizedBox(
                            height: 5,
                          ),
                          IconButton(
                              onPressed: () {
                                bloc.add(DashboardInitialEvent(context));
                              },
                              icon: const Icon(Icons.refresh)),
                        ],
                      ),
                    )
                  : Stack(
                      children: [
                        Scaffold(
                            backgroundColor: ColorResource.colorF7F8FA,
                            body: SafeArea(
                                bottom: false,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 13),
                                          child: CustomText(
                                            bloc.todayDate ?? '',
                                            fontSize: FontSize.twelve,
                                            fontWeight: FontWeight.w700,
                                            color: ColorResource.color23375A,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: userActivity(
                                                  header: bloc.userType ==
                                                          Constants.fieldagent
                                                      ? Languages.of(context)!
                                                          .customerMet
                                                      : Languages.of(context)!
                                                          .connected
                                                          .trim(),
                                                  count: bloc
                                                      .dashboardCardCounts
                                                      .result
                                                      ?.met!
                                                      .count
                                                      .toString(),
                                                  backgrountColor:
                                                      ColorResource.colorE0ECDF,
                                                  leadingColor:
                                                      ColorResource.color73C170,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              Expanded(
                                                child: userActivity(
                                                  header: bloc.userType ==
                                                          Constants.fieldagent
                                                      ? Languages.of(context)!
                                                          .customerNotMet
                                                      : Languages.of(context)!
                                                          .unreachable
                                                          .trim(),
                                                  count: bloc
                                                      .dashboardCardCounts
                                                      .result
                                                      ?.notMet!
                                                      .count
                                                      .toString(),
                                                  backgrountColor:
                                                      ColorResource.colorF2EEDC,
                                                  leadingColor:
                                                      ColorResource.colorE5C55B,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              Expanded(
                                                child: userActivity(
                                                  header: Languages.of(context)!
                                                      .invalid
                                                      .trim(),
                                                  count: bloc
                                                      .dashboardCardCounts
                                                      .result
                                                      ?.invalid!
                                                      .count
                                                      .toString(),
                                                  backgrountColor:
                                                      ColorResource.colorF4ECEF,
                                                  leadingColor:
                                                      ColorResource.colorF1BCC4,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                Languages.of(context)!
                                                    .mtdResolutionProgress,
                                                fontSize: FontSize.twelve,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    ColorResource.color23375A,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              CustomText(
                                                Languages.of(context)!
                                                    .customer
                                                    .toUpperCase(),
                                                color:
                                                    ColorResource.color23375A,
                                                fontSize: FontSize.ten,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              PercentageIndicatorWidget(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                animation: true,
                                                addAutomaticKeepAlive: false,
                                                lineHeight: 12.0,
                                                animationDuration: 2500,
                                                // Result must change
                                                percent: (bloc.mtdCaseCompleted! ==
                                                            0 &&
                                                        bloc.mtdCaseTotal! == 0)
                                                    ? 0.0
                                                    : (bloc.mtdCaseCompleted! <=
                                                            bloc.mtdCaseTotal!)
                                                        ? (bloc.mtdCaseCompleted! /
                                                            bloc.mtdCaseTotal!)
                                                        : 0.0,
                                                linearStrokeCap:
                                                    LinearStrokeCap.roundAll,
                                                progressColor:
                                                    ColorResource.colorEA6D48,
                                                backgroundColor:
                                                    ColorResource.colorD3D7DE,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    bloc.mtdCaseCompleted
                                                        .toString(),
                                                    fontSize: FontSize.sixteen,
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorResource
                                                        .color23375A,
                                                  ),
                                                  CustomText(
                                                    bloc.mtdCaseTotal
                                                        .toString(),
                                                    fontSize: FontSize.sixteen,
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorResource
                                                        .color23375A,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                Languages.of(context)!
                                                    .amount
                                                    .toUpperCase(),
                                                color:
                                                    ColorResource.color23375A,
                                                fontSize: FontSize.ten,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              PercentageIndicatorWidget(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                addAutomaticKeepAlive: false,
                                                animation: true,
                                                lineHeight: 12.0,
                                                animationDuration: 2500,
                                                percent: (bloc.mtdAmountCompleted! ==
                                                            0 &&
                                                        bloc.mtdAmountTotal! ==
                                                            0)
                                                    ? 0.0
                                                    : (bloc.mtdAmountCompleted! <=
                                                            bloc
                                                                .mtdAmountTotal!)
                                                        ? (bloc.mtdAmountCompleted! /
                                                            bloc.mtdAmountTotal!)
                                                        : 0.0,
                                                linearStrokeCap:
                                                    LinearStrokeCap.roundAll,
                                                progressColor:
                                                    ColorResource.colorEA6D48,
                                                backgroundColor:
                                                    ColorResource.colorD3D7DE,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    Constants.inr +
                                                        bloc.mtdAmountCompleted
                                                            .toString(),
                                                    fontSize: FontSize.twelve,
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorResource
                                                        .color23375A,
                                                  ),
                                                  CustomText(
                                                    Constants.inr +
                                                        bloc.mtdAmountTotal
                                                            .toString(),
                                                    fontSize: FontSize.twelve,
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorResource
                                                        .color23375A,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        // ================================================================================================
                                        StaggeredGridView.countBuilder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          crossAxisCount: 4,
                                          itemCount: bloc.dashboardList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                switch (index) {
                                                  case 0:
                                                    bloc.add(
                                                        PriorityFollowEvent());
                                                    break;
                                                  case 1:
                                                    bloc.add(
                                                        UntouchedCasesEvent());
                                                    break;
                                                  case 2:
                                                    bloc.add(BrokenPTPEvent());
                                                    break;
                                                  case 3:
                                                    bloc.add(
                                                        SetTimeperiodValueEvent());
                                                    bloc.add(MyReceiptsEvent());
                                                    break;
                                                  case 4:
                                                    bloc.add(
                                                        SetTimeperiodValueEvent());
                                                    bloc.add(MyVisitsEvent());
                                                    break;
                                                  case 5:
                                                    bloc.add(
                                                        SetTimeperiodValueEvent());
                                                    bloc.add(
                                                        MyDeposistsEvent());
                                                    break;
                                                  case 6:
                                                    bloc.add(
                                                        YardingAndSelfReleaseEvent());
                                                    break;
                                                  default:
                                                }
                                              },
                                              child: index == 5
                                                  ? bloc.userType! ==
                                                          Constants.fieldagent
                                                      ? Card(
                                                          elevation: 0,
                                                          color: ColorResource
                                                              .colorD3D7DE,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: const BorderSide(
                                                                color: ColorResource
                                                                    .colorD3D7DE),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        75),
                                                          ),
                                                          child: Center(
                                                            child: CustomText(
                                                              bloc
                                                                  .dashboardList[
                                                                      index]
                                                                  .title!,
                                                              fontSize: FontSize
                                                                  .twelve,
                                                              lineHeight: 1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: ColorResource
                                                                  .color23375A,
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox()
                                                  : index == 6
                                                      ? bloc.userType! ==
                                                              Constants
                                                                  .fieldagent
                                                          ? Card(
                                                              elevation: 0,
                                                              color: ColorResource
                                                                  .colorffffff,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                side: const BorderSide(
                                                                    color: ColorResource
                                                                        .color23375A,
                                                                    width: 0.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            75),
                                                              ),
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5),
                                                                child:
                                                                    CustomText(
                                                                  bloc
                                                                      .dashboardList[
                                                                          index]
                                                                      .title!,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  fontSize:
                                                                      FontSize
                                                                          .twelve,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: ColorResource
                                                                      .color23375A,
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox()
                                                      : index == 6
                                                          ? bloc.userType ==
                                                                  Constants
                                                                      .fieldagent
                                                              ? Card(
                                                                  elevation: 0,
                                                                  color: ColorResource
                                                                      .colorffffff,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side: const BorderSide(
                                                                        color: ColorResource
                                                                            .color23375A,
                                                                        width:
                                                                            0.5),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            75),
                                                                  ),
                                                                  child: Center(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      child:
                                                                          CustomText(
                                                                        bloc.dashboardList[index]
                                                                            .title!,
                                                                        fontSize:
                                                                            FontSize.twelve,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        color: ColorResource
                                                                            .color23375A,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : const SizedBox()
                                                          : Card(
                                                              elevation: 2,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                side: const BorderSide(
                                                                    color: ColorResource
                                                                        .colorDADADA,
                                                                    width: 0.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        8,
                                                                        5,
                                                                        5,
                                                                        5),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        SizedBox(
                                                                            width:
                                                                                105,
                                                                            child:
                                                                                CustomText(
                                                                              bloc.dashboardList[index].title!,
                                                                              fontSize: FontSize.twelve,
                                                                              fontWeight: FontWeight.w700,
                                                                              color: ColorResource.color23375A,
                                                                            )),
                                                                        if (bloc.dashboardList[index].image! !=
                                                                            '')
                                                                          SvgPicture.asset(bloc
                                                                              .dashboardList[index]
                                                                              .image!),
                                                                      ],
                                                                    ),
                                                                    const Spacer(),
                                                                    Row(
                                                                      children: [
                                                                        CustomText(
                                                                          bloc.dashboardList[index]
                                                                              .count!,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          color:
                                                                              ColorResource.color23375A,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              6,
                                                                        ),
                                                                        CustomText(
                                                                          bloc.dashboardList[index]
                                                                              .subTitle!,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              ColorResource.color23375A,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    CustomText(
                                                                      Constants
                                                                              .inr +
                                                                          double.parse(bloc.dashboardList[index].amountRs!)
                                                                              .toStringAsFixed(2),
                                                                      fontSize:
                                                                          FontSize
                                                                              .sixteen,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: ColorResource
                                                                          .color23375A,
                                                                      isSingleLine:
                                                                          true,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                            );
                                          },
                                          // ========================================================================================================
                                          staggeredTileBuilder: (int index) =>
                                              StaggeredTile.count(
                                                  2,
                                                  index == 5
                                                      ? 0.6
                                                      : index == 6
                                                          ? 0.7
                                                          : 1.3),
                                          mainAxisSpacing: 4.0,
                                          crossAxisSpacing: 4.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ))),
                        if (bloc.isClickToCardLoading)
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0xFF0E3311).withOpacity(0.15),
                            child: const Center(
                              child: CustomLoadingWidget(),
                            ),
                          ),
                      ],
                    );
            }));
  }
}
