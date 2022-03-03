import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/image_resource.dart';

class ShowHealthStatus {
  static Widget healthStatus(healthValue) {
    Widget? returnWidget;
    switch (healthValue) {
      case '0':
        returnWidget = SvgPicture.asset(
          ImageResource.activePerson,
          color: ColorResource.red,
        );
        break;
      case '1':
        returnWidget = SvgPicture.asset(
          ImageResource.activePerson,
          color: ColorResource.orange,
        );
        break;
      case '2':
        returnWidget = SvgPicture.asset(
          ImageResource.activePerson,
          color: ColorResource.green,
        );
        break;
      default:
        returnWidget = SvgPicture.asset(
          ImageResource.activePerson,
          color: ColorResource.grey,
        );
        break;
    }
    return returnWidget;
  }
}
