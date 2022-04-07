import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class NoCaseAvailble {
  static Widget buildNoCaseAvailable(
      {String messageContent = Constants.noCasesAvailable}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
        width: double.infinity,
        height: 210,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(ImageResource.noCaseAvailable),
            CustomText(
              messageContent,
              fontSize: FontSize.sixteen,
              color: ColorResource.color000000,
            ),
          ],
        ),
      ),
    );
  }
}
