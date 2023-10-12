import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:languages/language_english.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/src/features/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/select_payment_mode_button_widget.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';

import '../../generate_qr_code.dart';

class CustomerMetScreen extends StatefulWidget {
  const CustomerMetScreen({
    Key? key,
    required this.bloc,
    required this.context,
  }) : super(key: key);

  final CaseDetailsBloc bloc;
  final BuildContext context;

  @override
  State<CustomerMetScreen> createState() => _CustomerMetScreenState();
}

class _CustomerMetScreenState extends State<CustomerMetScreen> {
  String selectedOptionBottomSheetButton = '';

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<OptionBottomSheetButtonModel> optionBottomSheetButtonList =
        <OptionBottomSheetButtonModel>[
      // OptionBottomSheetButtonModel(
      //     LanguageEn().addNewContact, Constants.addNewContact),
      OptionBottomSheetButtonModel(LanguageEn().repo, Constants.repo),
      OptionBottomSheetButtonModel(
          LanguageEn().otherFeedBack, Constants.otherFeedback),
    ];
    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (BuildContext context, CaseDetailsState state) {
        if (state is GenerateQRcodeState) {
          widget.bloc.isQRcodeBtnLoading = false;
          qrBottomSheet(state.qrUrl, context);
        }
      },
      child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
        bloc: widget.bloc,
        builder: (BuildContext context, CaseDetailsState state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 20, 14, 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount:
                              widget.bloc.addressCustomerMetGridList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int innerIndex) {
                            return Padding(
                              padding: const EdgeInsets.all(4.5),
                              child: GestureDetector(
                                onTap: widget
                                    .bloc
                                    .addressCustomerMetGridList[innerIndex]
                                    .onTap,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorResource.colorF8F9FB,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: ColorResource.color000000
                                              .withOpacity(0.2),
                                          blurRadius: 2.0,
                                          offset: const Offset(1.0, 1.0),
                                        )
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(widget
                                          .bloc
                                          .addressCustomerMetGridList[
                                              innerIndex]
                                          .icon),
                                      const SizedBox(height: 8),
                                      CustomText(
                                        widget
                                            .bloc
                                            .addressCustomerMetGridList[
                                                innerIndex]
                                            .title,
                                        color: ColorResource.color000000,
                                        fontSize: FontSize.twelve,
                                        fontWeight: FontWeight.w700,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          LanguageEn().captureImage.toUpperCase(),
                          cardShape: 75.0,
                          textColor: ColorResource.color23375A,
                          fontSize: FontSize.sixteen,
                          fontWeight: FontWeight.w700,
                          padding: 15.0,
                          borderColor: ColorResource.colorBEC4CF,
                          buttonBackgroundColor: ColorResource.colorBEC4CF,
                          isLeading: true,
                          onTap: () => widget.bloc.add(
                            EventDetailsEvent(
                                Constants.captureImage,
                                widget.bloc.caseDetailsAPIValue.addressDetails,
                                false,
                                health: ConstantEventValues.healthTwo),
                          ),
                          trailingWidget:
                              SvgPicture.asset(ImageResource.captureImage),
                        ),
                        SizedBox(height: widget.bloc.isShowQRcode ? 16 : 0),
                        widget.bloc.isShowQRcode
                            ? Stack(
                                alignment: AlignmentDirectional.center,
                                children: <Widget>[
                                  CustomButton(
                                    LanguageEn()
                                        .showQRcode
                                        .toUpperCase(),
                                    cardShape: 75.0,
                                    textColor: ColorResource.color23375A,
                                    fontSize: FontSize.sixteen,
                                    fontWeight: FontWeight.w700,
                                    padding: 15.0,
                                    borderColor: ColorResource.colorBEC4CF,
                                    buttonBackgroundColor:
                                        ColorResource.colorBEC4CF,
                                    isLeading: true,
                                    onTap: () async {
                                      if (!widget.bloc.isQRcodeBtnLoading) {
                                        if (ConnectivityResult.none !=
                                            await Connectivity()
                                                .checkConnectivity()) {
                                          widget.bloc.add(GenerateQRcodeEvent(
                                              context,
                                              caseID: widget
                                                  .bloc
                                                  .caseDetailsAPIValue
                                                  .caseDetails!
                                                  .caseId!));
                                          setState(() {
                                            widget.bloc.isQRcodeBtnLoading =
                                                true;
                                          });
                                        } else {
                                          AppUtils.noInternetSnackbar(context);
                                        }
                                      }
                                    },
                                    trailingWidget:
                                        SvgPicture.asset(ImageResource.scan),
                                  ),
                                  widget.bloc.isQRcodeBtnLoading
                                      ? const CustomLoadingWidget(
                                          radius: 15,
                                          strokeWidth: 2.5,
                                        )
                                      : const SizedBox(),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 15,
                          runSpacing: 8,
                          children: SelectPaymentModeButtonWidget
                              .buildOptionBottomSheetOpenButton(
                            optionBottomSheetButtonList,
                            context,
                            (OptionBottomSheetButtonModel element) {
                              setState(() => selectedOptionBottomSheetButton =
                                  element.title);
                              widget.bloc.add(EventDetailsEvent(
                                element.stringResourceValue,
                                widget.bloc.caseDetailsAPIValue.addressDetails,
                                false,
                              ));
                            },
                            selectedOptionBottomSheetButton,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  qrBottomSheet(String? qrLink, BuildContext buildContext) async {
    await showModalBottomSheet(
        context: buildContext,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                GenerateQRcode(
                  bloc: widget.bloc,
                  qrCode: qrLink ?? '',
                )));
  }
}
