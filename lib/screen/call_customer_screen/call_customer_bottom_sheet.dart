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
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
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
  final String? custName;
  final String? contactNumber;
  final bool? isCallFromCallDetails;
  final CaseDetailsBloc caseDetailsBloc;

  const CallCustomerBottomSheet({
    Key? key,
    required this.customerLoanUserWidget,
    this.caseDetailsAPIValue,
    required this.caseId,
    required this.userType,
    required this.sid,
    required this.listOfMobileNo,
    this.custName,
    this.contactNumber,
    this.isCallFromCallDetails,
    required this.caseDetailsBloc,
  }) : super(key: key);

  @override
  State<CallCustomerBottomSheet> createState() =>
      _CallCustomerBottomSheetState();
}

class _CallCustomerBottomSheetState extends State<CallCustomerBottomSheet> {
  late CallCustomerBloc bloc;
  late TextEditingController agentContactNoControlller;

  final _formKey = GlobalKey<FormState>();

  List<String> customerContactNoDropdownList = [];
  String customerContactNoDropDownValue = '';

  @override
  void initState() {
    super.initState();
    agentContactNoControlller = TextEditingController();
    bloc = CallCustomerBloc()..add(CallCustomerInitialEvent());
    customerContactNoDropDownValue = widget.contactNumber!;
    for (var element in widget.listOfMobileNo) {
      customerContactNoDropdownList.add(element);
    }
  }

  @override
  void dispose() {
    agentContactNoControlller.dispose();
    super.dispose();
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
              //For hot-code testing
              // agentContactNoControlller.text = '9585313659';
            });
          }
          if (state is NavigationPhoneBottomSheetState) {
            Navigator.pop(context);
            debugPrint(
                '$this ---> index in call customer screen ${widget.caseDetailsBloc.indexValue} ');
            widget.caseDetailsBloc.add(ClickMainCallBottomSheetEvent(
              widget.caseDetailsBloc.indexValue ?? 0,
              isCallFromCaseDetails: true,
              callId: state.callId,
            ));
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
                                          isReadOnly: true,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  0, 15, 0, 9),
                                        ),
                                      ],
                                    )),
                                    const SizedBox(width: 5),
                                    Flexible(
                                      child: CustomDropDownButton(
                                        Languages.of(context)!
                                            .customerContactNo,
                                        customerContactNoDropdownList,
                                        selectedValue:
                                            customerContactNoDropDownValue,
                                        onChanged: (newValue) => setState(() {
                                          customerContactNoDropDownValue =
                                              newValue.toString();
                                        }),
                                        icon: SvgPicture.asset(
                                          ImageResource.downShape,
                                        ),
                                      ),
                                    ),
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
                        Expanded(
                            child: CustomButton(
                          Languages.of(context)!.done.toUpperCase(),
                          fontSize: FontSize.eighteen,
                          fontWeight: FontWeight.w600,
                          buttonBackgroundColor: Colors.white,
                          borderColor: Colors.white,
                          textColor: ColorResource.colorEA6D48,
                          onTap: () => Navigator.pop(context),
                          cardShape: 5,
                        )),
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
                                if (Singleton.instance.cloudTelephony! &&
                                    Singleton.instance.callingID != null) {
                                  var requestBodyData = CallCustomerModel(
                                    //Mobile user number as Agent contact number
                                    from: agentContactNoControlller.text,
                                    //Customer mobile number
                                    to: customerContactNoDropDownValue,
                                    // to: '7904557342',
                                    callerId:
                                        Singleton.instance.callingID ?? '',
                                    aRef: Singleton.instance.agentRef ?? '',
                                    customerName: widget.custName!,
                                    service: bloc.serviceProviderListValue,
                                    callerServiceID:
                                        Singleton.instance.callerServiceID ??
                                            '',
                                    caseId: widget.caseId,
                                    sId: widget.sid,
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
                                    APIRequestType.post,
                                    HttpUrl.callCustomerUrl,
                                    requestBodydata:
                                        jsonEncode(requestBodyData),
                                  );
                                  if (postResult[Constants.success]) {
                                    AppUtils.showToast(Languages.of(context)!
                                        .callConnectedPleaseWait);
                                    if (widget.isCallFromCallDetails ?? false) {
                                      bloc.add(NavigationPhoneBottomSheetEvent(
                                          postResult['data']['result']));
                                    }
                                  }
                                } else {
                                  AppUtils.makePhoneCall(
                                      'tel:' + customerContactNoDropDownValue);
                                }
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
