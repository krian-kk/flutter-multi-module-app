import 'package:origa/may_app.dart';
import 'package:origa/singleton.dart';

void main() async {
  //development = 1, uat = 2, production = 3
  Singleton.instance.serverPointingType = 1;
  mainDelegate();
}
