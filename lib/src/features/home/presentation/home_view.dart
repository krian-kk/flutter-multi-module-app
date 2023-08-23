import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:design_system/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/gen/assets.gen.dart';
import 'package:origa/src/common_widgets/homeAppBarAction_widget.dart';
import 'package:origa/src/features/allocation/bloc/allocation_bloc.dart';
import 'package:origa/src/features/allocation/presentation/allocation_view.dart';
import 'package:origa/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/src/features/dashboard/dashboard_screen.dart';
import 'package:origa/src/features/home/presentation/search_view.dart';
import 'package:origa/src/features/profile/bloc/profile_bloc.dart';
import 'package:origa/src/features/profile/profile_screen.dart';
import 'package:repository/dashboard_repository.dart';
import 'package:repository/file_repository.dart';
import 'package:repository/profile_repository.dart';

import 'bloc/home_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => DashBoardRepositoryImpl()),
        RepositoryProvider(create: (context) => FileRepositoryImpl()),
        RepositoryProvider(create: (context) => ProfileRepositoryImpl()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => DashboardBloc(
                  repository: context.read<DashBoardRepositoryImpl>())),
          BlocProvider(create: (context) => AllocationBloc()),
          BlocProvider(
              create: (context) => ProfileBloc(
                  repository: ProfileRepositoryImpl(),
                  fileRepository: FileRepositoryImpl())),
        ],
        child: Material(
            child: Scaffold(
          backgroundColor: ColorResourceDesign.primaryColor,
          appBar: AppBar(
            backgroundColor: ColorResourceDesign.primaryColor,
            elevation: Sizes.p0,
            titleSpacing: Sizes.p24,
            title: BlocBuilder<HomeBloc, String>(builder: (context, state) {
              String appbarTitle = ConstantsResourceDesign.allocation;
              if (state != ConstantsResourceDesign.allocation) {
                appbarTitle = state;
              }
              return Text(
                appbarTitle,
                style: const TextStyle(
                  color: ColorResourceDesign.appTextPrimaryColor,
                  fontWeight: FontResourceDesign.textFontWeightSemiBold,
                  fontSize: Sizes.p16,
                ),
              );
            }),
            actions: <Widget>[
              BlocBuilder<HomeBloc, String>(
                builder: (context, state) {
                  return Row(
                    children: [
                      HomeAppBarAction(
                          label: ConstantsResourceDesign.allocation,
                          isActive: state == ConstantsResourceDesign.allocation
                              ? true
                              : false,
                          iconPath:
                              Assets.images.allocationPageAllocationAppbar),
                      HomeAppBarAction(
                        label: ConstantsResourceDesign.dashboard,
                        isActive: state == ConstantsResourceDesign.dashboard
                            ? true
                            : false,
                        iconPath: Assets.images.allocationPageDashboardAppbar,
                      ),
                      HomeAppBarAction(
                        label: ConstantsResourceDesign.profile,
                        isActive: state == ConstantsResourceDesign.profile
                            ? true
                            : false,
                        iconPath: Assets.images.allocationPageUserAppbar,
                      ),
                    ],
                  );
                },
              )
            ],
          ),
          body: BlocBuilder<HomeBloc, String>(builder: (context, currentPage) {
            if (currentPage == ConstantsResourceDesign.allocation) {
              return const AllocationView();
            } else if (currentPage == ConstantsResourceDesign.dashboard) {
              return const DashboardScreen();
            } else if (currentPage == ConstantsResourceDesign.profile) {
              return const ProfileScreen();
            } else {
              return const AllocationView();
            }
          }),
        )),
      ),
    );
  }
}
