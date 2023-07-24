import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

// ignore: public_member_api_docs
class EchoBlocDelegate extends BlocObserver {
  @override
  // ignore: unnecessary_overrides
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print(event);
    }
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print(transition);
    }

    @override
    // ignore: unused_element
    void onError(Cubit<dynamic> bloc, Object error, StackTrace stacktrace) {
      super.onError(bloc, error, stacktrace);
      if (kDebugMode) {
        print(error);
      }
    }
  }
}
