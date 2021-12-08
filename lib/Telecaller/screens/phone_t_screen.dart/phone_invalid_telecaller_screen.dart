import 'package:flutter/material.dart';
import 'package:origa/Telecaller/screens/phone_t_screen.dart/bloc/phone_telecaller_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class PhonenInvalidTelecallerScreen extends StatefulWidget {
  const PhonenInvalidTelecallerScreen(
      {Key? key, required this.context, required this.bloc})
      : super(key: key);

  final BuildContext context;
  final PhoneTelecallerBloc bloc;

  @override
  State<PhonenInvalidTelecallerScreen> createState() =>
      _PhonenInvalidTelecallerScreenState();
}

class _PhonenInvalidTelecallerScreenState
    extends State<PhonenInvalidTelecallerScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedOptionBottomSheetButton = '';
  @override
  Widget build(BuildContext context) {
    List<SelectedClipModel> selectedClipList = [
      SelectedClipModel(Languages.of(context)!.doesNotExist.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.incorrectNumber.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.numberNotWorking.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.notOperational.toUpperCase()),
    ];
    List<OptionBottomSheetButtonModel> optionBottomSheetButtonList = [
      OptionBottomSheetButtonModel(
          Languages.of(context)!.addNewContact, StringResource.addNewContact),
      OptionBottomSheetButtonModel(
          Languages.of(context)!.otherFeedBack, StringResource.otherFeedback),
    ];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: _buildSelectedClip(selectedClipList),
                      ),
                      const SizedBox(height: 27),
                      CustomText(
                        Languages.of(context)!.remarks,
                        color: ColorResource.color666666,
                        fontWeight: FontWeight.w400,
                        fontSize: FontSize.twelve,
                        fontStyle: FontStyle.normal,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          focusNode: widget.bloc.phoneInvalidRemarksFocusNode,
                          controller: widget.bloc.phoneInvalidRemarksController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText:
                                  Languages.of(context)!.writeYourRemarksHere,
                              focusColor: ColorResource.colorE5EAF6,
                              labelStyle:
                                  const TextStyle(color: Color(0xFF424242))),
                        ),
                      ),
                      // TextField(),
                      const SizedBox(height: 19),
                      Wrap(
                        spacing: 15,
                        runSpacing: 8,
                        children: _buildOptionBottomSheetOpenButton(
                          optionBottomSheetButtonList,
                          context,
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //       child: CustomButton(
                      //         StringResource.addNewContact.toUpperCase(),
                      //         textColor: ColorResource.colorFFFFFF,
                      //         borderColor: ColorResource.color23375A,
                      //         fontSize: FontSize.twelve,
                      //         cardShape: 75,
                      //         buttonBackgroundColor: ColorResource.color23375A,
                      //       ),
                      //     ),
                      //     SizedBox(height: 11),
                      //     Expanded(
                      //       child: CustomButton(
                      //         Languages.of(context)!.otherFeedBack,
                      //         fontSize: FontSize.twelve,
                      //         textColor: ColorResource.color23375A,
                      //         borderColor: ColorResource.color23375A,
                      //         cardShape: 75,
                      //         buttonBackgroundColor: ColorResource.colorFFFFFF,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 120)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
          // openBottomSheet(context, element.stringResourceValue);
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
              // lineHeight: 1,
              fontSize: FontSize.thirteen,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ));
    }
    return widgets;
  }

  // openBottomSheet(BuildContext buildContext, String cardTitle) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     enableDrag: false,
  //     isDismissible: false,
  //     context: buildContext,
  //     backgroundColor: ColorResource.colorFFFFFF,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(20),
  //       ),
  //     ),
  //     builder: (BuildContext context) {
  //       switch (cardTitle) {
  //         case StringResource.otherFeedback:
  //           return CustomOtherFeedBackBottomSheet(
  //               Languages.of(context)!.otherFeedBack, widget.bloc);
  //         case StringResource.addNewContact:
  //           return SizedBox(
  //               height: MediaQuery.of(context).size.height * 0.89,
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   BottomSheetAppbar(
  //                       title:
  //                           Languages.of(context)!.addNewContact.toUpperCase(),
  //                       padding: const EdgeInsets.fromLTRB(23, 16, 15, 5)),
  //                   const Expanded(
  //                       child: Center(child: CircularProgressIndicator())),
  //                 ],
  //               ));
  //         default:
  //           return const Scaffold(
  //             body: Center(
  //               child: CircularProgressIndicator(),
  //             ),
  //           );
  //       }
  //     },
  //   );
  // }

  List<Widget> _buildSelectedClip(List<SelectedClipModel> list) {
    List<Widget> widgets = [];
    for (var element in list) {
      widgets.add(InkWell(
        onTap: () {
          widget.bloc.phoneSelectedInvalidClip = element.clipTitle;
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: element.clipTitle == widget.bloc.phoneSelectedInvalidClip
                ? ColorResource.colorF1BCC4
                : ColorResource.colorE7E7E7,
          ),
          child: CustomText(
            element.clipTitle,
            color: ColorResource.color000000,
            fontSize: FontSize.fourteen,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
        ),
      ));
    }
    return widgets;
  }
}
