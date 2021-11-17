import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_drop_down_button.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
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
        BottomSheetAppbar(
          title: Languages.of(context)!.callCustomer,
          padding: const EdgeInsets.fromLTRB(23, 16, 15, 5),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CustomLoanUserDetails(
                    userName: 'DEBASISH PATNAIK',
                    userId: 'TVSF_BFRT6458922993',
                    userAmount: 397553.67,
                  ),
                  const SizedBox(height: 18),
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
                      const SizedBox(width: 5),
                      Flexible(
                          child: CustomDropDownButton(
                        Languages.of(context)!.customerContactNo,
                        customerContactNoDropdownList,
                        icon: const ImageIcon(
                          AssetImage(ImageResource.downShape),
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Flexible(
                      child: CustomDropDownButton(
                    Languages.of(context)!.serviceProvidersList,
                    serviceProviderListDropdownList,
                    icon: const ImageIcon(
                      AssetImage(ImageResource.downShape),
                    ),
                  )),
                  const SizedBox(height: 20),
                  Flexible(
                      child: CustomDropDownButton(
                    Languages.of(context)!.callersId,
                    callersIDDropdownList,
                    icon: const ImageIcon(
                      AssetImage(ImageResource.downShape),
                    ),
                  )),
                  const SizedBox(height: 15)
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
                offset: const Offset(1.0, 1.0),
              ),
            ],
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
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
                const SizedBox(width: 25),
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
