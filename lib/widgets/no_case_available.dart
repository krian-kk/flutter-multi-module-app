import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class NoCaseAvailble {
  static Widget buildNoCaseAvailable() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
        width: 320,
        height: 210,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(ImageResource.noCaseAvailable),
            Image.asset(ImageResource.caseNotAvailable),
            // const SizedBox(height: 25,),
            const CustomText(
              Constants.noCasesAvailable,
              fontSize: FontSize.sixteen,
              color: ColorResource.color000000,
            ),
          ],
        ),
      ),
    );
  }
}
