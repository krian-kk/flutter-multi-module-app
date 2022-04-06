import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/singleton.dart';

import 'authentication/authentication_event.dart';
import 'bloc.dart';
import 'main.dart';

Future<void> main() async {
  //development = 1, uat = 2, production = 3
  Singleton.instance.serverPointingType = 3;
  Bloc.observer = EchoBlocDelegate();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) {
        return AuthenticationBloc()..add(AppStarted(context: context));
      },
      child: const MyApp(),
    ),
  );
}
