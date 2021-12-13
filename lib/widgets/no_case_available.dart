import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class NoCaseAvailble {
  static Widget buildNoCaseAvailable(){
    return Card(
      child: Column(
        children: [
          Image.asset(ImageResource.noCaseAvailable),
          const SizedBox(height: 25,),
          const CustomText(Constants.noCasesAvailable, fontSize: FontSize.sixteen, color: ColorResource.color000000,),
        ],
      ),
    );
  }
}
