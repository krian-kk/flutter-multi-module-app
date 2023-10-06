import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:languages/language_english.dart';
import 'package:origa/models/case_details_navigation_model.dart';
import 'package:origa/models/return_value_model.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/src/features/dashboard/presentation/broken_ptp/broken_ptp.dart';
import 'package:origa/src/features/dashboard/presentation/my_recipts/my_receipts.dart';
import 'package:origa/src/features/dashboard/presentation/my_self_release/my_self_release.dart';
import 'package:origa/src/features/dashboard/presentation/my_visit/my_visits.dart';
import 'package:origa/src/features/dashboard/presentation/priority/my_deposits/my_deposists.dart';
import 'package:origa/src/features/dashboard/presentation/priority/priority_follow_up_bottomsheet.dart';
import 'package:origa/src/features/dashboard/presentation/untouched_case/untouched_cases.dart';
import 'package:origa/src/features/dashboard/presentation/yarding_selfrelese/yarding_self_release.dart';
import 'package:origa/src/routing/app_router.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/skeleton.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/percent_indicatior_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  Widget userActivity(
      {String? header,
      String? count,
      Color? backgroundColor,
      required Color leadingColor}) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(10)),
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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DashboardBloc>(context).add(DashboardInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocListener<DashboardBloc, DashboardState>(
        bloc: BlocProvider.of<DashboardBloc>(context),
        listener: (BuildContext context, DashboardState state) async {
          if (state is SetTimeperiodValueState) {
            BlocProvider.of<DashboardBloc>(context).selectedFilter =
                Constants.today;
            BlocProvider.of<DashboardBloc>(context).selectedFilterIndex = '0';
          }

          if (state is ClickToCardLoadingState) {
            BlocProvider.of<DashboardBloc>(context).isClickToCardLoading =
                !BlocProvider.of<DashboardBloc>(context).isClickToCardLoading;
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
          if (state is MySelfReleaseState) {
            mySelfReleaseSheet(context);
          }

          if (state is MyVisitsState) {
            myVisitsSheet(context);
          }

          if (state is MyDepositState) {
            myDepositsSheet(context);
          }

          if (state is YardingAndSelfRelease) {
            yardingSelfReleaseSheet(context);
          }

          if (state is NavigateCaseDetailState) {
            final dynamic returnValue = await Navigator.pushNamed(
              context,
              AppRouter.caseDetailsScreen,
              arguments: CaseDetailsNaviagationModel(state.paramValues),
            );
            final RetrunValueModel retrunModelValue = RetrunValueModel.fromJson(
                Map<String, dynamic>.from(returnValue));

            if (retrunModelValue.isSubmitForMyVisit) {
              BlocProvider.of<DashboardBloc>(context).add(
                  UpdateMyVisitCasesEvent(retrunModelValue.caseId,
                      retrunModelValue.returnCaseAmount,
                      isNotMyReceipts: !(state.isMyReceipts)));
              if (state.unTouched) {
                BlocProvider.of<DashboardBloc>(context).add(
                    UpdateUnTouchedCasesEvent(retrunModelValue.caseId,
                        retrunModelValue.returnCaseAmount));
              }
              if (state.isPriorityFollowUp) {
                BlocProvider.of<DashboardBloc>(context).add(
                    UpdatePriorityFollowUpCasesEvent(retrunModelValue.caseId,
                        retrunModelValue.returnCaseAmount));
              }
              if (state.isBrokenPTP) {
                BlocProvider.of<DashboardBloc>(context)
                    .add(UpdateBrokenCasesEvent(
                  retrunModelValue.caseId,
                  retrunModelValue.returnCaseAmount,
                ));
              }
              if (retrunModelValue.eventType == Constants.collections) {
                BlocProvider.of<DashboardBloc>(context).add(
                    UpdateMyReceiptsCasesEvent(retrunModelValue.caseId,
                        retrunModelValue.returnCollectionAmount));
              }
            }
          }

          if (state is NavigateSearchState) {
            context.push(context.namedLocation('search'));
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (BuildContext context, DashboardState state) {
          if (state is DashboardLoadingState) {
            return const SkeletonLoading();
          }
          return BlocProvider.of<DashboardBloc>(context)
                  .isNoInternetAndServerError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(BlocProvider.of<DashboardBloc>(context)
                          .noInternetAndServerErrorMsg!),
                      const SizedBox(
                        height: 5,
                      ),
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<DashboardBloc>(context)
                                .add(DashboardInitialEvent());
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 13),
                                      child: CustomText(
                                        BlocProvider.of<DashboardBloc>(context)
                                                .todayDate ??
                                            '',
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
                                              header:
                                                  BlocProvider.of<DashboardBloc>(
                                                                  context)
                                                              .userType ==
                                                          Constants.fieldagent
                                                      ? LanguageEn().customerMet
                                                      : LanguageEn()
                                                          .connected
                                                          .trim(),
                                              count: BlocProvider.of<
                                                      DashboardBloc>(context)
                                                  .met
                                                  .toString(),
                                              backgroundColor:
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
                                              header:
                                                  BlocProvider.of<DashboardBloc>(
                                                                  context)
                                                              .userType ==
                                                          Constants.fieldagent
                                                      ? LanguageEn()
                                                          .customerNotMet
                                                      : LanguageEn()
                                                          .unreachable
                                                          .trim(),
                                              count: BlocProvider.of<
                                                      DashboardBloc>(context)
                                                  .notMet
                                                  .toString(),
                                              backgroundColor:
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
                                              header:
                                                  LanguageEn().invalid.trim(),
                                              count: BlocProvider.of<
                                                      DashboardBloc>(context)
                                                  .invalid
                                                  .toString(),
                                              backgroundColor:
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
                                            LanguageEn().mtdResolutionProgress,
                                            fontSize: FontSize.twelve,
                                            fontWeight: FontWeight.w700,
                                            color: ColorResource.color23375A,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          CustomText(
                                            LanguageEn().customer.toUpperCase(),
                                            color: ColorResource.color23375A,
                                            fontSize: FontSize.ten,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          PercentageIndicatorWidget(
                                            padding: const EdgeInsets.all(4),
                                            animation: true,
                                            addAutomaticKeepAlive: false,
                                            lineHeight: 12.0,
                                            animationDuration: 2500,
                                            // Result must change
                                            percent: (BlocProvider.of<DashboardBloc>(
                                                                context)
                                                            .mtdCaseCompleted! ==
                                                        0 &&
                                                    BlocProvider.of<DashboardBloc>(
                                                                context)
                                                            .mtdCaseTotal! ==
                                                        0)
                                                ? 0.0
                                                : (BlocProvider.of<DashboardBloc>(
                                                                context)
                                                            .mtdCaseCompleted! <=
                                                        BlocProvider.of<DashboardBloc>(
                                                                context)
                                                            .mtdCaseTotal!)
                                                    ? (BlocProvider.of<DashboardBloc>(
                                                                context)
                                                            .mtdCaseCompleted! /
                                                        BlocProvider.of<DashboardBloc>(
                                                                context)
                                                            .mtdCaseTotal!)
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .mtdCaseCompleted
                                                    .toString(),
                                                fontSize: FontSize.sixteen,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    ColorResource.color23375A,
                                              ),
                                              CustomText(
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .mtdCaseTotal
                                                    .toString(),
                                                fontSize: FontSize.sixteen,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    ColorResource.color23375A,
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
                                            LanguageEn().amount.toUpperCase(),
                                            color: ColorResource.color23375A,
                                            fontSize: FontSize.ten,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          PercentageIndicatorWidget(
                                            padding: const EdgeInsets.all(4),
                                            addAutomaticKeepAlive: false,
                                            animation: true,
                                            lineHeight: 12.0,
                                            animationDuration: 2500,
                                            percent: (BlocProvider.of<DashboardBloc>(
                                                                context)
                                                            .mtdAmountCompleted! ==
                                                        0 &&
                                                    BlocProvider.of<DashboardBloc>(
                                                                context)
                                                            .mtdAmountTotal! ==
                                                        0)
                                                ? 0.0
                                                : (BlocProvider.of<DashboardBloc>(
                                                                context)
                                                            .mtdAmountCompleted! <=
                                                        BlocProvider.of<DashboardBloc>(
                                                                context)
                                                            .mtdAmountTotal!)
                                                    ? (BlocProvider.of<DashboardBloc>(
                                                                context)
                                                            .mtdAmountCompleted! /
                                                        BlocProvider.of<DashboardBloc>(
                                                                context)
                                                            .mtdAmountTotal!)
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                Constants.inr +
                                                    BlocProvider.of<
                                                                DashboardBloc>(
                                                            context)
                                                        .mtdAmountCompleted
                                                        .toString(),
                                                fontSize: FontSize.twelve,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    ColorResource.color23375A,
                                              ),
                                              CustomText(
                                                Constants.inr +
                                                    BlocProvider.of<
                                                                DashboardBloc>(
                                                            context)
                                                        .mtdAmountTotal
                                                        .toString(),
                                                fontSize: FontSize.twelve,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    ColorResource.color23375A,
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
                                      itemCount: BlocProvider.of<DashboardBloc>(
                                              context)
                                          .dashboardList
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            switch (index) {
                                              case 0:
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(PriorityFollowEvent());
                                                break;
                                              case 1:
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(UntouchedCasesEvent());
                                                break;
                                              case 2:
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(BrokenPTPEvent());
                                                break;
                                              case 3:
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(
                                                        SetTimePeriodValueEvent());
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(MyReceiptsEvent());
                                                break;
                                              case 4:
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(
                                                        SetTimePeriodValueEvent());
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(MyVisitsEvent());
                                                break;
                                              case 5:
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(
                                                        SetTimePeriodValueEvent());
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(MyDepositsEvent());
                                                break;
                                              case 6:
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(
                                                        YardingAndSelfReleaseEvent());
                                                break;
                                              case 7:
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(MySelfReleaseEvent());
                                                break;
                                              default:
                                            }
                                          },
                                          child: index == 7
                                              ? BlocProvider.of<DashboardBloc>(
                                                              context)
                                                          .userType! ==
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
                                                                .circular(75),
                                                      ),
                                                      child: Center(
                                                        child: CustomText(
                                                          BlocProvider.of<
                                                                      DashboardBloc>(
                                                                  context)
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
                                              : index == 5
                                                  ? BlocProvider.of<DashboardBloc>(
                                                                  context)
                                                              .userType! ==
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
                                                              BlocProvider.of<
                                                                          DashboardBloc>(
                                                                      context)
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
                                                      ? BlocProvider.of<DashboardBloc>(
                                                                      context)
                                                                  .userType! ==
                                                              Constants
                                                                  .fieldagent
                                                          ? Card(
                                                              elevation: 0,
                                                              color: ColorResource
                                                                  .colorffffff,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                side:
                                                                    const BorderSide(
                                                                        width:
                                                                            0.5),
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
                                                                  BlocProvider.of<
                                                                              DashboardBloc>(
                                                                          context)
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
                                                          ? BlocProvider.of<DashboardBloc>(
                                                                          context)
                                                                      .userType ==
                                                                  Constants
                                                                      .fieldagent
                                                              ? Card(
                                                                  elevation: 0,
                                                                  color: ColorResource
                                                                      .colorffffff,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side: const BorderSide(
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
                                                                        BlocProvider.of<DashboardBloc>(context)
                                                                            .dashboardList[index]
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
                                                                              BlocProvider.of<DashboardBloc>(context).dashboardList[index].title!,
                                                                              fontSize: FontSize.twelve,
                                                                              fontWeight: FontWeight.w700,
                                                                              color: ColorResource.color23375A,
                                                                            )),
                                                                        if (BlocProvider.of<DashboardBloc>(context).dashboardList[index].image! !=
                                                                            '')
                                                                          SvgPicture.asset(BlocProvider.of<DashboardBloc>(context)
                                                                              .dashboardList[index]
                                                                              .image!),
                                                                      ],
                                                                    ),
                                                                    const Spacer(),
                                                                    Row(
                                                                      children: [
                                                                        CustomText(
                                                                          BlocProvider.of<DashboardBloc>(context)
                                                                              .dashboardList[index]
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
                                                                          BlocProvider.of<DashboardBloc>(context)
                                                                              .dashboardList[index]
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
                                                                          double.parse(BlocProvider.of<DashboardBloc>(context).dashboardList[index].amountRs!)
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
                                                      : index == 7
                                                          ? 0.8
                                                          : 1.3),
                                      mainAxisSpacing: 4.0,
                                      crossAxisSpacing: 4.0,
                                    ),
                                  ],
                                ),
                              ),
                            ))),
                    if (BlocProvider.of<DashboardBloc>(context)
                        .isClickToCardLoading)
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

  void priorityFollowUpSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              bottom: false,
              child: PriorityFollowUpBottomSheet(
                  BlocProvider.of<DashboardBloc>(buildContext)));
        });
  }

  void brokenPTPSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              bottom: false,
              child: BrokenPTPBottomSheet(
                  BlocProvider.of<DashboardBloc>(buildContext)));
        });
  }

  void untouchedCasesSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              bottom: false,
              child: UntouchedCasesBottomSheet(
                  BlocProvider.of<DashboardBloc>(buildContext)));
        });
  }

  void myVisitsSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              bottom: false,
              child: MyVisitsBottomSheet(
                  BlocProvider.of<DashboardBloc>(buildContext)));
        });
  }

  void myReceiptsSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return BlocProvider.value(
              value: BlocProvider.of<DashboardBloc>(buildContext),
              child: const SafeArea(
                  bottom: false, child: MyReceiptsBottomSheet()));
        });
  }

  void myDepositsSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              bottom: false,
              child: MyDepositsBottomSheet(
                  BlocProvider.of<DashboardBloc>(buildContext)));
        });
  }

  void yardingSelfReleaseSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
              bottom: false,
              child: YardingAndSelfRelease(
                  BlocProvider.of<DashboardBloc>(buildContext)));
        });
  }

  void mySelfReleaseSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return BlocProvider.value(
              value: BlocProvider.of<DashboardBloc>(buildContext),
              child: const SafeArea(
                  bottom: false, child: MySelfReleaseBottomSheet()));
        });
  }
}
