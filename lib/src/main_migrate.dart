import 'package:flutter/material.dart';
import 'package:origa/src/routing/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Collect',
      routerConfig: AppRouter().router,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FB),
        fontFamily: 'Lato-Regular',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F9FB),
        ),
      ),
    );
  }
}
