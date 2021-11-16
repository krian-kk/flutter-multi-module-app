import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/case_details_screen.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_bloc.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_event.dart';
import 'package:origa/screen/home_tab_screen/home_tab_screen.dart';
import 'package:origa/screen/login_screen/bloc/login_bloc.dart';
import 'package:origa/screen/login_screen/login_screen.dart';
import 'package:origa/screen/search_allocation_details_screen/bloc/search_allocation_details_bloc.dart';
import 'package:origa/screen/search_allocation_details_screen/search_allocation_details_screen.dart';
import 'package:origa/screen/splash_screen/splash_screen.dart';

import 'authentication/authentication_bloc.dart';
import 'authentication/authentication_state.dart';

class AppRoutes {
  static const String splashScreen = 'splash_screen';
  static const String loginScreen = 'login_screen';
  static const String homeTabScreen = 'homeTab_screen';
  static const String dashboardScreen = 'dashboard_screen';
  static const String allocationScreen = 'allocation_screen';
  static const String searchAllocationDetailsScreen =
      'search_allocation_details_screen';
  static const String caseDetailsScreen = 'case_details_screen';
  // static const String addressScreen = 'address_screen';
  // static const String phoneScreen = 'phone_screen';
}

Route<dynamic> getRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashScreen:
      return _buildSplashScreen();
    case AppRoutes.homeTabScreen:
      return _buildHomeTabScreen(settings);
    // case AppRoutes.dashboardScreen:
    //   return _buildDashboardScreen();
    // case AppRoutes.allocationScreen:
    //   return _buildAllocationScreen();
    case AppRoutes.searchAllocationDetailsScreen:
      return _buildSearchAllocationDetailsScreen();
    case AppRoutes.caseDetailsScreen:
      return _buildCaseDetailsScreen();
    case AppRoutes.loginScreen:
      return _buildLoginScreen(settings);
    // case AppRoutes.addressScreen:
    //   return _buildAddressScreen();
    // case AppRoutes.phoneScreen:
    //   return _buildPhoneScreen();
  }
  return _buildSplashScreen();
}

Route<dynamic> _buildSplashScreen() {
  return MaterialPageRoute(
    builder: (context) => addAuthBloc(context, PageBuilder.buildSplashScreen()),
  );
}

Route<dynamic> _buildHomeTabScreen(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) {
    final AuthenticationBloc authBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return addAuthBloc(context, PageBuilder.buildHomeTabScreen(authBloc));
  });
}

Route<dynamic> _buildLoginScreen(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) {
    final AuthenticationBloc authBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return addAuthBloc(context, PageBuilder.buildLoginScreen(authBloc));
  });
}
// Route<dynamic> _buildHomeTabScreen(RouteSettings settings) {
//   return MaterialPageRoute(
//     builder: (context) =>
//         addAuthBloc(context, PageBuilder.buildHomeTabScreen(authBloc)),
//   );
// }

// Route<dynamic> _buildAllocationScreen() {
//   return MaterialPageRoute(
//     builder: (context) =>
//         addAuthBloc(context, PageBuilder.buildAllocationPage()),
//   );
// }

// Route<dynamic> _buildDashboardScreen() {
//   return MaterialPageRoute(
//     builder: (context) =>
//         addAuthBloc(context, PageBuilder.buildDashboardPage()),
//   );
// }

Route<dynamic> _buildSearchAllocationDetailsScreen() {
  return MaterialPageRoute(
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildSearchAllocationDetailsPage()),
  );
}

Route<dynamic> _buildCaseDetailsScreen() {
  return MaterialPageRoute(
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildCaseDetailsPage()),
  );
}

// Route<dynamic> _buildAddressScreen() {
//   return MaterialPageRoute(
//     builder: (context) => addAuthBloc(context, PageBuilder.buildAddressPage()),
//   );
// }

// Route<dynamic> _buildPhoneScreen() {
//   return MaterialPageRoute(
//     builder: (context) => addAuthBloc(context, PageBuilder.buildPhonePage()),
//   );
// }

class PageBuilder {
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

  static Widget buildHomeTabScreen(AuthenticationBloc authBloc) {
    return BlocProvider(
      create: (BuildContext context) =>
          BlocProvider.of<HomeTabBloc>(context)..add(HomeTabInitialEvent()),
      child: HomeTabScreen(authBloc),
    );
  }

  static Widget buildLoginScreen(AuthenticationBloc authBloc) {
    return BlocProvider(
      create: (BuildContext context) =>
          BlocProvider.of<LoginBloc>(context)..add(LoginInitialEvent()),
      child: LoginScreen(authBloc),
    );
  }

  // static Widget buildDashboardPage() {
  //   return BlocProvider(
  //     create: (BuildContext context) =>
  //         BlocProvider.of<DashboardBloc>(context)..add(DashboardInitialEvent()),
  //     child: DashboardScreen(),
  //   );
  // }

  // static Widget buildAllocationPage() {
  //   return BlocProvider(
  //     create: (BuildContext context) => BlocProvider.of<AllocationBloc>(context)
  //       ..add(AllocationInitialEvent()),
  //     child: AllocationScreen(),
  //   );
  // }

  static Widget buildSearchAllocationDetailsPage() {
    return BlocProvider(
      create: (BuildContext context) =>
          BlocProvider.of<SearchAllocationDetailsBloc>(context)
            ..add(SearchAllocationDetailsInitialEvent()),
      child: const SearchAllocationDetailsScreen(),
    );
  }

  static Widget buildCaseDetailsPage() {
    return BlocProvider(
      create: (BuildContext context) =>
          BlocProvider.of<CaseDetailsBloc>(context)
            ..add(CaseDetailsInitialEvent()),
      child: const CaseDetailsScreen(),
    );
  }

  // static Widget buildAddressPage() {
  //   return BlocProvider(
  //     create: (BuildContext context) =>
  //         BlocProvider.of<AddressBloc>(context)..add(AddressInitialEvent()),
  //     child: AddressScreen(),
  //   );
  // }

  // static Widget buildPhonePage() {
  //   return BlocProvider(
  //     create: (BuildContext context) =>
  //         BlocProvider.of<PhoneBloc>(context)..add(PhoneInitialEvent()),
  //     child: PhoneScreen(),
  //   );
  // }
}

// Route _createRoute() {
//   return PageRouteBuilder(
//     transitionDuration: Duration(microseconds: 3),
//     pageBuilder: (context, animation, secondaryAnimation) => AddressScreen(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       final tween = Tween(begin: begin, end: end);
//       final offsetAnimation = animation.drive(tween);
//       return SlideTransition(
//         position: offsetAnimation,
//         child: child,
//       );
//     },
//   );
// }

Widget addAuthBloc(BuildContext context, Widget widget) {
  return BlocListener(
    bloc: BlocProvider.of<AuthenticationBloc>(context),
    listener: (BuildContext context, Object? state) {
      if (state is AuthenticationAuthenticated) {
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushReplacementNamed(context, AppRoutes.homeTabScreen);
        // Navigator.pushReplacementNamed(context, AppRoutes.homeTabScreen);
      }

      if (state is SplashScreenState) {
        Navigator.pushNamed(context, AppRoutes.splashScreen);
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
