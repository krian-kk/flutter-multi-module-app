import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:origa/src/features/allocation/presentation/allocation_view.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_bloc.dart';
import 'package:origa/src/features/authentication/presentation/sign_in/sign_in_view.dart';
import 'package:origa/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:origa/src/features/home/presentation/home_view.dart';
import 'package:repository/auth_repository.dart';

class AppRouter {
  static const String splashScreen = 'splash_screen';
  static const String loginScreen = 'login_screen';
  static const String homeTabScreen = 'home_screen';
  static const String allocationScreen = 'allocation_screen';
  static const String allocationTelecallerScreen =
      'allocation_telecaller_screen';
  static const String searchScreen = 'search_allocation_details_screen';
  static const String caseDetailsScreen = 'case_details_screen';
  static const String caseDetailsTelecallerScreen =
      'case_details_telecaller_screen';
  static const String phoneTelecallerScreen = 'phone_telecaller_screen';
  static const String chatScreen = 'chat_screen';

  /// The route configuration.
  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return RepositoryProvider(
            create: (context) => AuthRepositoryImpl(),
            child: BlocProvider(
              create: (context) =>
                  SignInBloc(authRepo: context.read<AuthRepositoryImpl>()),
              child: const SignInView(),
            ),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: homeTabScreen,
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                  create: (context) => HomeBloc(), child: const HomeView());
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
              return const AllocationView();
            },
          ),
          GoRoute(
            path: searchScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const AllocationView();
            },
          )
        ],
      ),
    ],
  );
}
