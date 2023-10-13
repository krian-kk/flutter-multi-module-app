import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:flutter/material.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/widgets/custom_text.dart';

class CustomLoanUserDetails extends StatefulWidget {
  const CustomLoanUserDetails({
    Key? key,
    required this.userName,
    required this.userId,
    required this.userAmount,
    this.marginTop,
    this.isAccountNo = false,
    this.color,
  }) : super(key: key);
  final String userName;
  final String userId;
  final double userAmount;
  final bool isAccountNo;
  final Color? color;
  final double? marginTop;

  @override
  State<CustomLoanUserDetails> createState() => _CustomLoanUserDetailsState();
}

class _CustomLoanUserDetailsState extends State<CustomLoanUserDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: widget.marginTop ?? 0),
      decoration: BoxDecoration(
          color: widget.color ?? ColorResourceDesign.colorF7F8FA,
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomText(
              widget.userName.toUpperCase(),
              fontWeight: FontWeight.w700,
              color: ColorResourceDesign.color333333,
            ),
            SizedBox(height: widget.isAccountNo ? 9 : 7),
            widget.isAccountNo
                ? Column(
                    children: <Widget>[
                      CustomText(
                        Languages.of(context)!.accountNo,
                        fontSize: FontSize.twelve,
                        color: ColorResourceDesign.color666666,
                      ),
                      const SizedBox(height: 7)
                    ],
                  )
                : const SizedBox(),
            CustomText(
              widget.userId.toUpperCase(),
              fontWeight:
                  widget.isAccountNo ? FontWeight.w700 : FontWeight.w400,
              color: ColorResourceDesign.color333333,
            ),
            const SizedBox(height: 17),
            CustomText(
              Languages.of(context)!.overdueAmount,
              fontSize: FontSize.twelve,
              color: ColorResourceDesign.color666666,
            ),
            const SizedBox(height: 9),
            CustomText(
              widget.userAmount.toString(),
              lineHeight: 1,
              fontWeight: FontWeight.w700,
              fontSize: FontSize.twentyFour,
              color: ColorResourceDesign.color333333,
            )
          ],
        ),
      ),
    );
  }
}
