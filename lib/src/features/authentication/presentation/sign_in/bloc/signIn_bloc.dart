import 'dart:async';

import 'package:domain_models/response_models/response_login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:origa/src/features/authentication/presentation/sign_in/bloc/signIn_event.dart';
import 'package:origa/src/features/authentication/presentation/sign_in/bloc/signIn_state.dart';
import 'package:repository/auth_repository.dart';
import '../../../form_submission_status.dart';

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
        final ApiResult<LoginResponseModel> data =
            await authRepo.login(state.username, state.password, '');
        await data.when(success: (LoginResponseModel? loginData) async {
          emit(state.copyWith(formStatus: SubmissionSuccess()));
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
  }
}
