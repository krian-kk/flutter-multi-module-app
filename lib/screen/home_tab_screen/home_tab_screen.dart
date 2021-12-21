import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/screen/allocation/allocation.dart';
import 'package:origa/screen/dashboard/dashboard_screen.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_bloc.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_state.dart';
import 'package:origa/screen/profile_screen.dart/profile_screen.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_text.dart';
import 'bloc/home_tab_event.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  late HomeTabBloc bloc;

  String? title = StringResource.allocation.toUpperCase();

  TabController? _controller;

  @override
  void initState() {
    super.initState();

    bloc = HomeTabBloc()..add(HomeTabInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return BlocListener<HomeTabBloc, HomeTabState>(
      bloc: bloc,
      listener: (context, state) {},
      child: BlocBuilder<HomeTabBloc, HomeTabState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is HomeTabLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            backgroundColor: ColorResource.colorF7F8FA,
            body: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Expanded(
                    child: DefaultTabController(
                        length: 3,
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 8),
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
                                            setState(() {
                                              title = StringResource.allocation
                                                  .toUpperCase();
                                            });
                                            break;
                                          case 1:
                                            setState(() {
                                              title = StringResource.dashboard
                                                  .toUpperCase();
                                            });
                                            break;
                                          case 2:
                                            setState(() {
                                              title = StringResource.profile
                                                  .toUpperCase();
                                            });
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
                                              color: ColorResource.colorECECEC,
                                              width: 1.0),
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
                                                    MainAxisAlignment.center,
                                                children: [
                                                  bloc.notificationCount != 0
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
                                                    fontSize: FontSize.eight,
                                                  ),
                                                ],
                                              ),
                                              if (bloc.notificationCount != 0)
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: CustomText(
                                                    bloc.notificationCount! > 10
                                                        ? '10+'
                                                        : bloc.notificationCount
                                                            .toString(),
                                                    color: ColorResource
                                                        .colorFFFFFF,
                                                    fontSize: 8,
                                                    lineHeight: 1,
                                                    fontWeight: FontWeight.w700,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: ColorResource
                                                        .colorD5344C,
                                                  ),
                                                  height: 19,
                                                  width: 19,
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
                          const Expanded(
                            child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  AllocationScreen(), //1
                                  DashboardScreen(), //2
                                  ProfileScreen(), //3
                                ]),
                          )
                        ])),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
