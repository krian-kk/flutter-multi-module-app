import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/image_resource.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({Key? key, this.onTap}) : super(key: key);
  final GestureTapCallback? onTap;

  @override
  _CustomFloatingActionButtonState createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: SvgPicture.asset(ImageResource.search),
      splashColor: ColorResource.colorEA6D48,
      foregroundColor: ColorResource.colorEA6D48,
      backgroundColor: ColorResource.colorEA6D48,
      highlightElevation: 7,
      onPressed: widget.onTap,
    );
  }
}
