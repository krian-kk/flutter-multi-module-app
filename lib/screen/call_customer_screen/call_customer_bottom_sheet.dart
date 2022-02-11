import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/call_customer_model/call_customer_model.dart';
import 'package:origa/models/case_details_api_model/case_details_api_model.dart';
import 'package:origa/screen/call_customer_screen/bloc/call_customer_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_drop_down_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class CallCustomerBottomSheet extends StatefulWidget {
  final Widget customerLoanUserWidget;
  final String userType;
  final String caseId;
  final String sid;
  final List<String> listOfMobileNo;
  final CaseDetailsApiModel? caseDetailsAPIValue;

  const CallCustomerBottomSheet({
    Key? key,
    required this.customerLoanUserWidget,
    this.caseDetailsAPIValue,
    required this.caseId,
    required this.userType,
    required this.sid,
    required this.listOfMobileNo,
  }) : super(key: key);

  @override
  State<CallCustomerBottomSheet> createState() =>
      _CallCustomerBottomSheetState();
}

class _CallCustomerBottomSheetState extends State<CallCustomerBottomSheet> {
  late CallCustomerBloc bloc;
  TextEditingController agentContactNoControlller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<String> customerContactNoDropdownList = [];
  String customerContactNoDropDownValue = '';

  // List<CaseListModel> caseDetaislListModel = [];

  @override
  void initState() {
    super.initState();
    bloc = CallCustomerBloc()..add(CallCustomerInitialEvent());

    for (var element in widget.listOfMobileNo) {
      customerContactNoDropdownList.add(element);
    }

    customerContactNoDropDownValue = customerContactNoDropdownList.first;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: BlocListener<CallCustomerBloc, CallCustomerState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is NoInternetState) {
            AppUtils.noInternetSnackbar(context);
          }
          if (state is CallCustomerSuccessState) {
            setState(() {
              agentContactNoControlller.text =
                  bloc.voiceAgencyDetails.result?.agentAgencyContact ?? '';
            });
          }
        },
        child: BlocBuilder<CallCustomerBloc, CallCustomerState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is CallCustomerLoadedState) {
              return const CustomLoadingWidget();
            } else if (state is CallCustomerSuccessState) {
              return const CustomLoadingWidget();
            } else {
              return Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.transparent,
                body: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BottomSheetAppbar(
                        title: Languages.of(context)!.callCustomer,
                        padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15)
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        ),
                                      ],
                                    )),
                                    const SizedBox(width: 5),
                                    Flexible(
                                        child: CustomDropDownButton(
                                      Languages.of(context)!.customerContactNo,
                                      customerContactNoDropdownList,
                                      selectedValue:
                                          customerContactNoDropDownValue,
                                      onChanged: (newValue) => setState(() =>
                                          customerContactNoDropDownValue =
                                              newValue.toString()),
                                      icon: SvgPicture.asset(
                                          ImageResource.downShape),
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Flexible(
                                    child: CustomDropDownButton(
                                  Languages.of(context)!.serviceProvidersList,
                                  bloc.serviceProviderListDropdownList,
                                  selectedValue: bloc.serviceProviderListValue,
                                  onChanged: (newValue) {
                                    Singleton.instance.callerServiceID =
                                        (newValue == '') ? null : newValue;
                                    setState(() =>
                                        bloc.serviceProviderListValue =
                                            newValue.toString());
                                  },
                                  icon:
                                      SvgPicture.asset(ImageResource.downShape),
                                )),
                                const SizedBox(height: 20),
                                Flexible(
                                    child: CustomDropDownButton(
                                  Languages.of(context)!.callersId,
                                  bloc.callersIDDropdownList,
                                  isExpanded: true,
                                  selectedValue: bloc.callersIDDropdownValue,
                                  onChanged: (newValue) {
                                    Singleton.instance.callingID =
                                        (newValue == '') ? null : newValue;
                                    setState(() => bloc.callersIDDropdownValue =
                                        newValue.toString());
                                  },
                                  icon:
                                      SvgPicture.asset(ImageResource.downShape),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 5.0),
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
                            isEnabled: bloc.isSubmit,
                            trailingWidget:
                                SvgPicture.asset(ImageResource.vector),
                            onTap: () async {
                              if (mounted) {
                                setState(() {
                                  bloc.isSubmit = false;
                                });
                              }
                              if (_formKey.currentState!.validate()) {
                                // Map<String, dynamic> enableCloudTel =
                                //     await APIRepository.apiRequest(
                                //   APIRequestType.POST,
                                //   HttpUrl.enableCloudTelephony,
                                //   requestBodydata: {
                                //     "contractor": Singleton.instance.contractor
                                //   },
                                // );
                                // if (enableCloudTel['data']['result']) {
                                // print(enableCloudTel['data']);
                                // Singleton.instance.callingID != ''
                                if (Singleton.instance.cloudTelephony! &&
                                    Singleton.instance.callingID != null) {
                                  // print("call id checking");
                                  var requestBodyData = CallCustomerModel(
                                    from: agentContactNoControlller.text,
                                    to: customerContactNoDropDownValue,
                                    callerId:
                                        Singleton.instance.callingID ?? '',
                                    aRef: Singleton.instance.agentRef ?? '',
                                    customerName:
                                        Singleton.instance.agentName ?? '',
                                    service: bloc.serviceProviderListValue,
                                    callerServiceID:
                                        Singleton.instance.callerServiceID ??
                                            '',
                                    caseId: widget.caseId,
                                    sId: widget.sid,
                                    // agrRef: Singleton.instance.agentRef ?? '',
                                    //AgrRef is Agrement number
                                    agrRef: widget.caseDetailsAPIValue!.result!
                                            .caseDetails!.agrRef ??
                                        '',
                                    agentName:
                                        Singleton.instance.agentName ?? '',
                                    agentType: (widget.userType ==
                                            Constants.telecaller)
                                        ? 'TELECALLER'
                                        : 'COLLECTOR',
                                  );

                                  Map<String, dynamic> postResult =
                                      await APIRepository.apiRequest(
                                    APIRequestType.POST,
                                    HttpUrl.callCustomerUrl,
                                    requestBodydata:
                                        jsonEncode(requestBodyData),
                                  );
                                  if (postResult[Constants.success]) {
                                    AppUtils.showToast(
                                        Constants.callConnectedPleaseWait);
                                  }
                                  // else {}
                                } else {
                                  // print(" no call call id checking");

                                  AppUtils.makePhoneCall(
                                      'tel:' + customerContactNoDropDownValue);
                                }
                                // } else {
                                //   AppUtils.makePhoneCall(
                                //       'tel:' + customerContactNoDropDownValue);
                                // }
                              }
                              if (mounted) {
                                setState(() {
                                  bloc.isSubmit = true;
                                });
                              }
                            },
                            cardShape: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
