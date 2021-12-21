import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/custom_text.dart';

class PhoneConnectedScreen extends StatefulWidget {
  const PhoneConnectedScreen({
    Key? key,
    required this.bloc,
    required this.context,
  }) : super(key: key);

  final CaseDetailsBloc bloc;
  final BuildContext context;

  @override
  State<PhoneConnectedScreen> createState() => _PhoneConnectedScreenState();
}

class _PhoneConnectedScreenState extends State<PhoneConnectedScreen> {
  String selectedOptionBottomSheetButton = '';
  @override
  Widget build(BuildContext context) {
    List<OptionBottomSheetButtonModel> optionBottomSheetButtonList = [
      OptionBottomSheetButtonModel(
          Languages.of(context)!.addNewContact, Constants.addNewContact),
      OptionBottomSheetButtonModel(
          Languages.of(context)!.otherFeedBack, Constants.otherFeedback),
    ];
    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (context, state) {},
      child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
        bloc: widget.bloc,
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 20, 14, 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount:
                              widget.bloc.phoneCustomerMetGridList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int innerIndex) {
                            return Padding(
                              padding: const EdgeInsets.all(4.5),
                              child: GestureDetector(
                                onTap: widget.bloc
                                    .phoneCustomerMetGridList[innerIndex].onTap,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorResource.colorF8F9FB,
                                      boxShadow: [
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(widget
                                          .bloc
                                          .phoneCustomerMetGridList[innerIndex]
                                          .icon),
                                      const SizedBox(height: 8),
                                      CustomText(
                                        widget
                                            .bloc
                                            .phoneCustomerMetGridList[
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
                        Wrap(
                          spacing: 15,
                          runSpacing: 8,
                          children: _buildOptionBottomSheetOpenButton(
                            optionBottomSheetButtonList,
                            context,
                          ),
                        ),
                        const SizedBox(height: 100)
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

  List<Widget> _buildOptionBottomSheetOpenButton(
      List<OptionBottomSheetButtonModel> list, BuildContext context) {
    List<Widget> widgets = [];
    for (var element in list) {
      widgets.add(InkWell(
        onTap: () {
          setState(() {
            selectedOptionBottomSheetButton = element.title;
          });
          widget.bloc.add(ClickOpenBottomSheetEvent(element.stringResourceValue,
              widget.bloc.caseDetailsAPIValue.result?.callDetails));
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
              color: element.title == selectedOptionBottomSheetButton
                  ? ColorResource.color23375A
                  : ColorResource.colorFFFFFF,
              border: Border.all(color: ColorResource.color23375A, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(50.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            child: CustomText(
              element.title.toString().toUpperCase(),
              color: element.title == selectedOptionBottomSheetButton
                  ? ColorResource.colorFFFFFF
                  : ColorResource.color23375A,
              fontWeight: FontWeight.w700,
              fontSize: FontSize.thirteen,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ));
    }
    return widgets;
  }
}
