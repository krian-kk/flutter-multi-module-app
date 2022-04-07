import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class BottomSheetAppbar extends StatelessWidget {
  const BottomSheetAppbar(
      {Key? key, this.title, this.padding, this.color, this.onTap})
      : super(key: key);
  final String? title;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ?? const EdgeInsets.fromLTRB(25, 0, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomText(
              title!,
              fontSize: FontSize.sixteen,
              fontWeight: FontWeight.w700,
              color: color ?? ColorResource.color101010,
            ),
            InkWell(
                onTap: onTap ??
                    () {
                      Navigator.pop(context);
                    },
                // () {
                //   Navigator.pop(context);
                // },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                  child: SvgPicture.asset(
                    ImageResource.close,
                    color: color,
                  ),
                )),
          ],
        ));
  }
}
