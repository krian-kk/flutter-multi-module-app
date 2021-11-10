// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/custom_text.dart';

class CustomLoanUserDetails extends StatefulWidget {
  final String userName;
  final String userId;
  final double userAmount;
  final bool isAccountNo;
  final Color? color;
  final double? marginTop;
  const CustomLoanUserDetails({
    Key? key,
    required this.userName,
    required this.userId,
    required this.userAmount,
    this.marginTop,
    this.isAccountNo = false,
    this.color,
  }) : super(key: key);

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
          color: widget.color ?? ColorResource.colorF7F8FA,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              widget.userName.toUpperCase(),
              fontWeight: FontWeight.w700,
              fontSize: FontSize.fourteen,
              fontStyle: FontStyle.normal,
              color: ColorResource.color333333,
            ),
            SizedBox(height: widget.isAccountNo ? 9 : 7),
            widget.isAccountNo
                ? Column(
                    children: [
                      CustomText(
                        Languages.of(context)!.accountNo,
                        fontWeight: FontWeight.w400,
                        fontSize: FontSize.twelve,
                        fontStyle: FontStyle.normal,
                        color: ColorResource.color666666,
                      ),
                      SizedBox(height: 7)
                    ],
                  )
                : SizedBox(),
            CustomText(
              widget.userId.toUpperCase(),
              fontWeight:
                  widget.isAccountNo ? FontWeight.w700 : FontWeight.w400,
              fontSize: FontSize.fourteen,
              fontStyle: FontStyle.normal,
              color: ColorResource.color333333,
            ),
            SizedBox(height: 17),
            CustomText(
              Languages.of(context)!.overdueAmount,
              fontWeight: FontWeight.w400,
              fontSize: FontSize.twelve,
              fontStyle: FontStyle.normal,
              color: ColorResource.color666666,
            ),
            SizedBox(height: 9),
            CustomText(
              widget.userAmount.toString(),
              lineHeight: 1,
              fontWeight: FontWeight.w700,
              fontSize: FontSize.twentyFour,
              fontStyle: FontStyle.normal,
              color: ColorResource.color333333,
            )
          ],
        ),
      ),
    );
  }
}
