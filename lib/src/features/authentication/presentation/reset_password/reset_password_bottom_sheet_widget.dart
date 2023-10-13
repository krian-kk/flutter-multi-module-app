import 'package:design_system/colors.dart';
import 'package:design_system/constants.dart';
import 'package:design_system/fonts.dart';
import 'package:design_system/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_bloc.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_event.dart';
import 'package:origa/src/features/authentication/bloc/sign_in_state.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_textfield.dart';

class ResetPasswordShowBottomSheetWidget extends StatefulWidget {
  ResetPasswordShowBottomSheetWidget(
      {super.key,
      required this.name,
      required this.otp,
      required this.mobileNumberFocusNode,
      required this.userNameFocusNode});

  final String name;
  final String otp;
  FocusNode mobileNumberFocusNode;
  FocusNode userNameFocusNode;

  @override
  State<ResetPasswordShowBottomSheetWidget> createState() =>
      _ResetPasswordShowBottomSheetWidgetState();
}

class _ResetPasswordShowBottomSheetWidgetState
    extends State<ResetPasswordShowBottomSheetWidget> {
  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode newPasswordFocusNode = FocusNode();

  final FocusNode confirmPasswordFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isSaveNewPasswordLoad = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) async {
        if (state is SuccessResetPasswordState) {
          AppUtils.topSnackBar(context, Constants.successfullyUpdated);

          await Future<dynamic>.delayed(const Duration(seconds: 2));
          context.pop();
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return Form(
            key: formKey,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.89,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BottomSheetAppbar(
                    title: Languages.of(context)!.resetPassword,
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
                            Languages.of(context)!.enterNewPassword,
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
                            onEditing: () {
                              widget.mobileNumberFocusNode.unfocus();
                              widget.userNameFocusNode.requestFocus();
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validatorCallBack: (bool values) {},
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            Languages.of(context)!.enterConfirmNewPassword,
                            confirmPasswordController,
                            obscureText: true,
                            isFill: true,
                            isBorder: true,
                            isLabel: true,
                            borderColor: ColorResourceDesign.colorFFFFFF,
                            validationRules: const <String>['required'],
                            maximumWordCount: 10,
                            focusNode: confirmPasswordFocusNode,
                            onEditing: () {
                              widget.mobileNumberFocusNode.unfocus();
                              widget.userNameFocusNode.requestFocus();
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validatorCallBack: (bool values) {},
                          ),
                          const SizedBox(height: 20),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: CustomButton(
                              isSaveNewPasswordLoad
                                  ? Languages.of(context)!
                                      .saveNewPassword
                                      .toUpperCase()
                                  : null,
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
                                      if (formKey.currentState!.validate()) {
                                        if (newPasswordController.text ==
                                            confirmPasswordController.text) {
                                          setState(() =>
                                              isSaveNewPasswordLoad = false);
                                          BlocProvider.of<SignInBloc>(context)
                                              .add(SubmitNewPasswordEvent(
                                                  name: widget.name,
                                                  otp: widget.otp,
                                                  newPassword:
                                                      newPasswordController
                                                          .text));
                                        } else {
                                          AppUtils.showToast(
                                            Languages.of(context)!
                                                .pleaseSelectCorrectPassword,
                                          );
                                        }

                                        setState(
                                            () => isSaveNewPasswordLoad = true);
                                      }
                                    }
                                  : () {},
                              borderColor: ColorResourceDesign.colorBEC4CF,
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
          );
        },
      ),
    );
  }
}
