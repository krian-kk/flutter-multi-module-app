// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:origa/languages/app_languages.dart';
// import 'package:origa/models/payment_mode_button_model.dart';
// import 'package:origa/models/select_clip_model.dart';
// import 'package:origa/screen/telecaller_phone_bottom_sheet_screen/bloc/telecaller_phone_bloc.dart';
// import 'package:origa/singleton.dart';
// import 'package:origa/utils/color_resource.dart';
// import 'package:origa/utils/constants.dart';
// import 'package:origa/utils/font.dart';
// import 'package:origa/utils/image_resource.dart';
// import 'package:origa/utils/pick_date_time_utils.dart';
// import 'package:origa/widgets/custom_read_only_text_field.dart';
// import 'package:origa/widgets/custom_text.dart';

// class TelecallerPhoneUnreachableScreen extends StatefulWidget {
//   const TelecallerPhoneUnreachableScreen({
//     Key? key,
//     required this.context,
//     required this.bloc,
//   }) : super(key: key);

//   final BuildContext context;
//   final TelecallerPhoneBloc bloc;

//   @override
//   State<TelecallerPhoneUnreachableScreen> createState() =>
//       _TelecallerPhoneUnreachableScreenState();
// }

// class _TelecallerPhoneUnreachableScreenState
//     extends State<TelecallerPhoneUnreachableScreen> {
//   String selectedOptionBottomSheetButton = '';

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<SelectedClipModel> selectedClipList = [
//       SelectedClipModel(Languages.of(context)!.lineBusy.toUpperCase()),
//       SelectedClipModel(Languages.of(context)!.switchOff.toUpperCase()),
//       SelectedClipModel(Languages.of(context)!.rnr.toUpperCase()),
//       SelectedClipModel(Languages.of(context)!.outOfNetwork.toUpperCase()),
//       SelectedClipModel(Languages.of(context)!.disConnecting.toUpperCase()),
//     ];
//     List<OptionBottomSheetButtonModel> optionBottomSheetButtonList = [
//       OptionBottomSheetButtonModel(
//           Languages.of(context)!.otherFeedBack, Constants.otherFeedback),
//     ];
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Container(
//         padding:
//             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: Form(
//           key: widget.bloc.phoneUnreachableFormKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Flexible(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Wrap(
//                           runSpacing: 10,
//                           spacing: 10,
//                           children: _buildSelectedClip(selectedClipList),
//                         ),
//                         const SizedBox(height: 25),
//                         CustomText(
//                           Languages.of(context)!.nextActionDate,
//                           color: ColorResource.color666666,
//                           fontSize: FontSize.twelve,
//                           fontWeight: FontWeight.w400,
//                           fontStyle: FontStyle.normal,
//                         ),
//                         SizedBox(
//                           width: (MediaQuery.of(context).size.width - 62) / 2,
//                           child: CustomReadOnlyTextField(
//                             '',
//                             widget
//                                 .bloc.phoneUnreachableNextActionDateController,
//                             focusNode: widget
//                                 .bloc.phoneUnreachableNextActionDateFocusNode,
//                             isReadOnly: true,
//                             validationRules: const ['required'],
//                             onTapped: () => PickDateAndTimeUtils.pickDate(
//                                 context, (newDate, followUpDate) {
//                               if (newDate != null && followUpDate != null) {
//                                 setState(() {
//                                   widget
//                                       .bloc
//                                       .phoneUnreachableNextActionDateController
//                                       .text = newDate;
//                                 });
//                               }
//                             }),
//                             suffixWidget: SvgPicture.asset(
//                               ImageResource.calendar,
//                               fit: BoxFit.scaleDown,
//                             ),
//                             onEditing: () {
//                               widget
//                                   .bloc.phoneUnreachableNextActionDateFocusNode
//                                   .unfocus();
//                               widget.bloc.phoneUnreachableRemarksFocusNode
//                                   .requestFocus();
//                               widget.bloc.phoneInvalidFormKey.currentState!
//                                   .validate();
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 27),
//                         CustomText(
//                           Languages.of(context)!.remarks,
//                           color: ColorResource.color666666,
//                           fontWeight: FontWeight.w400,
//                           fontSize: FontSize.twelve,
//                           fontStyle: FontStyle.normal,
//                         ),
//                         SizedBox(
//                           width: double.infinity,
//                           child: TextFormField(
//                             focusNode:
//                                 widget.bloc.phoneUnreachableRemarksFocusNode,
//                             controller:
//                                 widget.bloc.phoneUnreachableRemarksController,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter some text';
//                               }
//                               return null;
//                             },
//                             decoration: InputDecoration(
//                                 hintText:
//                                     Languages.of(context)!.writeYourRemarksHere,
//                                 focusColor: ColorResource.colorE5EAF6,
//                                 labelStyle:
//                                     const TextStyle(color: Color(0xFF424242))),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Singleton.instance.contractorInformations?.result
//                                     ?.hideCallTriedSmsButton ??
//                                 true
//                             ? const SizedBox()
//                             : GestureDetector(
//                                 // onTap: () {
//                                 //   widget.bloc.add(SendSMSEvent(context,
//                                 //       type: Constants.callTriedType));
//                                 // },
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 15, vertical: 10),
//                                   decoration: BoxDecoration(
//                                     color: ColorResource.color23375A,
//                                     borderRadius: BorderRadius.circular(5),
//                                     border: Border.all(
//                                         color: ColorResource.colorECECEC,
//                                         width: 1.0),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       const Icon(
//                                         Icons.message_rounded,
//                                         color: ColorResource.colorffffff,
//                                         size: 22,
//                                       ),
//                                       // SvgPicture.asset(
//                                       //     ImageResource
//                                       //         .whatsApp),
//                                       const SizedBox(width: 5),
//                                       CustomText(
//                                           Constants.sendSMS.toUpperCase(),
//                                           lineHeight: 1.0,
//                                           color: ColorResource.colorffffff),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                         const SizedBox(height: 19),
//                         Wrap(
//                           spacing: 15,
//                           runSpacing: 8,
//                           children: _buildOptionBottomSheetOpenButton(
//                             optionBottomSheetButtonList,
//                             context,
//                           ),
//                         ),
//                         // const SizedBox(height: 19),
//                         // Wrap(
//                         //   spacing: 15,
//                         //   runSpacing: 8,
//                         //   children: _buildOptionBottomSheetOpenButton(
//                         //     optionBottomSheetButtonList,
//                         //     context,
//                         //   ),
//                         // ),
//                         // const SizedBox(height: 120)
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildOptionBottomSheetOpenButton(
//       List<OptionBottomSheetButtonModel> list, BuildContext context) {
//     List<Widget> widgets = [];
//     for (var element in list) {
//       widgets.add(InkWell(
//         // onTap: () {
//         //   setState(() {
//         //     selectedOptionBottomSheetButton = element.title;
//         //   });
//         //   widget.bloc.add(ClickOpenBottomSheetEvent(
//         //     element.stringResourceValue,
//         //     widget.bloc.caseDetailsAPIValue.result?.callDetails,
//         //     true,
//         //     health: ConstantEventValues.healthOne,
//         //   ));
//         // },
//         child: Container(
//           height: 45,
//           decoration: BoxDecoration(
//               color: element.title == selectedOptionBottomSheetButton
//                   ? ColorResource.color23375A
//                   : ColorResource.colorFFFFFF,
//               border: Border.all(color: ColorResource.color23375A, width: 0.5),
//               borderRadius: const BorderRadius.all(Radius.circular(50.0))),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
//             child: CustomText(
//               element.title.toString().toUpperCase(),
//               color: element.title == selectedOptionBottomSheetButton
//                   ? ColorResource.colorFFFFFF
//                   : ColorResource.color23375A,
//               fontWeight: FontWeight.w700,
//               fontSize: FontSize.thirteen,
//               fontStyle: FontStyle.normal,
//             ),
//           ),
//         ),
//       ));
//     }
//     return widgets;
//   }

//   List<Widget> _buildSelectedClip(List<SelectedClipModel> list) {
//     List<Widget> widgets = [];
//     for (var element in list) {
//       widgets.add(InkWell(
//         onTap: () {
//           widget.bloc.phoneSelectedUnreadableClip = element.clipTitle;
//           setState(() {});
//         },
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: element.clipTitle == widget.bloc.phoneSelectedUnreadableClip
//                 ? ColorResource.colorFFB800.withOpacity(0.67)
//                 : ColorResource.colorE7E7E7,
//           ),
//           child: CustomText(
//             element.clipTitle,
//             color: ColorResource.color000000,
//             fontSize: FontSize.fourteen,
//             fontStyle: FontStyle.normal,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ));
//     }
//     return widgets;
//   }
// }
