import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/dashboard/dashboard_screen.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_bloc.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_event.dart';
import 'package:origa/screen/home_tab_screen/home_tab_screen.dart';
import 'package:origa/screen/splash_screen/splash_screen.dart';

import 'authentication/authentication_bloc.dart';
import 'authentication/authentication_state.dart';

class AppRoutes {
  static const splashScreen = 'splash_screen';
  static const dashboardScreen = 'dashboard_screen';
  static const homeTabScreen = 'home_tab_screen';
}

Route<dynamic> getRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashScreen:
      return _buildSplashScreen();
    case AppRoutes.dashboardScreen:
      return _buildDashboardScreen(settings);
    case AppRoutes.homeTabScreen:
      return _buildHomePage(settings);
  }
  return _buildSplashScreen();
}

Route<dynamic> _buildSplashScreen() {
  return MaterialPageRoute(
    builder: (context) => addAuthBloc(context, PageBuilder.buildSplashScreen()),
  );
}

Route<dynamic> _buildDashboardScreen(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) {
    final AuthenticationBloc authBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return addAuthBloc(context, PageBuilder.buildDashboardPage(authBloc));
  });
}

Route<dynamic> _buildHomePage(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) {
    final AuthenticationBloc authBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return addAuthBloc(context, PageBuilder.buildBottomTabPage(authBloc));
  });
}

class PageBuilder {
  // Prefer (✔️) - SplashScreen Screen
  static Widget buildSplashScreen() {
    return BlocProvider(
      create: (BuildContext context) {
        return BlocProvider.of<AuthenticationBloc>(context);
      },
      child: SplashScreen(),
      // return BlocProvider(
      // create: (BuildContext context) =>
      //     BlocProvider.of<AuthenticationBloc>(context),
      // child: SplashScreen()
    );
  }

  static Widget buildDashboardPage(AuthenticationBloc authBloc) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (BuildContext context) {
            return DashboardBloc()..add(DashboardInitialEvent());
          },
        ),
      ],
      child: DashboardScreen(authBloc),
    );
  }

  //BottomNavBar(authBloc);
  static Widget buildBottomTabPage(AuthenticationBloc authBloc) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeTabBloc>(
          create: (BuildContext context) {
            return HomeTabBloc()..add(HomeTabInitialEvent());
          },
        ),
      ],
      child: HomeTabScreen(authBloc),
    );
  }
}

Widget addAuthBloc(BuildContext context, Widget widget) {
  return BlocListener(
    bloc: BlocProvider.of<AuthenticationBloc>(context),
    listener: (context, state) {
      if (state is AuthenticationAuthenticated) {
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        // Navigator.pushReplacementNamed(context, AppRoutes.homeTabScreen);
        Navigator.pushReplacementNamed(context, AppRoutes.dashboardScreen);
        // Navigator.pushNamed(context, AppRoutes.homepatient);
      }
    },
    child: BlocBuilder(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      builder: (context, state) {
        return widget;
      },
    ),
  );
}
