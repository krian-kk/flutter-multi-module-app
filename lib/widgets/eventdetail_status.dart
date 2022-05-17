import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';

class EventDetailsAppStatus {
  static Widget eventDetailAppStatus(String appStatusValue) {
    Widget? returnWidget;
    switch (appStatusValue) {
      case 'approved':
        returnWidget = colorWidget(ColorResource.green);
        break;
      case 'new':
        returnWidget = colorWidget(ColorResource.orange);
        break;
      case 'rejected':
        returnWidget = colorWidget(ColorResource.red);
        break;
      case 'pending':
        returnWidget = colorWidget(ColorResource.orange);
        break;
      default:
        returnWidget = const SizedBox();
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
