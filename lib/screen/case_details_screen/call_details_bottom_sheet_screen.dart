import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/update_health_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/health_status_widget.dart';

class CallDetailsBottomSheetScreen extends StatefulWidget {
  const CallDetailsBottomSheetScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final CaseDetailsBloc bloc;

  @override
  State<CallDetailsBottomSheetScreen> createState() =>
      _CallDetailsBottomSheetScreenState();
}

class _CallDetailsBottomSheetScreenState
    extends State<CallDetailsBottomSheetScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is AddedNewCallContactListState) {
          widget.bloc.listOfCallDetails;
        }

        if (state is UpdateHealthStatusState) {
          UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
              Map<String, dynamic>.from(Singleton.instance.updateHealthStatus));

          setState(() {
            switch (data.tabIndex) {
              case 0:
                widget.bloc.caseDetailsAPIValue.result
                    ?.callDetails![data.selectedHealthIndex!]['health'] = '2';
                break;
              case 1:
                widget.bloc.caseDetailsAPIValue.result
                    ?.callDetails![data.selectedHealthIndex!]['health'] = '1';
                break;
              case 2:
                widget.bloc.caseDetailsAPIValue.result
                    ?.callDetails![data.selectedHealthIndex!]['health'] = '0';
                break;
              default:
                widget.bloc.caseDetailsAPIValue.result
                        ?.callDetails![data.selectedHealthIndex!]['health'] =
                    data.currentHealth;
                break;
            }
          });
        }
      },
      child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
        bloc: widget.bloc,
        builder: (context, state) {
          widget.bloc.listOfCallDetails;

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.89,
            child: Column(
              children: [
                BottomSheetAppbar(
                  title: Languages.of(context)!.callDetails.toUpperCase(),
                  padding: const EdgeInsets.fromLTRB(21, 13, 21, 12),
                  color: ColorResource.color23375A,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(21, 0, 21, 12),
                  child: CustomLoanUserDetails(
                    userName: widget.bloc.caseDetailsAPIValue.result
                            ?.caseDetails?.cust ??
                        '_',
                    userId: widget.bloc.caseDetailsAPIValue.result?.caseDetails
                            ?.accNo ??
                        '_',
                    userAmount: widget
                            .bloc.caseDetailsAPIValue.result?.caseDetails?.due
                            ?.toDouble() ??
                        0,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 21, vertical: 13)
                            .copyWith(top: 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                widget.bloc.listOfCallDetails?.length ?? 0,
                            itemBuilder: (context, i) {
                              return widget.bloc.listOfCallDetails?[i]
                                              ['cType'] ==
                                          "mobile" ||
                                      widget.bloc.listOfCallDetails?[i]
                                              ['cType'] ==
                                          "resNo" ||
                                      widget.bloc.listOfCallDetails?[i]
                                              ['cType'] ==
                                          "office contact no." ||
                                      widget.bloc.listOfCallDetails?[i]
                                              ['cType'] ==
                                          "residence contact no."
                                  ? SizedBox(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            widget
                                                    .bloc
                                                    .listOfCallDetails?[i]
                                                        ['cType']
                                                    .toString()
                                                    .toUpperCase() ??
                                                '_',
                                            fontSize: FontSize.fourteen,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            color: ColorResource.color23375A,
                                          ),
                                          const SizedBox(height: 7),
                                          GestureDetector(
                                            onTap: () {
                                              widget.bloc.add(
                                                  ClickMainCallBottomSheetEvent(
                                                      i));
                                              Singleton
                                                  .instance.contactId_0 = widget
                                                          .bloc
                                                          .caseDetailsAPIValue
                                                          .result
                                                          ?.callDetails![i]
                                                      ['contactId_0'] ??
                                                  "";
                                              Singleton.instance
                                                      .customerContactNo =
                                                  widget
                                                      .bloc
                                                      .caseDetailsAPIValue
                                                      .result
                                                      ?.callDetails![i]['value']
                                                      .toString()
                                                      .toUpperCase();
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: const BoxDecoration(
                                                  color:
                                                      ColorResource.colorF8F9FB,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 12, 12, 12),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flexible(
                                                          child: Row(
                                                            children: [
                                                              CustomText(
                                                                widget.bloc
                                                                        .listOfCallDetails?[
                                                                    i]['value'],
                                                                fontSize: FontSize
                                                                    .fourteen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                color: ColorResource
                                                                    .color484848,
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: ShowHealthStatus
                                                              .healthStatus(widget
                                                                          .bloc
                                                                          .listOfCallDetails?[i]
                                                                      [
                                                                      'health'] ??
                                                                  ''),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                            child: InkWell(
                                                          onTap: () {
                                                            debugPrint(
                                                                "call customer--->");
                                                            widget.bloc.add(ClickOpenBottomSheetEvent(
                                                                Constants
                                                                    .callCustomer,
                                                                widget
                                                                    .bloc
                                                                    .caseDetailsAPIValue
                                                                    .result
                                                                    ?.callDetails,
                                                                false,
                                                                seleectedContactNumber:
                                                                    widget.bloc.listOfCallDetails?[i]
                                                                            [
                                                                            'value'] ??
                                                                        ''));
                                                          },
                                                          child: Container(
                                                              decoration: const BoxDecoration(
                                                                  color: ColorResource
                                                                      .colorBEC4CF,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              75.0))),
                                                              child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundColor:
                                                                        ColorResource
                                                                            .color23375A,
                                                                    radius: 20,
                                                                    child:
                                                                        Center(
                                                                      child: SvgPicture
                                                                          .asset(
                                                                        ImageResource
                                                                            .phone,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          12),
                                                                  CustomText(
                                                                    Languages.of(
                                                                            context)!
                                                                        .call,
                                                                    color: ColorResource
                                                                        .color23375A,
                                                                    lineHeight:
                                                                        1,
                                                                    fontSize:
                                                                        FontSize
                                                                            .fourteen,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          40),
                                                                ],
                                                              )),
                                                        )),
                                                        const Spacer(),
                                                        const SizedBox(
                                                            width: 5),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            CustomText(
                                                              Languages.of(
                                                                      context)!
                                                                  .view,
                                                              lineHeight: 1,
                                                              fontSize: FontSize
                                                                  .fourteen,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: ColorResource
                                                                  .color23375A,
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            SvgPicture.asset(
                                                              ImageResource
                                                                  .forwardArrow,
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                            ),
                                                            const SizedBox(
                                                                width: 5)
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15)
                                        ],
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
