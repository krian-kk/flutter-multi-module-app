import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/screen/home_screen/bloc/home_bloc.dart';
import 'package:origa/screen/home_screen/bloc/home_event.dart';
import 'package:origa/screen/home_screen/home_screen.dart';
import 'package:origa/screen/home_tab_screen/bloc/home_tab_bloc.dart';
import 'package:origa/screen/map_screen/bloc/map_bloc.dart';
import 'package:origa/screen/map_screen/bloc/map_event.dart';
import 'package:origa/screen/map_screen/map_screen.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class HomeTabScreen extends StatefulWidget {
  AuthenticationBloc authenticationBloc;
  HomeTabScreen(this.authenticationBloc);
  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  late HomeTabBloc bloc;
  late HomeBloc homeBloc;
  late MapBloc mapBloc;

  @override
  void initState() {
    // TODO: implement initState
    bloc = BlocProvider.of<HomeTabBloc>(context);
    homeBloc = HomeBloc()..add(HomeInitialEvent());
    mapBloc = MapBloc()..add(MapInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: StringResource.home),
          const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.map), label: StringResource.map)
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return HomeScreen(homeBloc);
              break;
            case 1:
              return MapScreen(mapBloc);
              break;
            default:
              return Container(
                color: Colors.pink,
              );
              break;
          }
        });
  }
}
