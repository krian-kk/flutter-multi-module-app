import 'package:flutter/material.dart';

import '../app_sizes.dart';
import '../colors.dart';
import '../fonts.dart';

class TextBtnWidget extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;

  const TextBtnWidget({
    Key? key,
    required this.btnText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        btnText,
        style: const TextStyle(
            color: textColor,
            fontWeight: textFontWeightNormal,
            fontSize: Sizes.p16),
      ),
    );
  }
}
