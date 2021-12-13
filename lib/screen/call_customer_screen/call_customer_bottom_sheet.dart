import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/Telecaller/screens/allocation_T/bloc/allocation_t_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/dashboard_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_drop_down_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class CallCustomerBottomSheet extends StatefulWidget {
  final dynamic blocObject;
  final Widget customerLoanUserWidget;
  const CallCustomerBottomSheet(
      {Key? key, this.blocObject, required this.customerLoanUserWidget})
      : super(key: key);

  @override
  State<CallCustomerBottomSheet> createState() =>
      _CallCustomerBottomSheetState();
}

class _CallCustomerBottomSheetState extends State<CallCustomerBottomSheet> {
  TextEditingController agentContactNoControlller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<String> customerContactNoDropdownList = [
    '6524869550',
    '6524869534',
    '6524869456',
    '6524861234'
  ];

  String customerContactNoDropDownValue = '6524869550';

  List<String> serviceProviderListDropdownList = ['ABC', 'DEF', 'GHI', 'JKL'];

  String serviceProviderListValue = 'ABC';

  List<String> callersIDDropdownList = ['ABC', 'DEF', 'GHI', 'JKL'];

  String callersIDDropdownValue = 'ABC';

  List<CaseListModel> caseDetaislListModel = [];
  AllocationTBloc? allocationTBloc;
  CaseDetailsBloc? caseDetailsBloc;
  @override
  void initState() {
    super.initState();
    // agentContactNoControlller.text = '7002792169';
    if (widget.blocObject is AllocationTBloc) {
      allocationTBloc = widget.blocObject;
    } else if (widget.blocObject is CaseDetailsBloc) {
      caseDetailsBloc = widget.blocObject;
    }
    if (allocationTBloc != null) {
      // print("Allocation");
    } else if (caseDetailsBloc != null) {
      // print("CaseDetails");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.89,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomSheetAppbar(
                  title: Languages.of(context)!.callCustomer,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
                          .copyWith(bottom: 5),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widget.customerLoanUserWidget,
                          const SizedBox(height: 18),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    validationRules: const ['required'],
                                    height: 46,
                                    // isReadOnly: true,
                                  ),
                                ],
                              )),
                              const SizedBox(width: 5),
                              Flexible(
                                  child: CustomDropDownButton(
                                Languages.of(context)!.customerContactNo,
                                customerContactNoDropdownList,
                                selectedValue: customerContactNoDropDownValue,
                                onChanged: (newValue) => setState(() =>
                                    customerContactNoDropDownValue =
                                        newValue.toString()),
                                icon: SvgPicture.asset(ImageResource.downShape),
                              )),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Flexible(
                              child: CustomDropDownButton(
                            Languages.of(context)!.serviceProvidersList,
                            serviceProviderListDropdownList,
                            selectedValue: serviceProviderListValue,
                            onChanged: (newValue) => setState(() =>
                                serviceProviderListValue = newValue.toString()),
                            icon: SvgPicture.asset(ImageResource.downShape),
                          )),
                          const SizedBox(height: 20),
                          Flexible(
                              child: CustomDropDownButton(
                            Languages.of(context)!.callersId,
                            callersIDDropdownList,
                            isExpanded: true,
                            selectedValue: callersIDDropdownValue,
                            onChanged: (newValue) => setState(() =>
                                callersIDDropdownValue = newValue.toString()),
                            icon: SvgPicture.asset(ImageResource.downShape),
                          )),
                          const SizedBox(height: 15)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SizedBox(
                        width: 95,
                        child: Center(
                            child: CustomText(
                          Languages.of(context)!.done.toUpperCase(),
                          color: ColorResource.colorEA6D48,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: FontSize.sixteen,
                        ))),
                  ),
                  const SizedBox(width: 25),
                  SizedBox(
                    width: 191,
                    child: CustomButton(
                      Languages.of(context)!.call.toUpperCase(),
                      fontSize: FontSize.sixteen,
                      fontWeight: FontWeight.w600,
                      isLeading: true,
                      trailingWidget: SvgPicture.asset(ImageResource.vector),
                      onTap: () => _formKey.currentState!.validate(),
                      cardShape: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
