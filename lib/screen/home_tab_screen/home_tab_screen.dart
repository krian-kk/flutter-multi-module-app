import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_bloc.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_state.dart';
import 'package:origa/singleton.dart';
import 'package:origa/src/features/allocation/bloc/allocation_bloc.dart';
import 'package:origa/src/features/allocation/presentation/allocation_view.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/src/features/dashboard/dashboard_screen.dart';
import 'package:origa/src/features/profile/bloc/profile_bloc.dart';
import 'package:origa/src/features/profile/profile_screen.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/preference_helper.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:repository/allocation_repository.dart';
import 'package:repository/case_repository.dart';
import 'package:repository/dashboard_repository.dart';
import 'package:repository/file_repository.dart';
import 'package:repository/profile_repository.dart';

import 'bloc/home_tab_event.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({Key? key, this.notificationData}) : super(key: key);
  final dynamic notificationData;

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen>
    with SingleTickerProviderStateMixin {
  late HomeTabBloc bloc;
  late String? title;
  String? internetAvailability;
  late final TabController? _controller;
  String navigationErrorMsg = 'Bad network connection';

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      vsync: this,
    );
    _controller!.addListener(() {
      if (internetAvailability == 'none') {
        if (_controller!.index != 0) {
          setState(() {
            _controller!.index = 0;
          });
        }
      }
    });
    internetChecking();
    bloc = HomeTabBloc()
      ..add(HomeTabInitialEvent(
          context: context, notificationData: widget.notificationData));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    title = Languages.of(context)!.allocation;
  }

  Future<void> internetChecking() async {
    await Connectivity().checkConnectivity().then((ConnectivityResult value) {
      setState(() {
        internetAvailability = value.name;
      });
      timeCalculateForOffline();
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult event) {
      setState(() {
        internetAvailability = event.name;
        if (internetAvailability == 'none') {
          if (_controller!.index != 0) {
            _controller!.index = 0;
            title = Languages.of(context)!.dashboard;
          }
        }
        timeCalculateForOffline();
      });
    });
  }

  Future<void> timeCalculateForOffline() async {
    try {
      const int nextLoginTime = 2;
      debugPrint(nextLoginTime.toString());
      if (nextLoginTime > 0) {
        Future<dynamic>.delayed(
          const Duration(milliseconds: nextLoginTime),
        ).asStream().listen((dynamic value) {
          if (Singleton.instance.isOfflineStorageFeatureEnabled) {
            PreferenceHelper.setPreference(
                Constants.appDataLoadedFromFirebaseTime, '');
            Singleton.instance.isOfflineStorageFeatureEnabled = false;
            PreferenceHelper.setPreference(
                Constants.appDataLoadedFromFirebase, false);
            Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
          }
        });
      } else {
        if (Singleton.instance.isOfflineStorageFeatureEnabled) {
          PreferenceHelper.setPreference(
              Constants.appDataLoadedFromFirebase, false);
          Singleton.instance.isOfflineStorageFeatureEnabled = false;
          PreferenceHelper.setPreference(
              Constants.appDataLoadedFromFirebaseTime, '');
          await Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => DashBoardRepositoryImpl()),
        RepositoryProvider(create: (context) => FileRepositoryImpl()),
        RepositoryProvider(create: (context) => ProfileRepositoryImpl()),
        RepositoryProvider(create: (context) => CaseRepositoryImpl()),
        RepositoryProvider(create: (context) => AllocationRepositoryImpl()),
      ],
      child: MultiBlocProvider(
        providers: [
          // BlocProvider(create: (context) => HomeBloc()),
          BlocProvider(
              create: (context) => AllocationBloc(
                    repository: context.read<AllocationRepositoryImpl>(),
                    caseRepository: context.read<CaseRepositoryImpl>(),
                  )),
          BlocProvider(
            create: (context) => DashboardBloc(
                repository: context.read<DashBoardRepositoryImpl>()),
          ),
          BlocProvider(
              create: (context) => ProfileBloc(
                    repository: context.read<ProfileRepositoryImpl>(),
                    fileRepository: context.read<FileRepositoryImpl>(),
                  ))
        ],
        child: getHome(),
      ),
    );
  }

  Widget getHome() {
    return BlocListener<HomeTabBloc, HomeTabState>(
      bloc: bloc,
      listener: (BuildContext context, HomeTabState state) async {
        if (state is NavigateTabState) {
          const CustomLoadingWidget();
          // NotificationDataModel notificationData =
          //     NotificationDataModel.fromJson(
          //         jsonDecode(state.notificationData!));
          switch (state.notificationData) {
            case '0':
              //{Tab index = 0 == Allocation}
              setState(() {
                _controller!.index = int.parse(state.notificationData);
              });
              break;
            case '1':
              //{Tab index = 1 == Dashboard}
              setState(() {
                _controller!.index = int.parse(state.notificationData);
              });
              break;
            case '2':
              //{Tab index = 2 == Profile}
              setState(() {
                _controller!.index = int.parse(state.notificationData);
              });
              break;
            case '3':
              // Here call the profile screen then open  chat screen
              setState(() {
                Singleton.instance.charScreenFromNotification = true;
                _controller!.index = 2;
              });
              break;
            case '4':
              // Initiate Dashboard bloc
              /* final DashboardBloc dashboardbloc = DashboardBloc();
              //Navigate MyVisit and MyCalls Screen
              dashboardbloc.add(AddFilterTimeperiodFromNotification(context));
              dashboardbloc.add(MyVisitsEvent());
              await Future<dynamic>.delayed(const Duration(milliseconds: 2000));
              if (dashboardbloc.myVisitsData.result != null) {
                OnclickNotificationNavigateScreen()
                    .myVisitsSheet(context, dashboardbloc);
              } else {
                AppUtils.showErrorToast(navigationErrorMsg);
              }*/
              break;
            case '5':
              if (Singleton.instance.usertype == Constants.fieldagent) {
                /*// Initiate Dashboard bloc
                final DashboardBloc dashboardbloc = DashboardBloc();
                //Navigate MyDeposists Screen
                dashboardbloc.add(AddFilterTimeperiodFromNotification(context));
                dashboardbloc.add(MyDeposistsEvent());
                await Future<dynamic>.delayed(
                    const Duration(milliseconds: 2000));
                if (dashboardbloc.myDeposistsData.result != null) {
                  OnclickNotificationNavigateScreen()
                      .myDeposistsSheet(context, dashboardbloc);
                } else {
                  AppUtils.showErrorToast(navigationErrorMsg);
                }*/
              }
              break;
            case '6':
              // Initiate Dashboard bloc
              /* final DashboardBloc dashboardbloc = DashboardBloc();
              //Navigate MyReceipts Screen
              dashboardbloc.add(AddFilterTimeperiodFromNotification(context));
              dashboardbloc.add(MyReceiptsEvent());
              await Future.delayed(const Duration(milliseconds: 2000));
              if (dashboardbloc.myReceiptsData.result != null) {
                OnclickNotificationNavigateScreen()
                    .myReceiptsSheet(context, dashboardbloc);
              } else {
                AppUtils.showErrorToast(navigationErrorMsg);
              }*/
              break;
            case '7':
              // //Navigate Case Detail Screen
              // Navigator.pushNamed(
              //   context,
              //   AppRoutes.caseDetailsScreen,
              //   arguments: {'caseID': notificationData.caseId},
              // );
              break;
            default:
          }
        }
      },
      child: BlocBuilder<HomeTabBloc, HomeTabState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is HomeTabLoadingState) {
            return const CustomLoadingWidget();
          }
          return Scaffold(
            backgroundColor: ColorResource.colorF7F8FA,
            bottomNavigationBar: Visibility(
              visible: internetAvailability != 'none' ? false : true,
              child: Container(
                alignment: Alignment.center,
                height: 30,
                color: ColorResource.colorE72C30,
                width: MediaQuery.of(context).size.width,
                child: CustomText(
                  Languages.of(context)!.youAreInOffline,
                  color: Colors.white,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis, color: Colors.white),
                ),
              ),
            ),
            body: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Expanded(
                    child: DefaultTabController(
                      length: 3,
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 4),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: CustomText(
                                    title!,
                                    fontSize: FontSize.sixteen,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResource.color23375A,
                                  )),
                              Expanded(
                                flex: 7,
                                child: SizedBox(
                                  height: 70,
                                  width: 45,
                                  child: TabBar(
                                    onTap: (index) {
                                      switch (index) {
                                        case 0:
                                          if (internetAvailability != 'none') {
                                            setState(() {
                                              title = Languages.of(context)!
                                                  .allocation;
                                            });
                                          }
                                          break;
                                        case 1:
                                          if (internetAvailability != 'none') {
                                            setState(() {
                                              title = Languages.of(context)!
                                                  .dashboard;
                                            });
                                          } else {
                                            AppUtils.noInternetSnackbar(
                                                context);
                                          }
                                          break;
                                        case 2:
                                          if (internetAvailability != 'none') {
                                            setState(() {
                                              title = Languages.of(context)!
                                                  .profile;
                                            });
                                          } else {
                                            AppUtils.noInternetSnackbar(
                                                context);
                                          }
                                          break;
                                        default:
                                      }
                                    },
                                    controller: _controller,
                                    labelColor: ColorResource.color23375A,
                                    unselectedLabelColor:
                                        ColorResource.color23375A,
                                    labelStyle: const TextStyle(
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.w600),
                                    unselectedLabelStyle: const TextStyle(
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.w600),
                                    indicator: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(12)),
                                        border: Border.all(
                                            color: ColorResource.colorECECEC),
                                        color: ColorResource.colorffffff),
                                    tabs: <Widget>[
                                      Tab(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                ImageResource.allocation),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            CustomText(
                                              Languages.of(context)!.allocation,
                                              fontSize: FontSize.eight,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Tab(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                ImageResource.dashboard),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            CustomText(
                                              Languages.of(context)!.dashboard,
                                              fontSize: FontSize.eight,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Tab(
                                        child: Stack(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                bloc.notificationCount != 0
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: SvgPicture.asset(
                                                            ImageResource
                                                                .homeTabProfile),
                                                      )
                                                    : SvgPicture.asset(
                                                        ImageResource
                                                            .homeTabProfile),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                CustomText(
                                                  Languages.of(context)!
                                                      .profile,
                                                  fontSize: FontSize.eight,
                                                ),
                                              ],
                                            ),
                                            if (bloc.notificationCount != 0)
                                              Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      ColorResource.colorD5344C,
                                                ),
                                                height: 19,
                                                width: 19,
                                                child: CustomText(
                                                  bloc.notificationCount! > 10
                                                      ? '10+'
                                                      : bloc.notificationCount
                                                          .toString(),
                                                  color:
                                                      ColorResource.colorFFFFFF,
                                                  fontSize: 8,
                                                  lineHeight: 1,
                                                  fontWeight: FontWeight.w700,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                              controller: _controller,
                              physics: const NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                AllocationScreen(myValueSetter: (value) {
                                  indexMethod(value);
                                }), //1
                                const DashboardScreen(), //2
                                const ProfileScreen(), //3
                              ]),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void indexMethod(int value) {
    setState(() {
      _controller!.animateTo(value);
    });
    debugPrint('Tab controls-> $value');
  }
}
