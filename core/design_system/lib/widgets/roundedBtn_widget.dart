import 'package:flutter/material.dart';

class RoundedBtnWidget extends StatelessWidget {
  final int? btnBackgroundColor;
  final int? btnBorderColor;
  final double? btnWidth;
  final double? btnHeight;
  final String? btnText;
  final int? btnTextColor;
  final FontWeight? btnTextFontWeight;
  final double? btnTextFontSize;

  // final Function onPressed;

  const RoundedBtnWidget({
    Key? key,
    this.btnBackgroundColor = 0xFF151515,
    this.btnBorderColor = 0xFF23375A,
    this.btnWidth = 320,
    this.btnHeight = 50,
    this.btnText = '',
    this.btnTextColor = 0xFF23375A,
    this.btnTextFontWeight = FontWeight.w600,
    this.btnTextFontSize = 16,
    // required this.onPressed,
  }) : super(key: key);

  RoundedBtnWidget copyWith({
    final int? btnBackgroundColor,
    final int? btnBorderColor,
    final double? btnWidth,
    final double? btnHeight,
    final String? btnText,
    final int? btnTextColor,
    final FontWeight? btnTextFontWeight,
    final double? btnTextFontSize,
    // final Function? onPressed,
  }) {
    return RoundedBtnWidget(
      btnBackgroundColor: btnBackgroundColor ?? this.btnBackgroundColor,
      btnBorderColor: btnBorderColor ?? this.btnBorderColor,
      btnWidth: btnWidth ?? this.btnWidth,
      btnHeight: btnHeight ?? this.btnHeight,
      btnText: btnText ?? this.btnText,
      btnTextColor: btnTextColor ?? this.btnTextColor,
      btnTextFontWeight: btnTextFontWeight ?? this.btnTextFontWeight,
      btnTextFontSize: btnTextFontSize ?? this.btnTextFontSize,
      // onPressed: onPressed ?? this.onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(btnBackgroundColor!),
        side: BorderSide(
          width: 0.5,
          color: Color(btnBorderColor!),
        ),
        minimumSize: Size(btnWidth!, btnHeight!),
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
      // onPressed: onPressed(),
      onPressed: () {},
      child: Text(btnText!,
          style: TextStyle(
              color: Color(btnTextColor!),
              fontWeight: btnTextFontWeight,
              fontSize: btnTextFontSize)),
    );
  }
}
