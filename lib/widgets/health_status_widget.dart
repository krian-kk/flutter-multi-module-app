import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/image_resource.dart';

class ShowHealthStatus {
  static Widget healthStatus(dynamic healthValue) {
    Widget? returnWidget;
    switch (healthValue) {
      case '0':
        // returnWidget = colorWidget(ColorResource.red);
        returnWidget = SvgPicture.asset(
          ImageResource.activePerson,
          color: ColorResource.red,
        );
        break;
      case '1':
        // returnWidget = colorWidget(ColorResource.orange);
        returnWidget = SvgPicture.asset(
          ImageResource.activePerson,
          color: ColorResource.orange,
        );
        break;
      case '2':
        // returnWidget = colorWidget(ColorResource.green);
        returnWidget = SvgPicture.asset(
          ImageResource.activePerson,
          color: ColorResource.green,
        );
        break;
      default:
        // returnWidget = colorWidget(ColorResource.grey);
        returnWidget =
            // CircleAvatar(
            //   backgroundColor: ColorResource.color23375A,
            //   radius: 10,
            //   child: Center(
            //     child: SvgPicture.asset(
            //       ImageResource.direction,
            //     ),
            //   ),
            // );
            SvgPicture.asset(
          ImageResource.activePerson,
          color: ColorResource.grey,
        );
        break;
    }
    return returnWidget;
  }

  static Widget colorWidget(Color color) {
    return CircleAvatar(
      backgroundColor: color.withOpacity(0.4),
      radius: 10,
      child: Center(
          child: CircleAvatar(
        backgroundColor: color,
        radius: 5.5,
      )),
    );
  }
}
