import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResource.colorffffff,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
              child: Icon(
            CupertinoIcons.house,
            size: 50,
            color: Colors.white,
          )),
          const SizedBox(
            height: 30,
          ),
          CustomText(
            StringResource.origa,
            color: ColorResource.color23375A,
            fontSize: FontSize.twentyFour,
          )
        ],
      ),
    );
  }
}
