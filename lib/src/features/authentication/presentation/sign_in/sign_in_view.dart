import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/widgets/longRoundedBtn_widget.dart';
import 'package:design_system/widgets/textBtn_widget.dart';
import 'package:design_system/widgets/textFormFieldValidate_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:languages/app_languages.dart';
import 'package:languages/language_english.dart';
import 'package:origa/gen/assets.gen.dart';
import 'package:origa/src/features/authentication/bloc/form_submission_status.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_bloc.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_event.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_state.dart';
import 'package:origa/src/features/authentication/presentation/reset_password/reset_password_screen.dart';
import 'package:origa/src/routing/app_router.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_textfield.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  bool isSaveNewPasswordLoad = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state.formStatus is SubmissionSuccess) {
              context.go('/${AppRouter.homeTabScreen}');
            } else if (state.formStatus is SubmissionFailed) {
              final message = (state.formStatus as SubmissionFailed).message;
              AppUtils.showErrorToast(message);
            }
            if (state is SetPasswordState) {
              resetPasswordShowBottomSheet(state.name.toString(), context);
            }
            if (state is SetPasswordSuccessState) {
              Navigator.pop(context);
              context.go('/${AppRouter.homeTabScreen}');
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
        ),
      ),
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
          placeholder: Languages.of(context)!.userName,
          validator: (value) =>
              state.isValidUsername ? null : 'Invalid username',
          // : Languages.of(context).invalidUsername,
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
          placeholder: Languages.of(context)!.password,
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
                btnText: Languages.of(context)!.signin.toUpperCase(),
                isBorder: false,
                btnBackgroundColor: ColorResourceDesign.orangeMain,
                onPressed: () {
                  _signIn(context);
                },
              );
      },
    );
  }

  Future<void> _signIn(BuildContext context) async {
    if (kDebugMode) {
      context.read<SignInBloc>().add(SignInSubmitted());
    } else {
      if (_formKey.currentState!.validate()) {
        context.read<SignInBloc>().add(SignInSubmitted());
      }
    }
  }

  Widget _signInDiffUser() {
    return LongRoundedBtn(
      btnText: Languages.of(context)!.loginViaDifferentUser,
      isBorder: true,
      onPressed: () {},
    );
  }

  resetPasswordShowBottomSheet(String name, BuildContext innerContext) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final FocusNode newPasswordFocusNode = FocusNode();
    final FocusNode confirmPasswordFocusNode = FocusNode();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResourceDesign.colorF8F9FB,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) => Form(
                  key: formKey,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.89,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        BottomSheetAppbar(
                          title: LanguageEn().resetPassword.toUpperCase(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                CustomTextField(
                                  LanguageEn().enterNewPassword,
                                  newPasswordController,
                                  obscureText: true,
                                  isFill: true,
                                  isBorder: true,
                                  isLabel: true,
                                  errorMaxLine: 5,
                                  borderColor: ColorResourceDesign.colorFFFFFF,
                                  validationRules: const <String>['password'],
                                  // maximumWordCount: 10,
                                  focusNode: newPasswordFocusNode,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validatorCallBack: (bool values) {},
                                ),
                                const SizedBox(height: 20),
                                CustomTextField(
                                  LanguageEn().enterConfirmNewPassword,
                                  confirmPasswordController,
                                  obscureText: true,
                                  isFill: true,
                                  isBorder: true,
                                  isLabel: true,
                                  borderColor: ColorResourceDesign.colorFFFFFF,
                                  validationRules: const <String>['required'],
                                  maximumWordCount: 10,
                                  focusNode: confirmPasswordFocusNode,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validatorCallBack: (bool values) {},
                                ),
                                const SizedBox(height: 20),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 50),
                                  child: CustomButton(
                                    LanguageEn().saveNewPassword.toUpperCase(),
                                    isLeading: !isSaveNewPasswordLoad,
                                    trailingWidget: CustomLoadingWidget(
                                      gradientColors: <Color>[
                                        ColorResourceDesign.colorFFFFFF,
                                        ColorResourceDesign.colorFFFFFF
                                            .withOpacity(0.7),
                                      ],
                                    ),
                                    fontSize: FontSize.sixteen,
                                    fontWeight: FontWeight.w700,
                                    padding: 15.0,
                                    cardShape: 75.0,
                                    onTap: isSaveNewPasswordLoad
                                        ? () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              if (newPasswordController.text ==
                                                  confirmPasswordController
                                                      .text) {
                                                setState(() =>
                                                    isSaveNewPasswordLoad =
                                                        false);
                                                //todo apicall
                                                BlocProvider.of<SignInBloc>(
                                                        innerContext)
                                                    .add(SetPasswordEvent(
                                                        name,
                                                        newPasswordController
                                                            .text));
                                              }
                                            } else {
                                              AppUtils.showToast(
                                                LanguageEn()
                                                    .pleaseSelectCorrectPassword,
                                              );
                                            }
                                            setState(() =>
                                                isSaveNewPasswordLoad = true);
                                          }
                                        : () {},
                                    borderColor:
                                        ColorResourceDesign.colorBEC4CF,
                                    buttonBackgroundColor:
                                        ColorResourceDesign.color23375A,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}

class ResetPasswordButton extends StatefulWidget {
  const ResetPasswordButton({Key? key}) : super(key: key);

  @override
  State<ResetPasswordButton> createState() => _ResetPasswordButtonState();
}

class _ResetPasswordButtonState extends State<ResetPasswordButton> {
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (innerContext) {
        return BlocProvider.value(
            value: context.read<SignInBloc>(),
            child: const ResetPasswordScreen());
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
      btnText: Languages.of(context)!.resetPasswordModelViaOTP,
      onPressed: () => _showModalBottomSheet(context),
    );
  }
}
