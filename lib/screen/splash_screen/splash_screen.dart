import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/image_resource.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResource.colorffffff,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Center(
          //     child: Icon(
          //   CupertinoIcons.house,
          //   size: 50,
          //   color: Colors.black,
          // )),
          // const SizedBox(
          //   height: 30,
          // ),
          // SvgPicture.asset(ImageResource.origa),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Image.asset(ImageResource.origa),
          ),
          // CustomText(
          //   Languages.of(context)!.origa,
          //   color: ColorResource.color23375A,
          //   fontSize: FontSize.twentyFour,
          // )
        ],
      ),
    );
  }
}
