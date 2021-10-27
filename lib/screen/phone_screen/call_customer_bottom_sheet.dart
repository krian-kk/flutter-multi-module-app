// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_drop_down_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class CallCustomerBottomSheet extends StatefulWidget {
  const CallCustomerBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<CallCustomerBottomSheet> createState() =>
      _CallCustomerBottomSheetState();
}

class _CallCustomerBottomSheetState extends State<CallCustomerBottomSheet> {
  TextEditingController agentContactNoControlller = TextEditingController();

  List<String> customerContactNoDropdownList = [
    '6524869550',
    '6524869534',
    '6524869456',
    '6524861234'
  ];

  List<String> serviceProviderListDropdownList = ['ABC', 'DEF', 'GHI', 'JKL'];

  List<String> callersIDDropdownList = ['ABC', 'DEF', 'GHI', 'JKL'];

  @override
  void initState() {
    super.initState();
    agentContactNoControlller.text = '7002792169';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(23, 16, 15, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                Languages.of(context)!.callCustomer,
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Flexible(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            Languages.of(context)!.agentContactNo,
                            fontSize: FontSize.twelve,
                            fontWeight: FontWeight.w400,
                            color: ColorResource.color666666,
                            fontStyle: FontStyle.normal,
                          ),
                          CustomReadOnlyTextField(
                            '',
                            agentContactNoControlller,
                            height: 46,
                            isReadOnly: true,
                          ),
                        ],
                      )),
                      SizedBox(width: 5),
                      Flexible(
                          child: CustomDropDownButton(
                        Languages.of(context)!.customerContactNo,
                        customerContactNoDropdownList,
                        icon: ImageIcon(
                          AssetImage(ImageResource.downShape),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: 15),
                  Flexible(
                      child: CustomDropDownButton(
                    Languages.of(context)!.serviceProvidersList,
                    serviceProviderListDropdownList,
                    icon: ImageIcon(
                      AssetImage(ImageResource.downShape),
                    ),
                  )),
                  SizedBox(height: 20),
                  Flexible(
                      child: CustomDropDownButton(
                    Languages.of(context)!.callersId,
                    callersIDDropdownList,
                    icon: ImageIcon(
                      AssetImage(ImageResource.downShape),
                    ),
                  )),
                  SizedBox(height: 15)
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 95,
                    child: Center(
                        child: CustomText(
                      Languages.of(context)!.done.toUpperCase(),
                      color: ColorResource.colorEA6D48,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: FontSize.sixteen,
                    ))),
                SizedBox(width: 25),
                SizedBox(
                  width: 191,
                  child: CustomButton(
                    Languages.of(context)!.call.toUpperCase(),
                    fontSize: FontSize.sixteen,
                    fontWeight: FontWeight.w600,
                    isLeading: true,
                    trailingWidget: Image.asset(ImageResource.vector),
                    // onTap: () => bloc.add(ClickMessageEvent()),
                    cardShape: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
