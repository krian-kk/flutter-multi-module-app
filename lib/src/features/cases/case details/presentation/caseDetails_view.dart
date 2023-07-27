// import 'package:origa/gen/assets.gen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class CaseDetailsView extends StatelessWidget {
//   const CaseDetailsView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: const Text(
//           'Case Details',
//           style: TextStyle(
//             fontSize: 16,
//             color: Color(0xFF101010),
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         leading: SvgPicture.asset(Assets.images.caseBackArrow),
//         // leading: const Icon(
//         //   AllocationIcons.case_backarrow,
//         //   color: Color(0xFF000000),
//         //   size: 16,
//         // ),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => _showModalBottomSheet(context),
//           child: const Text('Case Details'),
//         ),
//       ),
//     );
//   }
// }
//
// void _showModalBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return const CaseDetailsPopup();
//     },
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//       top: Radius.circular(20),
//     )),
//     backgroundColor: Colors.transparent,
//   );
// }
//
// class CaseDetailsPopup extends StatefulWidget {
//   const CaseDetailsPopup({Key? key}) : super(key: key);
//
//   @override
//   State<CaseDetailsPopup> createState() => _CaseDetailsPopupState();
// }
//
// class _CaseDetailsPopupState extends State<CaseDetailsPopup>
//     with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     TabController tabController = TabController(length: 3, vsync: this);
//
//     return DraggableScrollableSheet(
//         initialChildSize: 0.9,
//         builder: (_, controller) {
//           return Container(
//             decoration: const BoxDecoration(
//               color: Color(0xFFFFFFFF),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//             ),
//             padding: const EdgeInsets.all(25),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'PHONE NUMBER 01',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 14,
//                         color: Color(0xFF23375A),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Container(
//                               width: 20,
//                               height: 20,
//                               decoration: const BoxDecoration(
//                                 color: Color(0xFFA0E895),
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(50),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               width: 10,
//                               height: 10,
//                               decoration: const BoxDecoration(
//                                 color: Color(0xFF3BCD25),
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(50),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: InkWell(
//                             onTap: () => Navigator.pop(context),
//                             child: SvgPicture.asset(
//                                 Assets.images.resetPasswordCross),
//                             // child: const Icon(
//                             //   AllocationIcons.resetpassword_cross,
//                             //   color: Color(0xFF23375A),
//                             //   size: 14,
//                             // ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const Text('9841021453',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     )),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 130,
//                       height: 40,
//                       decoration: const BoxDecoration(
//                         color: Color(0xFFBEC4CF),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(20),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 40,
//                             height: 40,
//                             decoration: const BoxDecoration(
//                               color: Color(0xFF23375A),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(50),
//                               ),
//                             ),
//                             child:
//                                 SvgPicture.asset(Assets.images.caseCallPhone),
//                             // child: const Icon(
//                             //   AllocationIcons.case_callphone,
//                             //   color: Color(0xFFFFFFFF),
//                             // ),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.only(left: 20),
//                             child: Text('CALL',
//                                 style: TextStyle(
//                                   color: Color(0xFF23375A),
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 14,
//                                 )),
//                           ),
//                         ],
//                       ),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         side: const BorderSide(
//                           width: 0.5,
//                           color: Color(0xFF23375A),
//                         ),
//                         backgroundColor: const Color(0xFFFFFFFF),
//                       ),
//                       onPressed: () {},
//                       child: const Text(
//                         'EVENT DETAILS',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 12,
//                           color: Color(0xFF23375A),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                     child: TabBar(
//                   labelColor: const Color(0xFF23375A),
//                   indicatorColor: const Color(0xFFD5344C),
//                   labelStyle: const TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 14,
//                   ),
//                   unselectedLabelColor: const Color(0xFFC4C4C4),
//                   controller: tabController,
//                   tabs: const [
//                     Tab(
//                       text: 'Connected',
//                     ),
//                     Tab(text: 'Unreachable'),
//                     Tab(text: 'Invalid'),
//                   ],
//                 )),
//                 SizedBox(
//                     width: double.maxFinite,
//                     height: 300,
//                     child: TabBarView(
//                       controller: tabController,
//                       children: [
//                         CaseDetailsConnectedGrid(),
//                         const Text("Unreachable's stuff here"),
//                         const Text("Invalid's stuff here"),
//                       ],
//                     )),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     CaseDetailsBtn(
//                       btnColor: Color(0xFF23375A),
//                       btnTextColor: Color(0xFFFFFFFF),
//                       btnText: 'ADD NEW CONTACT',
//                     ),
//                     CaseDetailsBtn(
//                       btnColor: Color(0xFFFFFFFF),
//                       btnTextColor: Color(0xFF23375A),
//                       btnText: 'OTHER FEEDBACK',
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 70),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: const Size(191, 50),
//                         backgroundColor: const Color(0xFFEA6D48),
//                       ),
//                       onPressed: () {},
//                       child: const Text(
//                         'DONE',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFFFFFFFF),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           );
//         });
//   }
// }
//
// class CaseDetailsConnectedGrid extends StatelessWidget {
//   CaseDetailsConnectedGrid({Key? key}) : super(key: key);
//
//   final List<Map<String, dynamic>> gridMap = [
//     {"label": "PTP"},
//     {"label": "RTP (DENIAL)"},
//     {"label": "DISPUTE"},
//     {"label": "REMINDER/CB"},
//     {"label": "COLLECTIONS"},
//     {"label": "OTS"},
//   ];
//
//   final List<Assets> icons = [
//     // AllocationIcons.case_ptp,
//     // AllocationIcons.case_rtpdenial,
//     // AllocationIcons.case_dispute,
//     // AllocationIcons.case_remindercb,
//     // AllocationIcons.case_collections,
//     // AllocationIcons.case_collections
//
//     Assets.images.casePTP,
//
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: const EdgeInsets.all(5),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 10,
//       ),
//       itemCount: gridMap.length,
//       itemBuilder: (context, index) {
//         return InkWell(
//           onTap: () {},
//           splashColor: Colors.red,
//           child: Container(
//             decoration: BoxDecoration(
//               color: const Color(0xFFF8F9FB),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Icon(
//                   icons[index],
//                   color: const Color(0xFF23375A),
//                   size: 44,
//                 ),
//                 Text("${gridMap.elementAt(index)['label']}",
//                     style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF000000),
//                     ))
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class CaseDetailsBtn extends StatelessWidget {
//   final Color btnColor;
//   final String btnText;
//   final Color btnTextColor;
//
//   const CaseDetailsBtn({
//     Key? key,
//     required this.btnColor,
//     required this.btnTextColor,
//     required this.btnText,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         side: const BorderSide(
//           width: 0.5,
//           color: Color(0xFF23375A),
//         ),
//         minimumSize: const Size(159, 40),
//         backgroundColor: btnColor,
//         elevation: 0,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(50))),
//       ),
//       onPressed: () {},
//       child: Text(btnText,
//           style: TextStyle(
//             color: btnTextColor,
//             fontWeight: FontWeight.w700,
//             fontSize: 12,
//           )),
//     );
//   }
// }
