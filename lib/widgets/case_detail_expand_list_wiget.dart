// import 'package:flutter/material.dart';
// import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
// import 'package:origa/widgets/custom_text.dart';

// import '../languages/app_languages.dart';
// import '../screen/profile_screen.dart/bloc/profile_bloc.dart';
// import '../utils/color_resource.dart';
// import '../utils/font.dart';
// import 'custom_read_only_text_field.dart';

// class ListOfCaseDetails {
//   static Widget listOfDetails(
//     BuildContext context, {
//     required String title,
//     required ProfileBloc bloc,
//     bool isLoanDetails = false,
//     bool isAttributeDetails = false,
//     bool isCustomerDetails = false,
//     bool isCustomerContactDetails = false,
//     bool isAllocationDetails = false,
//     bool isRepaymentDetails = false,
//     // bool isAllocationDetails = false,
//   }) {
//     return ListTileTheme(
//       shape: RoundedRectangleBorder(
//           side: const BorderSide(color: ColorResource.colorA7A7A7),
//           borderRadius: BorderRadius.circular(40.0)),
//       tileColor: ColorResource.colorF7F8FA,
//       selectedTileColor: ColorResource.colorE5E5E5,
//       selectedColor: ColorResource.colorE5E5E5,
//       child: Theme(
//         data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//         child: ExpansionTile(
//           onExpansionChanged: (val) {},
//           tilePadding: const EdgeInsetsDirectional.only(start: 20, end: 20),
//           expandedCrossAxisAlignment: CrossAxisAlignment.start,
//           expandedAlignment: Alignment.centerLeft,
//           title: CustomText(
//             title,
//             fontSize: FontSize.eighteen,
//             fontWeight: FontWeight.w700,
//             lineHeight: 1,
//           ),
//           iconColor: ColorResource.color000000,
//           collapsedIconColor: ColorResource.color000000,
//           children: [
//             const SizedBox(
//               height: 15,
//             ),
//             extraTextField(
//                 title: Languages.of(context)!.riskRanking,
//                 controller: bloc.riskRankingController),
//           ],
//         ),
//       ),
//     );
//   }

//   static Widget extraTextField(
//       {required String title, required TextEditingController controller}) {
//     return controller.text != '-'
//         ? Padding(
//             padding: const EdgeInsets.only(top: 16),
//             child: CustomReadOnlyTextField(
//               title,
//               controller,
//               isLabel: true,
//               isEnable: false,
//             ),
//           )
//         : const SizedBox();
//   }
// }
