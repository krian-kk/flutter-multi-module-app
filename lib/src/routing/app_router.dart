import 'package:domain_models/common/searching_data_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_bloc.dart';
import 'package:origa/screen/home_tab_screen/home_tab_screen.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_bloc.dart';
import 'package:origa/src/features/authentication/presentation/sign_in/sign_in_view.dart';
import 'package:origa/src/features/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/src/features/case_details_screen/case_details_screen.dart';
import 'package:origa/src/features/dashboard/dashboard_screen.dart';
import 'package:origa/src/features/search/bloc/search_bloc.dart';
import 'package:origa/src/features/search/search_list/bloc/search_list_bloc.dart';
import 'package:origa/src/features/search/search_list/search_list_screen.dart';
import 'package:origa/src/features/search/search_screen.dart';
import 'package:repository/auth_repository.dart';
import 'package:repository/case_repository.dart';
import 'package:repository/search_list_repository.dart';

class AppRouter {
  static const String splashScreen = 'splash_screen';
  static const String loginScreen = 'login_screen';
  static const String homeTabScreen = 'home_screen';
  static const String allocationScreen = 'allocation_screen';
  static const String allocationTelecallerScreen =
      'allocation_telecaller_screen';
  static const String searchScreen = 'search_screen';
  static const String searchCaseListScreen = 'search_list_screen';
  static const String caseDetailsScreen = 'case_details_screen';
  static const String caseDetailsTelecallerScreen =
      'case_details_telecaller_screen';
  static const String phoneTelecallerScreen = 'phone_telecaller_screen';
  static const String chatScreen = 'chat_screen';

  /// The route configuration.
  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: 'login',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SignInView();
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'home',
            path: homeTabScreen,
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                  create: (context) => HomeTabBloc(),
                  child: const HomeTabScreen());
            },
          ),
          GoRoute(
            path: caseDetailsScreen,
            builder: (BuildContext context, GoRouterState state) {
              return RepositoryProvider(
                create: (context) => CaseRepositoryImpl(),
                child: BlocProvider(
                    create: (BuildContext context) =>
                        CaseDetailsBloc(context.read<CaseRepositoryImpl>()),
                    child: CaseDetailsScreen(paramValues: state.extra)),
              );
            },
          ),
          GoRoute(
            path: caseDetailsTelecallerScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const DashboardScreen();
            },
          ),
          GoRoute(
            name: 'search',
            path: searchScreen,
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                  create: (BuildContext context) => SearchBloc(),
                  child: const SearchScreen());
            },
          ),
          GoRoute(
            name: 'searchList',
            path: searchCaseListScreen,
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                create: (context) =>
                    SearchListBloc(repository: SearchListRepositoryImpl()),
                child: SearchListScreen(
                    searchData: state.extra! as SearchingDataModel),
              );
            },
          )
        ],
      ),
    ],
  );

// static Widget buildCaseDetailsPage(RouteSettings settings) {
//   CaseDetailsNaviagationModel caseDetailsNaviagationValue;
//   caseDetailsNaviagationValue =
//       settings.arguments as CaseDetailsNaviagationModel;
//   if (caseDetailsNaviagationValue.paramValue['isOffline'] != null) {
//     debugPrint(
//         'isOffline--> ${caseDetailsNaviagationValue.paramValue['isOffline']}');
//   }
//   return BlocProvider(
//     create: (BuildContext context) =>
//         BlocProvider.of<CaseDetailsBloc>(context)
//           ..add(CaseDetailsInitialEvent(
//             paramValues: caseDetailsNaviagationValue.paramValue,
//           )),
//     child: CaseDetailsScreen(
//       paramValues: caseDetailsNaviagationValue.paramValue,
//       allocationBloc: caseDetailsNaviagationValue.allocationBloc ?? AllocationBloc(),
//     ),
//   );
// }
}
