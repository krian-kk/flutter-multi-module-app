import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/location_converter.dart';
import 'package:origa/models/update_health_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/map_utils.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/health_status_widget.dart';

class AddressDetailsBottomSheetScreen extends StatefulWidget {
  const AddressDetailsBottomSheetScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final CaseDetailsBloc bloc;

  @override
  State<AddressDetailsBottomSheetScreen> createState() =>
      _AddressDetailsBottomSheetScreenState();
}

class _AddressDetailsBottomSheetScreenState
    extends State<AddressDetailsBottomSheetScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is AddedNewAddressListState) {
          widget.bloc.listOfAddressDetails;
        }

        if (state is UpdateHealthStatusState) {
          UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
              Map<String, dynamic>.from(Singleton.instance.updateHealthStatus));

          setState(() {
            switch (data.tabIndex) {
              case 0:
                widget.bloc.caseDetailsAPIValue.result
                        ?.addressDetails![data.selectedHealthIndex!]['health'] =
                    '2';
                break;
              case 1:
                widget.bloc.caseDetailsAPIValue.result
                        ?.addressDetails![data.selectedHealthIndex!]['health'] =
                    '1';
                break;
              case 2:
                widget.bloc.caseDetailsAPIValue.result
                        ?.addressDetails![data.selectedHealthIndex!]['health'] =
                    '0';
                break;
              default:
                widget.bloc.caseDetailsAPIValue.result
                        ?.addressDetails![data.selectedHealthIndex!]['health'] =
                    data.currentHealth;
                break;
            }
          });
        }
      },
      child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
        bloc: widget.bloc,
        builder: (context, state) {
          widget.bloc.listOfAddressDetails;
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.89,
            child: Column(
              children: [
                BottomSheetAppbar(
                  title: Languages.of(context)!.addressDetails.toUpperCase(),
                  padding: const EdgeInsets.fromLTRB(21, 13, 21, 12),
                  color: ColorResource.color23375A,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(21, 0, 21, 12),
                  child: CustomLoanUserDetails(
                    userName: widget.bloc.caseDetailsAPIValue.result
                            ?.caseDetails?.cust ??
                        '',
                    userId: widget.bloc.caseDetailsAPIValue.result?.caseDetails
                            ?.accNo ??
                        '',
                    userAmount: widget
                            .bloc.caseDetailsAPIValue.result?.caseDetails?.due
                            ?.toDouble() ??
                        0,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 21, vertical: 13)
                          .copyWith(top: 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                widget.bloc.listOfAddressDetails?.length ?? 0,
                            itemBuilder: (context, i) {
                              return widget.bloc.listOfAddressDetails?[i]
                                              ['cType'] ==
                                          "residence address" ||
                                      widget.bloc.listOfAddressDetails?[i]
                                              ['cType'] ==
                                          "office address"
                                  ? SizedBox(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomText(
                                            widget
                                                    .bloc
                                                    .listOfAddressDetails?[i]
                                                        ['cType']
                                                    .toString()
                                                    .toUpperCase() ??
                                                '_',
                                            fontWeight: FontWeight.w700,
                                            fontSize: FontSize.fourteen,
                                            color: ColorResource.color23375A,
                                            fontStyle: FontStyle.normal,
                                          ),
                                          const SizedBox(height: 7),
                                          GestureDetector(
                                            onTap: () {
                                              widget.bloc.add(
                                                  ClickMainAddressBottomSheetEvent(
                                                      i));
                                              Singleton.instance
                                                  .resAddressId_0 = widget
                                                          .bloc
                                                          .caseDetailsAPIValue
                                                          .result
                                                          ?.addressDetails![i]
                                                      ['resAddressId_0'] ??
                                                  "";

                                              for (var element in widget
                                                  .bloc
                                                  .caseDetailsAPIValue
                                                  .result!
                                                  .callDetails!) {
                                                if (element['cType'] ==
                                                    "mobile") {
                                                  Singleton.instance
                                                          .customerContactNo =
                                                      element['value'];
                                                  break;
                                                }
                                              }
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
                                                      children: [
                                                        Flexible(
                                                          child: CustomText(
                                                            widget
                                                                    .bloc
                                                                    .listOfAddressDetails?[
                                                                        i][
                                                                        'value']
                                                                    .toString()
                                                                    .toUpperCase() ??
                                                                '_',
                                                            fontSize: FontSize
                                                                .fourteen,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color: ColorResource
                                                                .color484848,
                                                          ),
                                                        ),
                                                        Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                    width: 10),
                                                                ShowHealthStatus
                                                                    .healthStatus(
                                                                        widget.bloc.listOfAddressDetails?[i]['health'] ??
                                                                            ''),
                                                              ],
                                                            )),
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
                                                        GestureDetector(
                                                          onTap: () async {
                                                            Position?
                                                                currentLocation;
                                                            await MapUtils
                                                                    .getCurrentLocation()
                                                                .then((value) {
                                                              setState(() {
                                                                currentLocation =
                                                                    value;
                                                              });
                                                            });
                                                            Northeast?
                                                                destinationLocation =
                                                                await MapUtils.convertAddressToLarlng(
                                                                    address: widget
                                                                        .bloc
                                                                        .caseDetailsAPIValue
                                                                        .result!
                                                                        .addressDetails![i]['value']);
                                                            if (destinationLocation !=
                                                                null) {
                                                              MapUtils.openMap(
                                                                  startLatitude:
                                                                      currentLocation!
                                                                          .latitude,
                                                                  startLongitude:
                                                                      currentLocation!
                                                                          .longitude,
                                                                  destinationLatitude:
                                                                      destinationLocation
                                                                              .lat ??
                                                                          0.0,
                                                                  destinationLongitude:
                                                                      destinationLocation
                                                                              .lng ??
                                                                          0.0);
                                                            }
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
                                                                            .direction,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  CustomText(
                                                                    Languages.of(
                                                                            context)!
                                                                        .viewMap,
                                                                    fontSize:
                                                                        FontSize
                                                                            .fourteen,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: ColorResource
                                                                        .color23375A,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 17,
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                        const Spacer(),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
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
                                                              color: ColorResource
                                                                  .color23375A,
                                                              fontSize: FontSize
                                                                  .fourteen,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
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
