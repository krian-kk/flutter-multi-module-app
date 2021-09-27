import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/screen/allocation/allocation.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/dashboard/dashboard_screen.dart';
import 'package:origa/screen/splash_screen/splash_screen.dart';

import 'authentication/authentication_bloc.dart';
import 'authentication/authentication_state.dart';

class AppRoutes {
  static const splashScreen = 'splash_screen';
  static const dashboardScreen = 'dashboard_screen';
  static const allocationScreen = 'allocation_screen';
}

Route<dynamic> getRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashScreen:
      return _buildSplashScreen();
    case AppRoutes.dashboardScreen:
      return _buildDashboardScreen(settings);
    case AppRoutes.allocationScreen:
      return _buildAllocationScreen(settings);
  }
  return _buildSplashScreen();
}

Route<dynamic> _buildSplashScreen() {
  return MaterialPageRoute(
    builder: (context) => addAuthBloc(context, PageBuilder.buildSplashScreen()),
  );
}

Route<dynamic> _buildAllocationScreen(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) {
    final AuthenticationBloc authBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return addAuthBloc(context, PageBuilder.buildAllocationPage(authBloc));
  });
}


Route<dynamic> _buildDashboardScreen(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) {
    final AuthenticationBloc authBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return addAuthBloc(context, PageBuilder.buildDashboardPage(authBloc));
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

// BottomNavBar(authBloc);
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

   static Widget buildAllocationPage(AuthenticationBloc authBloc) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllocationBloc>(
          create: (BuildContext context) {
            return AllocationBloc()..add(AllocationInitialEvent());
          },
        ),
      ],
      child: AllocationScreen(authBloc),
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
        // Navigator.pushReplacementNamed(context, AppRoutes.dashboardScreen);
        Navigator.pushReplacementNamed(context, AppRoutes.allocationScreen);
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
