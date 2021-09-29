import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/case_details_screen.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/dashboard/dashboard_screen.dart';
// import 'package:origa/screen/home_tab_screen/bloc/home_tab_bloc.dart';
// import 'package:origa/screen/home_tab_screen/bloc/home_tab_event.dart';
// import 'package:origa/screen/home_tab_screen/home_tab_screen.dart';
import 'package:origa/screen/search_allocation_details_screen/bloc/search_allocation_details_bloc.dart';
import 'package:origa/screen/search_allocation_details_screen/search_allocation_details_screen.dart';
import 'package:origa/screen/splash_screen/splash_screen.dart';

import 'authentication/authentication_bloc.dart';
import 'authentication/authentication_state.dart';

class AppRoutes {
  static const splashScreen = 'splash_screen';
  static const dashboardScreen = 'dashboard_screen';
  static const homeTabScreen = 'home_tab_screen';
  static const searchAllocationDetailsScreen =
      'search_allocation_details_screen';
  static const caseDetailsScreen = 'case_details_screen';
}

Route<dynamic> getRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashScreen:
      return _buildSplashScreen();
    case AppRoutes.dashboardScreen:
      return _buildDashboardScreen(settings);
    // case AppRoutes.homeTabScreen:
    //   return _buildHomePage(settings);
    case AppRoutes.searchAllocationDetailsScreen:
      return _buildSearchAllocationDetailsScreen(settings);
    case AppRoutes.caseDetailsScreen:
      return _buildCaseDetailsScreen(settings);
  }
  return _buildSplashScreen();
}

Route<dynamic> _buildSplashScreen() {
  return MaterialPageRoute(
    builder: (context) => addAuthBloc(context, PageBuilder.buildSplashScreen()),
  );
}

// Route<dynamic> _buildAllocationScreen(RouteSettings settings) {
//   return MaterialPageRoute(builder: (context) {
//     final AuthenticationBloc authBloc =
//         BlocProvider.of<AuthenticationBloc>(context);
//     return addAuthBloc(context, PageBuilder.buildAllocationPage(authBloc));
//   });
// }

Route<dynamic> _buildDashboardScreen(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) {
    final AuthenticationBloc authBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return addAuthBloc(context, PageBuilder.buildDashboardPage(authBloc));
  });
}

Route<dynamic> _buildSearchAllocationDetailsScreen(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) {
    return addAuthBloc(
        context, PageBuilder.buildSearchAllocationDetailsScreen());
  });
}

Route<dynamic> _buildCaseDetailsScreen(RouteSettings sttings) {
  return MaterialPageRoute(builder: (context) {
    // final CaseDetailsBloc authBloc = BlocProvider.of<CaseDetailsBloc>(context);
    return addAuthBloc(context, PageBuilder.buildCaseDetailsScreen());
  });
}

// Route<dynamic> _buildCaseDetailsScreen(RouteSettings setting) {
//   return MaterialPageRoute(builder: (context) {
//     CaseDetailsBloc authBloc =
//         BlocProvider.of<CaseDetailsBloc>(context, listen: true);
//     return addAuthBloc(context, PageBuilder.buildCaseDetailsScreen());
//   });
// }

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

  //  static Widget buildAllocationPage(AuthenticationBloc authBloc) {
  //   return MultiBlocProvider(
  //     providers: [
  //       BlocProvider<AllocationBloc>(
  //         create: (BuildContext context) {
  //           return AllocationBloc()..add(AllocationInitialEvent());
  //         },
  //       ),
  //     ],
  //     child: AllocationScreen(authBloc),
  //   );
  // }

  static Widget buildSearchAllocationDetailsScreen() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchAllocationDetailsBloc>(
          create: (BuildContext context) {
            return SearchAllocationDetailsBloc()
              ..add(SearchAllocationDetailsInitialEvent());
          },
        ),
      ],
      child: SearchAllocationDetailsScreen(),
    );
  }

  static Widget buildCaseDetailsScreen() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CaseDetailsBloc>(
          create: (BuildContext context) {
            return CaseDetailsBloc()..add(CaseDetailsInitialEvent());
          },
        ),
      ],
      child: CaseDetailsScreen(),
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
        Navigator.pushReplacementNamed(context, AppRoutes.caseDetailsScreen);
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
