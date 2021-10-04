import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';

class AppTheme {
  TextTheme basicTextTheme(TextTheme base) {
    return base.copyWith(
      // //Used for font size of 6
      // caption: base.caption!.copyWith(
      //     fontFamily: 'Source Sans Pro',
      //     fontSize: 6.0,
      //     color: ColorResource.colorFFFFFF,
      //     fontWeight: FontWeight.w400),

      // //Used for font size of 12
      // subtitle2: base.subtitle2!.copyWith(
      //     fontFamily: 'SourceSansPro',
      //     fontSize: 12.0,
      //     color: ColorResource.color787878,
      //     fontWeight: FontWeight.w400),

      //Used for font size of 14
      subtitle1: base.subtitle1!.copyWith(
          fontFamily: 'Lato',
          fontSize: 14.0,
          color: ColorResource.colorFFFFFF,
          fontWeight: FontWeight.w700),

      //Used for font size of 12
      subtitle2: base.subtitle1!.copyWith(
          fontFamily: 'Lato',
          fontSize: 14.0,
          color: ColorResource.color666666,
          fontWeight: FontWeight.w400),

      // //Used for emphasizing text and font size of 18,20,22
      // bodyText1: base.bodyText1!.copyWith(
      //     fontFamily: 'SourceSansPro',
      //     fontSize: 16.0,
      //     color: ColorResource.color222222,
      //     fontWeight: FontWeight.w600,
      //     height: 1.5),

      // //Used for large text in dialogs and font size of 24
      // headline5: base.headline5!.copyWith(
      //     fontFamily: 'SourceSansPro',
      //     fontSize: 18.0,
      //     color: ColorResource.color222222,
      //     fontWeight: FontWeight.w600),

      // //Used for the primary text in app bars and font size of 26,28 and greater
      // headline6: base.headline6!.copyWith(
      //     fontFamily: 'SourceSansPro',
      //     fontSize: 28.0,
      //     color: Colors.white,
      //     fontWeight: FontWeight.w700),

      // //used for button
      // button: base.bodyText1!.copyWith(
      //   fontFamily: 'SourceSansPro',
      //   fontSize: 14.0,
      //   fontWeight: FontWeight.w600,
      // ),
    );
  }
}
