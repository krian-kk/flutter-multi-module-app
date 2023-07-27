import 'package:origa/src/features/authentication/data/auth_repository.dart';
import 'package:origa/src/features/authentication/domain/response_login.dart';
import 'package:origa/src/features/authentication/presentation/sign_in/bloc/signIn_event.dart';
import 'package:origa/src/features/authentication/presentation/sign_in/bloc/signIn_state.dart';
import 'package:origa/src/services/network_utils/network_base_models/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../form_submission_status.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepo;

  SignInBloc({required this.authRepo}) : super(SignInState()) {
    on<SignInEvent>(_onEvent);
  }

  Future<void> _onEvent(SignInEvent event, Emitter<SignInState> emit) async {
    if (event is SignInUsernameChanged) {
      emit(state.copyWith(username: event.username));
    } else if (event is SignInPasswordChanged) {
      emit(state.copyWith(password: event.password));
    } else if (event is SignInSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        final response =  (await authRepo.login()) as ApiResult<LoginResponseModel>;
        // response.when(success: onSuccess(response), failure: onFailure(response));
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
      }
    }
  }

  onSuccess(ApiResult<LoginResponseModel> response){

  }

  onFailure() {

  }
}
