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
      color: ColorResource.color0066cc,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Icon(
            CupertinoIcons.house,
            size: 50,
            color: Colors.white,
          )),
          SizedBox(
            height: 30,
          ),
          CustomText(
            StringResource.origa,
            color: Colors.white,
            fontSize: FontSize.twentyFour,
          )
        ],
      ),
    );
  }
}
