import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/broken_ptp/broken_ptp.dart';
import 'package:origa/screen/message_screen/message.dart';
import 'package:origa/screen/my_deposists/my_deposists.dart';
import 'package:origa/screen/my_recipts/my_receipts.dart';
import 'package:origa/screen/my_visit/my_visits.dart';
import 'package:origa/screen/priority_follow_up/priority_follow_up_bottomsheet.dart';
import 'package:origa/screen/search_screen/allocation_search_screen.dart';
import 'package:origa/screen/search_screen/dashboard_search_screen.dart';
import 'package:origa/screen/untouched_case/untouched_cases.dart';
import 'package:origa/screen/yarding_selfrelese/yarding_self_release.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_card_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../router.dart';

class DashboardScreen extends StatefulWidget {
  final String? loginType;
  const DashboardScreen(this.loginType, {Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String version = "";
  late DashboardBloc bloc;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    bloc = DashboardBloc()..add(DashboardInitialEvent());
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocListener<DashboardBloc, DashboardState>(
        bloc: bloc,
        listener: (BuildContext context, DashboardState state) {
          if (state is PriorityFollowState) {
            priorityFollowUpSheet(context);
          }

          if (state is UntouchedCasesState) {
            untouchedCasesSheet(context);
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
            Navigator.pushNamed(context, AppRoutes.caseDetailsScreen,
                arguments: true);
          }

          if (state is NavigateSearchState) {
            searchShowBottomSheet();
            // Navigator.pushNamed(context, AppRoutes.SearchScreen);
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
            bloc: bloc,
            builder: (BuildContext context, DashboardState state) {
              if (state is DashboardLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Scaffold(
                  backgroundColor: ColorResource.colorF7F8FA,
                  body: SafeArea(
                      bottom: false,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 13),
                                child: CustomText(
                                  '15th Oct, 2020',
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
                                  children: [
                                    Expanded(
                                        flex: 4,
                                        child: Container(
                                          child: userActivity(
                                            header: widget.loginType == 'fos'
                                                ? Languages.of(context)!
                                                    .customerMet
                                                : Languages.of(context)!
                                                    .connected
                                                    .trim(),
                                            count: '20',
                                            backgrountColor:
                                                ColorResource.colorE0ECDF,
                                            leadingColor:
                                                ColorResource.color73C170,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: userActivity(
                                            header: widget.loginType == 'fos'
                                                ? Languages.of(context)!
                                                    .customerNotMet
                                                : Languages.of(context)!
                                                    .unreachable
                                                    .trim(),
                                            count: '10',
                                            backgrountColor:
                                                ColorResource.colorF2EEDC,
                                            leadingColor:
                                                ColorResource.colorE5C55B,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: GestureDetector(
                                          onTap: () {
                                            // Navigator.push(context, CupertinoPageRoute(builder: (context)=>MessageChatRoomScreen()));
                                          },
                                          child: Container(
                                            child: userActivity(
                                              header: Languages.of(context)!
                                                  .invalid
                                                  .trim(),
                                              count: '10',
                                              backgrountColor:
                                                  ColorResource.colorF4ECEF,
                                              leadingColor:
                                                  ColorResource.colorF1BCC4,
                                            ),
                                          ),
                                        )),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      padding: EdgeInsets.all(4),
                                      animation: true,
                                      lineHeight: 12.0,
                                      animationDuration: 2500,
                                      percent: 0.25,
                                      // center: Text("80.0%"),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: ColorResource.colorEA6D48,
                                      backgroundColor:
                                          ColorResource.colorD3D7DE,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          '40',
                                          fontSize: FontSize.sixteen,
                                          fontWeight: FontWeight.w700,
                                          color: ColorResource.color23375A,
                                        ),
                                        CustomText(
                                          '400',
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      padding: EdgeInsets.all(4),
                                      animation: true,
                                      lineHeight: 12.0,
                                      animationDuration: 2500,
                                      percent: 0.4,
                                      // center: Text("80.0%"),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: ColorResource.colorEA6D48,
                                      backgroundColor:
                                          ColorResource.colorD3D7DE,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          '₹ 3,979.67',
                                          fontSize: FontSize.twelve,
                                          fontWeight: FontWeight.w700,
                                          color: ColorResource.color23375A,
                                        ),
                                        CustomText(
                                          '₹ 3,97,553.67',
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
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 4,
                                itemCount: bloc.dashboardList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: GestureDetector(
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
                                            bloc.add(MyReceiptsEvent());
                                            break;
                                          case 4:
                                            bloc.add(MyVisitsEvent());
                                            break;
                                          case 5:
                                            bloc.add(MyDeposistsEvent());
                                            break;
                                          case 6:
                                            bloc.add(
                                                YardingAndSelfReleaseEvent());
                                            break;
                                          default:
                                            AppUtils.showToast('');
                                        }
                                      },
                                      child: index == 5
                                          ? Card(
                                              elevation: 0,
                                              color: ColorResource.colorD3D7DE,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: ColorResource
                                                        .colorD3D7DE,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(75),
                                              ),
                                              child: Center(
                                                child: CustomText(
                                                  bloc.dashboardList[index]
                                                      .title!,
                                                  fontSize: FontSize.twelve,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      ColorResource.color23375A,
                                                ),
                                              ),
                                            )
                                          : index == 6
                                              ? Card(
                                                  elevation: 0,
                                                  color:
                                                      ColorResource.colorffffff,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: ColorResource
                                                            .color23375A,
                                                        width: 0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            75),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: CustomText(
                                                        bloc
                                                            .dashboardList[
                                                                index]
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
                                              : Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    // ignore: prefer_const_constructors
                                                    side: BorderSide(
                                                        color: ColorResource
                                                            .colorDADADA,
                                                        width: 0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(12, 7, 10, 8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          // height: 50,
                                                          // color: ColorResource.color484848,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                  // height: 40,
                                                                  width: 105,
                                                                  // color: ColorResource.color101010,
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
                                                        ),
                                                        // const SizedBox(height: 4,),
                                                        const Spacer(),
                                                        Row(
                                                          children: [
                                                            CustomText(
                                                              '40',
                                                              fontSize: FontSize
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
                                                              'Customer',
                                                              fontSize: FontSize
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
                                                          bloc
                                                              .dashboardList[
                                                                  index]
                                                              .amountRs!,
                                                          fontSize:
                                                              FontSize.sixteen,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: ColorResource
                                                              .color23375A,
                                                        ),
                                                      ],
                                                    ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: CustomButton(
                                  'HELP',
                                  fontSize: FontSize.sixteen,
                                  fontWeight: FontWeight.bold,
                                  textColor: ColorResource.color23375A,
                                  buttonBackgroundColor:
                                      ColorResource.colorBEC4CF,
                                  borderColor: ColorResource.colorBEC4CF,
                                  cardElevation: 0,
                                  cardShape: 75,
                                  isLeading: true,
                                  onTap: () {
                                    AppUtils.showToast('help');
                                  },
                                  trailingWidget: Row(
                                    children: [
                                      SvgPicture.asset(ImageResource.help),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )));
            }));
  }

  Widget userActivity(
      {String? header,
      String? count,
      Color? backgrountColor,
      required Color leadingColor}) {
    return Container(
      height: 55,
      width: 125,
      decoration: BoxDecoration(
          color: backgrountColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 6,
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
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  header!,
                  color: ColorResource.color23375A,
                  fontSize: FontSize.twelve,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  count!,
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

  searchShowBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                SizedBox(
                    height: MediaQuery.of(context).size.height * 1.0,
                    child: DashboardSearchScreen(
                      bloc: bloc,
                    ))));
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
}
