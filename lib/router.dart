import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/case_details_navigation_model.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/case_details_screen/case_details_screen.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_bloc.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_event.dart';
import 'package:origa/screen/home_tab_screen/home_tab_screen.dart';
import 'package:origa/screen/login_screen/bloc/login_bloc.dart';
import 'package:origa/screen/login_screen/login_screen.dart';
import 'package:origa/screen/message_screen/chat_screen.dart';
import 'package:origa/screen/message_screen/chat_screen_bloc.dart';
import 'package:origa/screen/message_screen/chat_screen_event.dart';
import 'package:origa/screen/mpin_screens/conform_mpin_screen.dart';
import 'package:origa/screen/search_screen/bloc/search_bloc.dart';
import 'package:origa/screen/search_screen/search_screen.dart';
import 'package:origa/screen/splash_screen/splash_screen.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/preference_helper.dart';

import 'authentication/authentication_bloc.dart';
import 'authentication/authentication_state.dart';

class AppRoutes {
  static const String splashScreen = 'splash_screen';
  static const String loginScreen = 'login_screen';
  static const String homeTabScreen = 'homeTab_screen';
  static const String searchScreen = 'search_allocation_details_screen';
  static const String caseDetailsScreen = 'case_details_screen';
  static const String chatScreen = 'chat_screen';
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
    case AppRoutes.chatScreen:
      return _buildChatScreen(settings);
  }
  return _buildSplashScreen();
}

Route<dynamic> _buildSplashScreen() {
  return MaterialPageRoute<dynamic>(
    builder: (BuildContext context) =>
        addAuthBloc(context, PageBuilder.buildSplashScreen()),
  );
}

Route<dynamic> _buildHomeTabScreen(RouteSettings settings) {
  return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
    if (settings.arguments != null) {}

    // final AuthenticationBloc authBloc =
    //     BlocProvider.of<AuthenticationBloc>(context);
    return addAuthBloc(
        context,
        PageBuilder.buildHomeTabScreen(
            notificationData: settings.arguments as dynamic));
  });
}

Route<dynamic> _buildChatScreen(RouteSettings settings) {
  return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
    return addAuthBloc(context, PageBuilder.buildChatScreenPage());
  });
}

Route<dynamic> _buildLoginScreen(RouteSettings settings) {
  return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
    final AuthenticationBloc authBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return addAuthBloc(
        context,
        PageBuilder.buildLoginScreen(authBloc,
            notificationData: settings.arguments as dynamic));
  });
}

Route<dynamic> _buildSearchScreen() {
  return MaterialPageRoute<dynamic>(
    builder: (BuildContext context) =>
        addAuthBloc(context, PageBuilder.buildSearchScreenPage()),
  );
}

Route<dynamic> _buildCaseDetailsScreen(RouteSettings settings) {
  return MaterialPageRoute<dynamic>(
    builder: (BuildContext context) =>
        addAuthBloc(context, PageBuilder.buildCaseDetailsPage(settings)),
  );
}

// Route<dynamic> _buildCaseDetailsTelecallerScreen() {
//   return MaterialPageRoute(
//     builder: (context) =>
//         addAuthBloc(context, PageBuilder.buildCaseDetailsTelecallerPage()),
//   );
// }

class PageBuilder {
  static Widget buildSplashScreen() {
    return BlocProvider(
      create: (BuildContext context) {
        return BlocProvider.of<AuthenticationBloc>(context);
      },
      child: const SplashScreen(),
    );
  }

  static Widget buildHomeTabScreen({dynamic notificationData}) {
    return BlocProvider(
      create: (BuildContext context) {
        // final AuthenticationBloc authBloc =
        //     BlocProvider.of<AuthenticationBloc>(context);
        return BlocProvider.of<HomeTabBloc>(context)
          ..add(HomeTabInitialEvent(
              context: context, notificationData: notificationData));
      },
      child: HomeTabScreen(notificationData: notificationData),
    );
  }

  static Widget buildLoginScreen(AuthenticationBloc authBloc,
      {dynamic notificationData}) {
    return BlocProvider(
      create: (BuildContext context) => BlocProvider.of<LoginBloc>(context)
        ..add(LoginInitialEvent(context: context)),
      child: LoginScreen(authBloc, notificationData: notificationData),
    );
  }

  static Widget buildSearchScreenPage() {
    return BlocProvider(
      create: (BuildContext context) =>
          BlocProvider.of<SearchScreenBloc>(context)
            ..add(SearchScreenInitialEvent()),
      child: const SearchScreen(),
    );
  }

  static Widget buildChatScreenPage() {
    return BlocProvider(
      create: (BuildContext context) =>
          BlocProvider.of<ChatScreenBloc>(context)..add(ChatInitialEvent()),
      child: const ChatScreen(),
    );
  }

  static Widget buildCaseDetailsPage(RouteSettings settings) {
    CaseDetailsNaviagationModel caseDetailsNaviagationValue;
    caseDetailsNaviagationValue =
        settings.arguments as CaseDetailsNaviagationModel;
    if (caseDetailsNaviagationValue.paramValue['isOffline'] != null) {
      debugPrint(
          'isOffline--> ${caseDetailsNaviagationValue.paramValue['isOffline']}');
    }
    return BlocProvider(
      create: (BuildContext context) =>
          BlocProvider.of<CaseDetailsBloc>(context)
            ..add(CaseDetailsInitialEvent(
              paramValues: caseDetailsNaviagationValue.paramValue,
            )),
      child: CaseDetailsScreen(
        paramValues: caseDetailsNaviagationValue.paramValue,
        allocationBloc:
            caseDetailsNaviagationValue.allocationBloc ?? AllocationBloc(),
      ),
    );
  }

//TST_8939600444
//Origa123
}

