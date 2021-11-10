import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/custom_text.dart';

class DialogUtils {
  static Future<void> showDialog(
      {required BuildContext buildContext,
      required String title,
      required String description,
      required String okBtnText,
      String? otherButton,
      String? cancelBtnText,
      required Function(String) okBtnFunction}) async {
    await showCupertinoDialog(
      context: buildContext,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: CustomText(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: ColorResource.color000000, fontSize: FontSize.sixteen),
        ),
        content: CustomText(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: ColorResource.color23375A, fontSize: FontSize.fourteen),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: CustomText(
              okBtnText,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.blue, fontSize: FontSize.fourteen),
            ),
            onPressed: () {
              okBtnFunction(okBtnText);
            },
          ),
          if (cancelBtnText != null)
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: CustomText(
                cancelBtnText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: ColorResource.color23375A,
                    fontSize: FontSize.fourteen),
              ),
            ),
          if (otherButton != null)
            CupertinoDialogAction(
              child: CustomText(
                otherButton,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: ColorResource.color23375A,
                    fontSize: FontSize.fourteen),
              ),
              onPressed: () {
                okBtnFunction(otherButton);
              },
            ),
        ],
      ),
    );
  }
}
