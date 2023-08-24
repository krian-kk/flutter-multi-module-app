import 'dart:async';

import 'package:domain_models/response_models/auth/sign_in/login_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:origa/src/features/authentication/bloc/form_submission_status.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_event.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_state.dart';
import 'package:repository/auth_repository.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required this.authRepo}) : super(SignInState()) {
    on<SignInEvent>(_onEvent);
  }

  final AuthRepository authRepo;

  Future<void> _onEvent(SignInEvent event, Emitter<SignInState> emit) async {
    if (event is SignInUsernameChanged) {
      emit(state.copyWith(username: event.username));
    } else if (event is SignInPasswordChanged) {
      emit(state.copyWith(password: event.password));
    } else if (event is SignInSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        // if (kDebugMode) {
        //   String userName = "gfldev_testfosv"; //gfldev_telev
        //   String password = "Abcd@123";
        // }
        final ApiResult<LoginResponse> data =
            await authRepo.login(state.username, state.password, '');
        await data.when(success: (LoginResponse? loginData) async {
          if (loginData?.setPassword == true) {
            emit(SetPasswordState(name: state.username));
          } else {
            emit(state.copyWith(formStatus: SubmissionSuccess()));
          }
        }, failure: (NetworkExceptions? error) async {
          emit(state.copyWith(
              formStatus:
                  SubmissionFailed(NetworkExceptions.getErrorMessage(error!))));
          emit(state.copyWith(formStatus: const InitialFormStatus()));
        });
      } catch (e) {
        emit(state.copyWith(formStatus: const SubmissionFailed('')));
      }
    }

    if (event is ResetPasswordClickEvent) {
      final ApiResult<ShortAgentDetails>? data =
          await authRepo.getAgentDataForPrefill(event.agentRef);
      await data?.when(
          success: (ShortAgentDetails? data) async {
            if (data != null) {
              emit(FillAgentInfoForResetPassword(data));
            }
          },
          failure: (NetworkExceptions? error) async {});
    }

    if (event is SendOtpToServerEvent) {
      final ApiResult<bool>? data =
          await authRepo.sendOtpRequestToServer(event.agentRef);
      await data?.when(
          success: (bool? success) async {
            emit(SendOtpSuccessState());
          },
          failure: (NetworkExceptions? error) async {});
    }

    if (event is RequestOtpToServerEvent) {
      final ApiResult<bool>? data =
          await authRepo.sendOtpRequestToServer(event.agentRef);
      await data?.when(
          success: (bool? success) async {
            emit(RequestOtpSuccessState());
          },
          failure: (NetworkExceptions? error) async {});
    }

    if (event is VerifyOtpEvent) {
      final ApiResult<bool>? data =
          await authRepo.verifyOtpRequestToServer(event.agentRef, event.pin);
      await data?.when(
          success: (bool? success) async {
            emit(VerifyOtpSuccessState());
          },
          failure: (NetworkExceptions? error) async {});
    }

    if (event is ResetPasswordChangeEvent) {
      final ApiResult<bool>? data = await authRepo.resetPasswordForAgent(
          event.agentRef, event.password, event.otp);
      await data?.when(
          success: (bool? success) async {
            emit(VerifyOtpSuccessState());
          },
          failure: (NetworkExceptions? error) async {});
    }

    if (event is SetPasswordEvent) {
      final ApiResult data =
          await authRepo.setPasswordForAgent(event.userName, event.password);
      data.when(
          success: (success) => {emit(SetPasswordSuccessState())},
          failure: (failure) => {});
    }
  }
}
