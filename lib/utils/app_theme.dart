import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';

class AppThemes {
  static const int darkBlue = 0;
  static const int lightOrange = 1;

  ThemeCollection getThemeCollections() {
    final ThemeData base = ThemeData.light();
    final ButtonThemeData darkButtonTheme =
        base.buttonTheme.copyWith(buttonColor: ColorResource.colorEA6D48);
    final FloatingActionButtonThemeData darkFABTheme =
        base.floatingActionButtonTheme;
    return ThemeCollection(themes: {
      AppThemes.darkBlue: ThemeData(
          primarySwatch: const MaterialColor(
            0xff020E36,
            <int, Color>{
              50: Color(0xff020E36),
              100: Color(0xff020E36),
              200: Color(0xff020E36),
              300: Color(0xff020E36),
              400: Color(0xff020E36),
              500: Color(0xff020E36),
              600: Color(0xff020E36),
              700: Color(0xff020E36),
              800: Color(0xff020E36),
              900: Color(0xff020E36),
            },
          ),
          backgroundColor: ColorResource.colorF7F8FA,
          buttonTheme: darkButtonTheme,
          primaryColor: ColorResource.color23375A,
          textTheme: AppThemes().basicTextTheme(base.textTheme),
          floatingActionButtonTheme: darkFABTheme.copyWith(
              backgroundColor: ColorResource.colorEA6D48)),
      AppThemes.lightOrange: ThemeData(
          primarySwatch: const MaterialColor(
            0xffFDF3E6,
            <int, Color>{
              50: Color(0xffFDF3E6),
              100: Color(0xffFDF3E6),
              200: Color(0xffFDF3E6),
              300: Color(0xffFDF3E6),
              400: Color(0xffFDF3E6),
              500: Color(0xffFDF3E6),
              600: Color(0xffFDF3E6),
              700: Color(0xffFDF3E6),
              800: Color(0xffFDF3E6),
              900: Color(0xffFDF3E6),
            },
          ),
          buttonTheme: darkButtonTheme,
          textTheme: AppThemes().basicTextTheme(base.textTheme),
          floatingActionButtonTheme: darkFABTheme.copyWith(
              backgroundColor: ColorResource.colorEA6D48)),
    });
  }

  static String toStr(int themeId) {
    switch (themeId) {
      case darkBlue:
        return 'Dark Blue';
      case lightOrange:
        return 'Light Orange';

      default:
        return 'Unknown';
    }
  }

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

      subtitle1: base.subtitle1!.copyWith(
          fontFamily: 'Lato',
          fontSize: 20.0,
          color: ColorResource.colorFFFFFF,
          fontWeight: FontWeight.w700),

      //Used for font size of 12
      subtitle2: base.subtitle1!.copyWith(
          fontFamily: 'Lato',
          fontSize: 14.0,
          color: ColorResource.color666666,
          fontWeight: FontWeight.w400),

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

// class AppTheme {
//   TextTheme basicTextTheme(TextTheme base) {
//     return base.copyWith(
//       // //Used for font size of 6
//       // caption: base.caption!.copyWith(
//       //     fontFamily: 'Source Sans Pro',
//       //     fontSize: 6.0,
//       //     color: ColorResource.colorFFFFFF,
//       //     fontWeight: FontWeight.w400),

//       // //Used for font size of 12
//       // subtitle2: base.subtitle2!.copyWith(
//       //     fontFamily: 'SourceSansPro',
//       //     fontSize: 12.0,
//       //     color: ColorResource.color787878,
//       //     fontWeight: FontWeight.w400),

//       //Used for font size of 14
//       subtitle1: base.subtitle1!.copyWith(
//           fontFamily: 'Lato',
//           fontSize: 20.0,
//           color: ColorResource.colorFFFFFF,
//           fontWeight: FontWeight.w700),

//       //Used for font size of 12
//       subtitle2: base.subtitle1!.copyWith(
//           fontFamily: 'Lato',
//           fontSize: 14.0,
//           color: ColorResource.color666666,
//           fontWeight: FontWeight.w400),

//       // //Used for emphasizing text and font size of 18,20,22
//       // bodyText1: base.bodyText1!.copyWith(
//       //     fontFamily: 'SourceSansPro',
//       //     fontSize: 16.0,
//       //     color: ColorResource.color222222,
//       //     fontWeight: FontWeight.w600,
//       //     height: 1.5),

//       // //Used for large text in dialogs and font size of 24
//       // headline5: base.headline5!.copyWith(
//       //     fontFamily: 'SourceSansPro',
//       //     fontSize: 18.0,
//       //     color: ColorResource.color222222,
//       //     fontWeight: FontWeight.w600),

//       // //Used for the primary text in app bars and font size of 26,28 and greater
//       // headline6: base.headline6!.copyWith(
//       //     fontFamily: 'SourceSansPro',
//       //     fontSize: 28.0,
//       //     color: Colors.white,
//       //     fontWeight: FontWeight.w700),

//       // //used for button
//       // button: base.bodyText1!.copyWith(
//       //   fontFamily: 'SourceSansPro',
//       //   fontSize: 14.0,
//       //   fontWeight: FontWeight.w600,
//       // ),
//     );
//   }
// }
