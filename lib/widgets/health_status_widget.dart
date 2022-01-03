import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/utils/image_resource.dart';

class ShowHealthStatus {
  static Widget healthStatus(healthValue) {
    Widget? returnWidget;
    switch (healthValue) {
      case '0':
        returnWidget = SvgPicture.asset(
          ImageResource.activePerson,
          color: Colors.red,
        );
        break;
      case '1':
        returnWidget = SvgPicture.asset(
          ImageResource.activePerson,
          color: Colors.orange,
        );
        break;
      case '2':
        returnWidget = SvgPicture.asset(
          ImageResource.activePerson,
          color: Colors.green,
        );
        break;
      default:
        returnWidget = SvgPicture.asset(
          ImageResource.activePerson,
          color: Colors.pink[100],
        );
        break;
    }
    return returnWidget;
  }
}
