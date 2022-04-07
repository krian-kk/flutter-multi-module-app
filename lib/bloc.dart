import 'package:bloc/bloc.dart';

// ignore: public_member_api_docs
class EchoBlocDelegate extends BlocObserver {
  @override
  // ignore: unnecessary_overrides
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    // if (DebugMode.isInDebugMode) {
    //   print(event);
    // }
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    // if (DebugMode.isInDebugMode) {
    //   print(transition);
    // }

    @override
    // ignore: unused_element
    void onError(Cubit<dynamic> bloc, Object error, StackTrace stacktrace) {
      super.onError(bloc, error, stacktrace);
      // if (DebugMode.isInDebugMode) {
      //   print(error);
      // }
    }
  }
}
