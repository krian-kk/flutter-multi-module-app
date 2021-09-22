import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:origa/screen/home_screen/bloc/home_event.dart';
import 'package:origa/screen/home_screen/bloc/home_state.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/utils/validator.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  HomeBloc() : super(HomeInitialState(error: 'Failed'));

  String? emailError;
  String? mobileError;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeSubmitButtonTappedEvent) {
      final emailStatus = Validator.validate(emailController.text.trim(),
          rules: ['email', 'required']);
      if (!emailStatus.status) {
        emailError = StringResource.email + emailStatus.error;
        yield HomeRefreshState();
        // yield HomeInitialState(error: StringResource.email + emailStatus.error);
        return;
      } else {
        emailError = '';
        yield HomeRefreshState();
      }

      final mobileStatus = Validator.validate(mobileController.text.trim(),
          rules: ['mobile_number', 'required']);
      if (!mobileStatus.status) {
        mobileError = mobileStatus.error;
        // yield HomeInitialState(error: mobileStatus.error);
        yield HomeRefreshState();
        return;
      } else {
        mobileError = '';
        yield HomeRefreshState();
      }
    }
  }
}
