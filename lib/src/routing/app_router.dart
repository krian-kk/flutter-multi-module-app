import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:origa/models/searching_data_model.dart';
import 'package:origa/src/features/allocation/presentation/allocation_view.dart';
import 'package:origa/src/features/authentication/presentation/sign_in/signIn_view.dart';
import 'package:origa/src/features/dashboard/dashboard_screen.dart';
import 'package:origa/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:origa/src/features/home/presentation/home_view.dart';
import 'package:origa/src/features/search/bloc/search_bloc.dart';
import 'package:origa/src/features/search/search_list/search_list_screen.dart';
import 'package:origa/src/features/search/search_list/bloc/search_list_bloc.dart';
import 'package:origa/src/features/search/search_screen.dart';
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
                create: (context) => HomeBloc(),
                child: const HomeView(),
              );
            },
          ),
          GoRoute(
            path: caseDetailsScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const AllocationView();
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
          ),
          GoRoute(
            path: chatScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const AllocationView();
            },
          ),
        ],
      ),
    ],
  );
}
