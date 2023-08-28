import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/profile_screen.dart/profile_screen.dart';
import 'package:origa/src/features/allocation/presentation/allocation_view.dart';
import 'package:origa/src/features/allocation/presentation/priority_list_view/priority_bloc.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/src/features/dashboard/dashboard_screen.dart';
import 'package:origa/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:origa/src/features/home/presentation/bloc/home_event.dart';
import 'package:origa/src/features/home/presentation/bloc/home_state.dart';
import 'package:origa/src/features/home/presentation/search_view.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:repository/case_repository.dart';
import 'package:repository/dashboard_repository.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  String? title = StringResource.allocation.toUpperCase();
  String? internetAvailability;
  late final TabController? _controller;
  String navigationErrorMsg = 'Bad network connection';
  late BuildContext mContext;

  @override
  void initState() {
    super.initState();
    mContext = context;
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
    BlocProvider.of<HomeBloc>(context).add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => DashBoardRepositoryImpl()),
        // RepositoryProvider(create: (context) => FileRepositoryImpl()),
        // RepositoryProvider(create: (context) => ProfileRepositoryImpl()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeBloc()),
          BlocProvider(
              create: (context) => DashboardBloc(
                  repository: context.read<DashBoardRepositoryImpl>()))
        ],
        child: getHome(),
      ),
    );
  }

  Widget getHome() {
    return Material(
        child: Scaffold(
            backgroundColor: primaryColor,
            body: BlocBuilder<HomeBloc, HomeState>(
              bloc: BlocProvider.of<HomeBloc>(context),
              builder: (context, state) {
                if (state is TabHomeEvent) {
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
                        "You are offline",
                        color: Colors.white,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white),
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
                                padding:
                                    const EdgeInsets.only(left: 20, right: 4),
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
                                                if (internetAvailability !=
                                                    'none') {
                                                  setState(() {
                                                    title = StringResource
                                                        .allocation
                                                        .toUpperCase();
                                                  });
                                                }
                                                break;
                                              case 1:
                                                if (internetAvailability !=
                                                    'none') {
                                                  setState(() {
                                                    title = StringResource
                                                        .dashboard
                                                        .toUpperCase();
                                                  });
                                                } else {
                                                  AppUtils.noInternetSnackbar(
                                                      context);
                                                }
                                                break;
                                              case 2:
                                                if (internetAvailability !=
                                                    'none') {
                                                  setState(() {
                                                    title = StringResource
                                                        .profile
                                                        .toUpperCase();
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
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(12)),
                                              border: Border.all(
                                                  color: ColorResource
                                                      .colorECECEC),
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
                                                  const CustomText(
                                                    StringResource.allocation,
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
                                                  const CustomText(
                                                    StringResource.dashboard,
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
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      BlocProvider.of<HomeBloc>(
                                                                      context)
                                                                  .notificationCount !=
                                                              0
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5),
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
                                                      const CustomText(
                                                        StringResource.profile,
                                                        fontSize:
                                                            FontSize.eight,
                                                      ),
                                                    ],
                                                  ),
                                                  if (BlocProvider.of<HomeBloc>(
                                                              context)
                                                          .notificationCount !=
                                                      0)
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: ColorResource
                                                            .colorD5344C,
                                                      ),
                                                      height: 19,
                                                      width: 19,
                                                      child: CustomText(
                                                        BlocProvider.of<HomeBloc>(
                                                                        context)
                                                                    .notificationCount! >
                                                                10
                                                            ? '10+'
                                                            : BlocProvider.of<
                                                                        HomeBloc>(
                                                                    context)
                                                                .notificationCount
                                                                .toString(),
                                                        color: ColorResource
                                                            .colorFFFFFF,
                                                        fontSize: 8,
                                                        lineHeight: 1,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        textAlign:
                                                            TextAlign.center,
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
                                  child: MultiRepositoryProvider(
                                providers: [
                                  RepositoryProvider(
                                      create: (context) =>
                                          DashBoardRepositoryImpl()),
                                ],
                                child: MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                        create: (context) => DashboardBloc(
                                            repository: context.read<
                                                DashBoardRepositoryImpl>())),
                                    BlocProvider(
                                        create: (context) => DashboardBloc(
                                            repository: context.read<
                                                DashBoardRepositoryImpl>()))
                                  ],
                                  child: TabBarView(
                                      controller: _controller,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        RepositoryProvider(
                                          create: (context) =>
                                              CaseRepositoryImpl(),
                                          child: BlocProvider(
                                              create: (context) => PriorityBloc(
                                                  repository:
                                                      CaseRepositoryImpl()),
                                              child: const AllocationView()),
                                        ), //1
                                        DashboardScreen(), //2
                                        ProfileScreen(), //3
                                      ]),
                                ),
                              ))
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: blackOne,
              tooltip: search, // used by assistive technologies
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SearchView())),
              child: const Icon(
                Icons.search,
                size: Sizes.p30,
              ),
            )));
  }

  void indexMethod(int value) {
    setState(() {
      _controller!.animateTo(value);
    });
  }
}
