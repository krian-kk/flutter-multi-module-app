// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class CustomEventDetailsBottomSheet extends StatefulWidget {
  CustomEventDetailsBottomSheet(
    this.cardTitle, {
    Key? key,
  }) : super(key: key);
  final String cardTitle;

  @override
  State<CustomEventDetailsBottomSheet> createState() =>
      _CustomEventDetailsBottomSheetState();
}

class _CustomEventDetailsBottomSheetState
    extends State<CustomEventDetailsBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(23, 16, 15, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  widget.cardTitle,
                  color: ColorResource.color101010,
                  fontWeight: FontWeight.w700,
                  fontSize: FontSize.sixteen,
                  fontStyle: FontStyle.normal,
                ),
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(ImageResource.close))
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorResource.colorF7F8FA,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              'DEBASISH PATNAIK',
                              fontWeight: FontWeight.w700,
                              fontSize: FontSize.fourteen,
                              fontStyle: FontStyle.normal,
                              color: ColorResource.color333333,
                            ),
                            SizedBox(height: 7),
                            CustomText(
                              'TVSF_BFRT6458922993',
                              fontWeight: FontWeight.w400,
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
                              '397553.67',
                              fontWeight: FontWeight.w700,
                              fontSize: FontSize.twentyFour,
                              fontStyle: FontStyle.normal,
                              color: ColorResource.color333333,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 11),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              color: ColorResource.colorFFFFFF,
              boxShadow: [
                BoxShadow(
                  color: ColorResource.color000000.withOpacity(.25),
                  blurRadius: 2.0,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 190,
                    child: CustomButton(
                      Languages.of(context)!.okay.toUpperCase(),
                      fontSize: FontSize.sixteen,
                      fontWeight: FontWeight.w600,
                      // onTap: () => bloc.add(ClickMessageEvent()),
                      cardShape: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
