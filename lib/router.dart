import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/Telecaller/screens/case_details_telecaller_screen.dart/bloc/casedetails_telecaller_bloc.dart';
import 'package:origa/Telecaller/screens/case_details_telecaller_screen.dart/case_details_telecaller_screen.dart';
import 'package:origa/Telecaller/screens/phone_t_screen.dart/bloc/phone_telecaller_bloc.dart';
import 'package:origa/Telecaller/screens/phone_t_screen.dart/phone_telecaller_screen.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/case_details_screen.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_bloc.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_event.dart';
import 'package:origa/screen/home_tab_screen/home_tab_screen.dart';
import 'package:origa/screen/login_screen/bloc/login_bloc.dart';
import 'package:origa/screen/login_screen/login_screen.dart';
import 'package:origa/screen/search_screen/bloc/search_bloc.dart';
import 'package:origa/screen/search_screen/search_screen.dart';
import 'package:origa/screen/splash_screen/splash_screen.dart';

import 'authentication/authentication_bloc.dart';
import 'authentication/authentication_state.dart';

class AppRoutes {
  static const String splashScreen = 'splash_screen';
  static const String loginScreen = 'login_screen';
  static const String homeTabScreen = 'homeTab_screen';
  static const String dashboardScreen = 'dashboard_screen';
  static const String allocationScreen = 'allocation_screen';
  static const String allocationTelecallerScreen =
      'allocation_telecaller_screen';
  static const String searchScreen = 'search_allocation_details_screen';
  static const String caseDetailsScreen = 'case_details_screen';
  static const String caseDetailsTelecallerScreen =
      'case_details_telecaller_screen';
  static const String phoneTelecallerScreen = 'phone_telecaller_screen';
}

Route<dynamic> getRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashScreen:
      return _buildSplashScreen();
    case AppRoutes.homeTabScreen:
      return _buildHomeTabScreen(settings);
    case AppRoutes.searchScreen:
      return _buildSearchScreen();
    case AppRoutes.caseDetailsScreen:
      return _buildCaseDetailsScreen(settings);
    case AppRoutes.loginScreen:
      return _buildLoginScreen(settings);
    case AppRoutes.caseDetailsTelecallerScreen:
      return _buildCaseDetailsTelecallerScreen();
    case AppRoutes.phoneTelecallerScreen:
      return _buildPhoneTelecallerScreen();
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
    String? loginType;
    if (settings.arguments != null) {
      loginType = settings.arguments.toString();
    }

    // final AuthenticationBloc authBloc =
    //     BlocProvider.of<AuthenticationBloc>(context);
    return addAuthBloc(context, PageBuilder.buildHomeTabScreen(loginType));
  });
}

Route<dynamic> _buildLoginScreen(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) {
    final AuthenticationBloc authBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return addAuthBloc(context, PageBuilder.buildLoginScreen(authBloc));
  });
}

Route<dynamic> _buildSearchScreen() {
  return MaterialPageRoute(
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildSearchScreenPage()),
  );
}

Route<dynamic> _buildCaseDetailsScreen(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildCaseDetailsPage(settings)),
  );
}

Route<dynamic> _buildCaseDetailsTelecallerScreen() {
  return MaterialPageRoute(
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildCaseDetailsTelecallerPage()),
  );
}

Route<dynamic> _buildPhoneTelecallerScreen() {
  return MaterialPageRoute(
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildPhoneTelecallerPage()),
  );
}

class PageBuilder {
  static Widget buildSplashScreen() {
    return BlocProvider(
      create: (BuildContext context) {
        return BlocProvider.of<AuthenticationBloc>(context);
      },
      child: SplashScreen(),
    );
  }

  static Widget buildHomeTabScreen(String? loginType) {
    return BlocProvider(
      create: (BuildContext context) =>
          BlocProvider.of<HomeTabBloc>(context)..add(HomeTabInitialEvent()),
      child: HomeTabScreen(loginType),
    );
  }

  static Widget buildLoginScreen(AuthenticationBloc authBloc) {
    return BlocProvider(
      create: (BuildContext context) =>
          BlocProvider.of<LoginBloc>(context)..add(LoginInitialEvent()),
      child: LoginScreen(authBloc),
    );
  }

  static Widget buildSearchScreenPage() {
    return BlocProvider(
      create: (BuildContext context) =>
          BlocProvider.of<SearchScreenBloc>(context)
            ..add(SearchScreenInitialEvent()),
      child: SearchScreen(),
    );
  }

  static Widget buildCaseDetailsPage(RouteSettings settings) {
    // // String? loginType;
    // if (settings.arguments != null) {
    //   // loginType = settings.arguments.toString();
    // }
    print('event.paramValues------');
    print(settings.arguments);

    return BlocProvider(
      create: (BuildContext context) =>
          BlocProvider.of<CaseDetailsBloc>(context)
            ..add(CaseDetailsInitialEvent(paramValues: settings.arguments)),
      child: CaseDetailsScreen(paramValues: settings.arguments),
    );
  }

  static Widget buildCaseDetailsTelecallerPage() {
    return BlocProvider(
      create: (BuildContext context) =>
          BlocProvider.of<CasedetailsTelecallerBloc>(context)
            ..add(CaseDetailsTelecallerInitialEvent()),
      child: const CaseDetailsTelecallerScreen(),
    );
  }

  static Widget buildPhoneTelecallerPage() {
    return BlocProvider(
      create: (BuildContext context) =>
          BlocProvider.of<PhoneTelecallerBloc>(context)
            ..add(PhoneTelecallerInitialEvent()),
      child: const PhoneTelecallerScreen(),
    );
  }
}

Widget addAuthBloc(BuildContext context, Widget widget) {
  return BlocListener(
    bloc: BlocProvider.of<AuthenticationBloc>(context),
    listener: (BuildContext context, Object? state) {
      if (state is AuthenticationAuthenticated) {
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
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
