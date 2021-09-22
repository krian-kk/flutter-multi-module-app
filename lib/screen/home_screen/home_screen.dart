import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_dialog.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';
import 'package:origa/widgets/gradientButton.dart';
import 'package:origa/widgets/hyperlink_widget.dart';
import 'package:origa/widgets/input_label_widget.dart';
import 'package:origa/widgets/primary_button.dart';
import 'package:origa/widgets/secondary_button.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  HomeBloc bloc;
  HomeScreen(this.bloc);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.bloc,
      listener: (BuildContext context, HomeState state) {
        if (state is HomeInitialState && state.error != null) {
          AppUtils.showErrorToast(state.error);
        }
        if (state is HomeRefreshState) {
          setState(() {});
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            StringResource.home,
            color: Colors.white,
            font: Font.robotoBold,
            fontSize: FontSize.twenty,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomTextField(
                      StringResource.userName,
                      StringResource.enterYourName,
                      widget.bloc.userNameController),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: InputLabelWidget(
                    StringResource.email,
                    StringResource.enterYourEmail,
                    widget.bloc.emailController,
                    inputType: TextInputType.emailAddress,
                    error: widget.bloc.emailError,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: InputLabelWidget(
                    StringResource.mobileNumber,
                    StringResource.enterMobileNumber,
                    widget.bloc.mobileController,
                    inputType: TextInputType.phone,
                    inputformaters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    error: widget.bloc.mobileError,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(20),
                    child: PrimaryButton(
                      StringResource.submit,
                      onClick: () {
                        widget.bloc.add(HomeSubmitButtonTappedEvent());
                      },
                    )),
                Container(
                    margin: const EdgeInsets.all(20),
                    child: SecondaryButton(
                      StringResource.showAlertDialog,
                      onClick: () {
                        _showAlert(context);
                      },
                    )),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: GradientButton(
                      StringResource.showCustomAlertDialog,
                      const LinearGradient(
                        colors: <Color>[Colors.green, Colors.black],
                      ), onClick: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomDialogBox(
                            title: StringResource.customDialog,
                            descriptions:
                                StringResource.customDialogDiscription,
                            img: null,
                          );
                        });
                  }),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: GradientButton(
                      StringResource.askLocationPermission,
                      const LinearGradient(
                        colors: <Color>[Colors.blue, Colors.black],
                      ), onClick: () async {
                    PermissionStatus permission =
                        await LocationPermissions().requestPermissions();
                  }),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Center(
                    child: HyperlinkWidget(StringResource.termsCondition,
                        'https://policies.google.com/terms?hl=en-US'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Icon(CupertinoIcons.home),
              content: Text("This is content text. We can change it "),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Okay')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'))
              ],
            ));
  }
}
