import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/may_app.dart';
import 'package:origa/singleton.dart';

import 'bloc.dart';

void main() async {
  //development = 1, uat = 2, production = 3
  Singleton.instance.serverPointingType = 2;
  mainDelegate();
}
