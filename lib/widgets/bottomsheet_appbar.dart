// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class BottomSheetAppbar extends StatelessWidget {
  final String? title;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  const BottomSheetAppbar({Key? key, this.title, this.padding, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ?? EdgeInsets.fromLTRB(25, 0, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title!,
              fontSize: FontSize.sixteen,
              fontWeight: FontWeight.w700,
              color: color ?? ColorResource.color101010,
              fontStyle: FontStyle.normal,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  ImageResource.close,
                  color: color,
                )),
          ],
        ));
  }
}
