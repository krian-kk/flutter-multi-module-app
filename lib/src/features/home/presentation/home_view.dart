import 'package:origa/src/features/authentication/data/auth_repository.dart';
import 'package:origa/src/features/authentication/presentation/sign_in/bloc/signIn_bloc.dart';
import 'package:origa/src/features/home/presentation/search_view.dart';
import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:design_system/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../gen/assets.gen.dart';
import '../../../common_widgets/homeAppBarAction_widget.dart';
import '../../allocation/presentation/allocation_view.dart';
import '../../dashboard/presentation/dashboard_view.dart';
import '../../profile/presentation/profile_view.dart';
import 'bloc/home_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepositoryImpl(),
      child: BlocProvider(
        create: (context) => HomeBloc(),
        child: getHome(),
      ),
    );
  }

  Widget getHome() {
    return Material(
        child: Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(
              backgroundColor: primaryColor,
              elevation: Sizes.p0,
              titleSpacing: Sizes.p24,
              title: BlocBuilder<HomeBloc, String>(builder: (context, state) {
                String appbarTitle = allocation;
                if (state != allocation) {
                  appbarTitle = state;
                }
                return Text(
                  appbarTitle,
                  style: const TextStyle(
                    color: appTextPrimaryColor,
                    fontWeight: textFontWeightSemiBold,
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
                            label: allocation,
                            isActive: state == allocation ? true : false,
                            iconPath:
                                Assets.images.allocationPageAllocationAppbar),
                        HomeAppBarAction(
                          label: dashboard,
                          isActive: state == dashboard ? true : false,
                          iconPath: Assets.images.allocationPageDashboardAppbar,
                        ),
                        HomeAppBarAction(
                          label: profile,
                          isActive: state == profile ? true : false,
                          iconPath: Assets.images.allocationPageUserAppbar,
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
            body:
                BlocBuilder<HomeBloc, String>(builder: (context, currentPage) {
              return getPage(currentPage);
            }),
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

  Widget getPage(String currentPage) {
    if (currentPage == allocation) {
      return const AllocationView();
    } else if (currentPage == dashboard) {
      return DashboardView();
    } else if (currentPage == profile) {
      return const ProfileView();
    } else {
      return const AllocationView();
    }
  }
}
