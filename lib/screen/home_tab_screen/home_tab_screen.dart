import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/Telecaller/screens/allocation_T/allocation_t.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/screen/allocation/allocation.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
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

// ignore: must_be_immutable
class HomeTabScreen extends StatefulWidget {
  AuthenticationBloc authenticationBloc;
  HomeTabScreen(this.authenticationBloc);
  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  late HomeTabBloc bloc;
  // late MapBloc mapBloc;

  String? title = StringResource.allocation.toUpperCase();

  TabController? _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    // bloc = BlocProvider.of<HomeTabBloc>(context);
    // allocationBloc = AllocationBloc()..add(AllocationInitialEvent());
    bloc = HomeTabBloc()..add(HomeTabInitialEvent());
    // mapBloc = MapBloc()..add(MapInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return BlocListener<HomeTabBloc, HomeTabState>(
      bloc: bloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      child: BlocBuilder<HomeTabBloc, HomeTabState>(
        bloc: bloc,
        builder: (context, state) {
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
                                  child: Container(
                                    height: 70,
                                    width: 45,
                                    child: TabBar(
                                      // isScrollable: true,
                                      // physics: const NeverScrollableScrollPhysics(),
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
                                              CustomText(
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
                                              CustomText(
                                                StringResource.dashboard,
                                                fontSize: FontSize.eight,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Tab(
                                          child: Stack(
                                            // alignment: Alignment.topLeft,
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
                                                  CustomText(
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
                          // Expanded(
                          //   child: Container(
                          //     color: ColorResource.color23375A,
                          //   ),
                          // )
                          Expanded(
                            child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  AllocationScreen(),
                                  DashboardScreen(),
                                  ProfileScreen(),
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
