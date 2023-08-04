import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/strings.dart';
import 'package:design_system/widgets/longRoundedBtn_widget.dart';
import 'package:design_system/widgets/textBtn_widget.dart';
import 'package:design_system/widgets/textFormFieldValidate_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:origa/gen/assets.gen.dart';
import 'package:origa/src/features/authentication/bloc/form_submission_status.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_bloc.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_event.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_state.dart';
import 'package:origa/src/features/authentication/presentation/reset_password/reset_password_screen.dart';
import 'package:origa/src/routing/app_router.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:repository/auth_repository.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: RepositoryProvider(
          create: (context) => AuthRepositoryImpl(),
          child: BlocProvider(
            create: (context) => SignInBloc(
              authRepo: context.read<AuthRepositoryImpl>(),
            ),
            child: _loginForm(),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.formStatus is SubmissionSuccess) {
          context.go('/${AppRouter.homeTabScreen}');
        } else if (state.formStatus is SubmissionFailed) {
          final message = (state.formStatus as SubmissionFailed).message;
          AppUtils.showErrorToast(message);
        }
      },
      child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p20),
            child: Column(
              children: [
                gapH40,
                _authBanner(),
                gapH16,
                _usernameField(),
                gapH20,
                _passwordField(),
                gapH20,
                _signInButton(),
                gapH16,
                const ResetPasswordButton(),
                gapH32,
                _signInDiffUser()
              ],
            ),
          )),
    );
  }

  Widget _authBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: SvgPicture.asset(
        Assets.images.loginPageMain,
        height: 173,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return TextFormFieldValidateWidget(
          placeholder: username,
          validator: (value) => state.isValidUsername ? null : invalidUsername,
          onChanged: (value) => context
              .read<SignInBloc>()
              .add(SignInUsernameChanged(username: value)),
          isPassword: false,
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return TextFormFieldValidateWidget(
          placeholder: 'Password',
          validator: (value) =>
              state.isValidPassword ? null : 'Invalid Password',
          onChanged: (value) => context
              .read<SignInBloc>()
              .add(SignInPasswordChanged(password: value)),
          isPassword: true,
        );
      },
    );
  }

  Widget _signInButton() {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : LongRoundedBtn(
                btnText: signIn,
                isBorder: false,
                btnBackgroundColor: orangeMain,
                onPressed: () {
                  _signIn(context);
                },
              );
      },
    );
  }

  Future<void> _signIn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      context.read<SignInBloc>().add(SignInSubmitted());
    }
  }

  Widget _signInDiffUser() {
    return LongRoundedBtn(
      btnText: loginDiffUser,
      isBorder: true,
      onPressed: () {},
    );
  }
}

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({Key? key}) : super(key: key);

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const ResetPasswordScreen();
      },
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(Sizes.p20),
      )),
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextBtnWidget(
      btnText: resetPwd,
      onPressed: () => _showModalBottomSheet(context),
    );
  }
}