Widget addAuthBloc(BuildContext context, Widget widget) {
  return BlocListener(
    bloc: BlocProvider.of<AuthenticationBloc>(context),
    listener: (BuildContext context, Object? state) async {
      if (state is AuthenticationAuthenticated) {
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        debugPrint(
            'Router AuthenticationAuthenticated @notification tyep ${state.notificationData}');

        // final String? mPin =
        //     await PreferenceHelper.getString(keyPair: Constants.mPin);
        // final String? agentRef =
        //     await PreferenceHelper.getString(keyPair: Constants.agentRef);
        // Singleton.instance.isOfflineEnabledContractorBased =
        //     await PreferenceHelper.getBool(keyPair: Constants.isOfflineStorage);

        String? mPin;
        String? agentRef;
        await PreferenceHelper.getString(keyPair: Constants.mPin).then((value) {
          mPin = value;
        });
        await PreferenceHelper.getString(keyPair: Constants.agentRef)
            .then((value) {
          agentRef = value;
        });
        await PreferenceHelper.getBool(keyPair: Constants.isOfflineStorage)
            .then((value) {
          Singleton.instance.isOfflineEnabledContractorBased = value;
        });
        await PreferenceHelper.getString(keyPair: Constants.userType)
            .then((value) {
          Singleton.instance.usertype = value;
        });
        // await Navigator.pushReplacementNamed(context, AppRoutes.homeTabScreen,
        //     arguments: state.notificationData);
        // await SharedPreferences.getInstance().then((value) {
        //   String? mPin = value.getString(Constants.mPin);
        //   String? agentRef = value.getString(Constants.agentRef);
        //   print('Mpin ======= > ${mPin}');
        if (Singleton.instance.isOfflineEnabledContractorBased &&
            Singleton.instance.usertype == Constants.fieldagent) {
          if (mPin != null) {
            await showMPinDialog(
                mPin: mPin,
                buildContext: context,
                userName: agentRef,
                notificationData: state.notificationData);
          } else {
            await Navigator.pushReplacementNamed(context, AppRoutes.loginScreen,
                arguments: state.notificationData);
          }
        } else {
          await Navigator.pushReplacementNamed(
            context,
            AppRoutes.homeTabScreen,
            arguments: state.notificationData,
          );
        }
      }

      if (state is AuthenticationUnAuthenticated) {
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        debugPrint(
            'Router AuthenticationUnAuthenticated @notification tyep ${state.notificationData}');

        await Navigator.pushReplacementNamed(context, AppRoutes.loginScreen,
            arguments: state.notificationData);
      }

      if (state is OfflineState) {
        String? mPin;
        String? agentRef;
        await PreferenceHelper.getString(keyPair: Constants.mPin).then((value) {
          mPin = value;
        });
        await PreferenceHelper.getString(keyPair: Constants.agentRef)
            .then((value) {
          agentRef = value;
        });
        await PreferenceHelper.getBool(keyPair: Constants.isOfflineStorage)
            .then((value) {
          Singleton.instance.isOfflineEnabledContractorBased = value;
        });
        await PreferenceHelper.getString(keyPair: Constants.userType)
            .then((value) {
          Singleton.instance.usertype = value;
        });
        // final String mPin =
        //     PreferenceHelper.getString(keyPair: Constants.mPin).toString();
        // final String agentRef =
        //     PreferenceHelper.getString(keyPair: Constants.agentRef).toString();
        // Singleton.instance.isOfflineEnabledContractorBased =
        //     PreferenceHelper.getBool(keyPair: Constants.isOfflineStorage)
        //         as bool;
        // Singleton.instance.usertype =
        //     PreferenceHelper.getString(keyPair: Constants.userType).toString();

        if (Singleton.instance.isOfflineEnabledContractorBased &&
            Singleton.instance.usertype == Constants.fieldagent) {
          await showMPinDialog(
              mPin: mPin, buildContext: context, userName: agentRef);
        } else {
          await Navigator.pushReplacementNamed(
              context, AppRoutes.homeTabScreen);
        }
      }
      if (state is SplashScreenState) {
        await Navigator.pushNamed(context, AppRoutes.splashScreen);
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

Future<void> showMPinDialog(
    {String? mPin,
    String? userName,
    BuildContext? buildContext,
    dynamic notificationData}) async {
  return showDialog<void>(
      context: buildContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              side: BorderSide(width: 0.5, color: ColorResource.colorDADADA),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            contentPadding: const EdgeInsets.all(20),
            content: ConformMpinScreen(
              successFunction: () => Navigator.pushReplacementNamed(
                  context, AppRoutes.homeTabScreen,
                  arguments: notificationData),
              forgotPinFunction: () async {
                if (ConnectivityResult.none ==
                    await Connectivity().checkConnectivity()) {
                  AppUtils.showErrorToast(
                      Languages.of(context)!.noInternetConnection);
                } else {
                  await Navigator.pushReplacementNamed(
                      context, AppRoutes.loginScreen,
                      arguments: notificationData);
                }
              },
              mPin: mPin!,
            ),
          ),
        );
      });
}
