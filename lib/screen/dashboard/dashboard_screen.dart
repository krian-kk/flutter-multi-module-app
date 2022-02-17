import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
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
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
    // _initPackageInfo();
    bloc = DashboardBloc()..add(DashboardInitialEvent(context));
  }

  // Future<void> _initPackageInfo() async {
  //   final info = await PackageInfo.fromPlatform();
  //   setState(() {
  //     version = info.version;
  //   });
  // }

  Widget userActivity(
      {String? header,
      String? count,
      Color? backgrountColor,
      required Color leadingColor}) {
    return Container(
      // width: 120,
      height: 60,
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
              // mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  header!,
                  color: ColorResource.color23375A,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  lineHeight: 1.0,
                ),
                // const Spacer(),
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
              // top: false,
              bottom: false,
              child: PriorityFollowUpBottomSheet(bloc));
        });
  }

  void brokenPTPSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              // top: false,
              bottom: false,
              child: BrokenPTPBottomSheet(bloc));
        });
  }

  void untouchedCasesSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              // top: false,
              bottom: false,
              child: UntouchedCasesBottomSheet(bloc));
        });
  }

  void myVisitsSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              // top: false,
              bottom: false,
              child: MyVisitsBottomSheet(bloc));
        });
  }

  void myReceiptsSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              // top: false,
              bottom: false,
              child: MyReceiptsBottomSheet(bloc));
        });
  }

  void myDeposistsSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              // top: false,
              bottom: false,
              child: MyDeposistsBottomSheet(bloc));
        });
  }

  void yardingSelfReleaseSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              // top: false,
              bottom: false,
              child: YardingAndSelfRelease(bloc));
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
            bloc.selectedFilter = 'TODAY';
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
            dynamic returnValue = await Navigator.pushNamed(
              context,
              AppRoutes.caseDetailsScreen,
              arguments: state.paramValues,
            );
            RetrunValueModel retrunModelValue = RetrunValueModel.fromJson(
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
            // if (retrunModelValue.isSubmit) {
            // }
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
                return const CustomLoadingWidget();
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
                  : Scaffold(
                      backgroundColor: ColorResource.colorF7F8FA,
                      body: SafeArea(
                          bottom: false,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          flex: 1,
                                          child: userActivity(
                                            header: bloc.userType ==
                                                    Constants.fieldagent
                                                ? Languages.of(context)!
                                                    .customerMet
                                                : Languages.of(context)!
                                                    .connected
                                                    .trim(),
                                            count: bloc.dashboardCardCounts
                                                .result?.met!.count
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
                                          flex: 1,
                                          child: userActivity(
                                            header: bloc.userType ==
                                                    Constants.fieldagent
                                                ? Languages.of(context)!
                                                    .customerNotMet
                                                : Languages.of(context)!
                                                    .unreachable
                                                    .trim(),
                                            count: bloc.dashboardCardCounts
                                                .result?.notMet!.count
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
                                          flex: 1,
                                          child: userActivity(
                                            header: Languages.of(context)!
                                                .invalid
                                                .trim(),
                                            count: bloc.dashboardCardCounts
                                                .result?.invalid!.count
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
                                  // userActivity(
                                  //   StringResource.customerMet,
                                  //   '20',
                                  //   ColorResource.colorBEC4CF,
                                  //   ColorResource.color73C170,
                                  // ),
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
                                          color: ColorResource.color23375A,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        CustomText(
                                          Languages.of(context)!
                                              .customer
                                              .toUpperCase(),
                                          color: ColorResource.color23375A,
                                          fontSize: FontSize.ten,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        LinearPercentIndicator(
                                          // width: MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(4),
                                          animation: true,
                                          addAutomaticKeepAlive: false,
                                          lineHeight: 12.0,
                                          animationDuration: 2500,
                                          // Result must change
                                          // percent: (bloc.mtdCaseCompleted!/bloc.mtdCaseTotal!),
                                          percent: (bloc.mtdCaseCompleted! ==
                                                      0 &&
                                                  bloc.mtdCaseTotal! == 0)
                                              ? 0.0
                                              : (bloc.mtdCaseCompleted! <=
                                                      bloc.mtdCaseTotal!)
                                                  ? (bloc.mtdCaseCompleted! /
                                                      bloc.mtdCaseTotal!)
                                                  : 0.0,
                                          // center: Text("80.0%"),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor:
                                              ColorResource.colorEA6D48,
                                          backgroundColor:
                                              ColorResource.colorD3D7DE,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              bloc.mtdCaseCompleted.toString(),
                                              fontSize: FontSize.sixteen,
                                              fontWeight: FontWeight.w700,
                                              color: ColorResource.color23375A,
                                            ),
                                            CustomText(
                                              bloc.mtdCaseTotal.toString(),
                                              fontSize: FontSize.sixteen,
                                              fontWeight: FontWeight.w700,
                                              color: ColorResource.color23375A,
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
                                          color: ColorResource.color23375A,
                                          fontSize: FontSize.ten,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        LinearPercentIndicator(
                                          // width: MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(4),
                                          addAutomaticKeepAlive: false,
                                          animation: true,
                                          lineHeight: 12.0,
                                          animationDuration: 2500,
                                          // percent: (bloc.mtdAmountCompleted! / bloc.mtdAmountTotal!),
                                          percent: (bloc.mtdAmountCompleted! ==
                                                      0 &&
                                                  bloc.mtdAmountTotal! == 0)
                                              ? 0.0
                                              : (bloc.mtdAmountCompleted! <=
                                                      bloc.mtdAmountTotal!)
                                                  ? (bloc.mtdAmountCompleted! /
                                                      bloc.mtdAmountTotal!)
                                                  : 0.0,
                                          // center: Text("80.0%"),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor:
                                              ColorResource.colorEA6D48,
                                          backgroundColor:
                                              ColorResource.colorD3D7DE,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              Constants.inr +
                                                  bloc.mtdAmountCompleted
                                                      .toString(),
                                              fontSize: FontSize.twelve,
                                              fontWeight: FontWeight.w700,
                                              color: ColorResource.color23375A,
                                            ),
                                            CustomText(
                                              Constants.inr +
                                                  bloc.mtdAmountTotal
                                                      .toString(),
                                              fontSize: FontSize.twelve,
                                              fontWeight: FontWeight.w700,
                                              color: ColorResource.color23375A,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  StaggeredGridView.countBuilder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    crossAxisCount: 4,
                                    itemCount: bloc.dashboardList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          switch (index) {
                                            case 0:
                                              bloc.add(PriorityFollowEvent());
                                              break;
                                            case 1:
                                              bloc.add(UntouchedCasesEvent());
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
                                              bloc.add(MyDeposistsEvent());
                                              break;
                                            case 6:
                                              bloc.add(
                                                  YardingAndSelfReleaseEvent());
                                              break;
                                            default:
                                            // AppUtils.showToast('');
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
                                                              .colorD3D7DE,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              75),
                                                    ),
                                                    child: Center(
                                                      child: CustomText(
                                                        bloc
                                                            .dashboardList[
                                                                index]
                                                            .title!,
                                                        fontSize:
                                                            FontSize.twelve,
                                                        lineHeight: 1,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: ColorResource
                                                            .color23375A,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox()
                                            : index == 6
                                                ? bloc.userType! ==
                                                        Constants.fieldagent
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
                                                                  .circular(75),
                                                        ),
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: CustomText(
                                                            bloc
                                                                .dashboardList[
                                                                    index]
                                                                .title!,
                                                            isSingleLine: false,
                                                            textAlign: TextAlign.center,
                                                            fontSize:
                                                                FontSize.twelve,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: ColorResource
                                                                .color23375A,
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox()
                                                : index == 6
                                                    ? bloc.userType ==
                                                            Constants.fieldagent
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
                                                            child: Center(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child:
                                                                    CustomText(
                                                                  bloc
                                                                      .dashboardList[
                                                                          index]
                                                                      .title!,
                                                                  fontSize:
                                                                      FontSize
                                                                          .twelve,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: ColorResource
                                                                      .color23375A,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                                  .circular(10),
                                                        ),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 5, 8, 5),
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
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                      // height: 40,
                                                                      width:
                                                                          105,
                                                                      // color: ColorResource.color101010,
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
                                                                      )),
                                                                  if (bloc
                                                                          .dashboardList[
                                                                              index]
                                                                          .image! !=
                                                                      '')
                                                                    SvgPicture.asset(bloc
                                                                        .dashboardList[
                                                                            index]
                                                                        .image!),
                                                                ],
                                                              ),
                                                              // const SizedBox(height: 4,),
                                                              const Spacer(),
                                                              Row(
                                                                children: [
                                                                  CustomText(
                                                                    bloc
                                                                        .dashboardList[
                                                                            index]
                                                                        .count!,
                                                                    fontSize:
                                                                        FontSize
                                                                            .fourteen,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: ColorResource
                                                                        .color23375A,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 6,
                                                                  ),
                                                                  CustomText(
                                                                    bloc
                                                                        .dashboardList[
                                                                            index]
                                                                        .subTitle!,
                                                                    fontSize:
                                                                        FontSize
                                                                            .fourteen,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: ColorResource
                                                                        .color23375A,
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                              CustomText(
                                                                Constants.inr +
                                                                    double.parse(bloc
                                                                            .dashboardList[
                                                                                index]
                                                                            .amountRs!)
                                                                        .toStringAsFixed(
                                                                            2),
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
                                  // const SizedBox(height: 5),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 2),
                                  //   child: CustomButton(
                                  //     Languages.of(context)!.help.toUpperCase(),
                                  //     fontSize: FontSize.sixteen,
                                  //     fontWeight: FontWeight.bold,
                                  //     textColor: ColorResource.color23375A,
                                  //     buttonBackgroundColor:
                                  //         ColorResource.colorBEC4CF,
                                  //     borderColor: ColorResource.colorBEC4CF,
                                  //     cardElevation: 0,
                                  //     cardShape: 75,
                                  //     isLeading: true,
                                  //     onTap: () {
                                  //       AppUtils.showToast(
                                  //           Languages.of(context)!.help);
                                  //     },
                                  //     trailingWidget: Row(
                                  //       children: [
                                  //         SvgPicture.asset(ImageResource.help),
                                  //         const SizedBox(
                                  //           width: 7,
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          )));
            }));
  }
}
