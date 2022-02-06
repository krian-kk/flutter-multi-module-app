// import 'package:flutter/material.dart';
// import 'package:origa/languages/app_languages.dart';
// import 'package:origa/utils/color_resource.dart';
// import 'package:origa/utils/selectable.dart';

// import 'custom_text.dart';

// class SingleSelectionBottomSheet extends StatefulWidget {
//   List<Selectable> selectableList = [];
//   List<Selectable> filterList = [];
//   Function onDismiss;
//   Function onSelect;

//   SingleSelectionBottomSheet(this.selectableList, this.onDismiss, this.onSelect,
//       {Key? key})
//       : super(key: key);

//   @override
//   _SingleSelectionBottomSheetState createState() =>
//       _SingleSelectionBottomSheetState();
// }

// class _SingleSelectionBottomSheetState
//     extends State<SingleSelectionBottomSheet> {
//   TextEditingController controller = TextEditingController();
//   FocusNode focusNode = FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         widget.onDismiss();
//       },
//       child: Container(
//         color: Colors.grey.withOpacity(0.5),
//         child: DraggableScrollableSheet(
//           initialChildSize: 0.8,
//           minChildSize: 0.8,
//           maxChildSize: 0.8,
//           builder: (BuildContext context, ScrollController scrollController) {
//             return Column(
//               children: [
//                 Container(
//                   color: Colors.grey,
//                   child: TextField(
//                     textCapitalization: TextCapitalization.sentences,
//                     controller: controller,
//                     focusNode: focusNode,
//                     autocorrect: false,
//                     enableSuggestions: false,
//                     onChanged: onSearchTextChanged,
//                     onSubmitted: (val) {},
//                     style: const TextStyle(
//                       color: Colors.white,
//                     ),
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         prefixIcon:
//                             const Icon(Icons.search, color: Colors.white),
//                         suffixIcon: Container(
//                           padding: const EdgeInsets.all(8.0),
//                           child: GestureDetector(
//                               onTap: () {
//                                 focusNode.unfocus();
//                                 focusNode.canRequestFocus = false;
//                                 widget.onDismiss();
//                                 // focusNode.canRequestFocus = true;
//                               },
//                               child:
//                                   const Icon(Icons.close, color: Colors.white)),
//                         ),
//                         hintText: Languages.of(context)!.search,
//                         hintStyle: const TextStyle(color: Colors.white)),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                       color: Colors.white,
//                       child: controller.text.trim().isNotEmpty
//                           ? ListView.builder(
//                               itemCount: widget.filterList.length,
//                               itemBuilder: (context, i) {
//                                 return Column(
//                                   children: [
//                                     ListTile(
//                                       title: CustomText(
//                                           widget.filterList[i].displayName),
//                                       trailing: widget.filterList[i].isSelected
//                                           ? const Icon(
//                                               Icons.check,
//                                               color: ColorResource.color0066cc,
//                                             )
//                                           : null,
//                                       onTap: () {
//                                         widget.onSelect(widget.filterList[i]);
//                                       },
//                                     ),
//                                     _buildCustomDivider()
//                                   ],
//                                 );
//                               },
//                             )
//                           : ListView.builder(
//                               itemCount: widget.selectableList.length,
//                               itemBuilder: (context, index) {
//                                 return Column(
//                                   children: [
//                                     ListTile(
//                                       title: CustomText(widget
//                                           .selectableList[index].displayName),
//                                       trailing: widget
//                                               .selectableList[index].isSelected
//                                           ? const Icon(
//                                               Icons.check,
//                                               color: ColorResource.color0066cc,
//                                             )
//                                           : null,
//                                       onTap: () {
//                                         widget.onSelect(
//                                             widget.selectableList[index]);
//                                       },
//                                     ),
//                                     _buildCustomDivider()
//                                   ],
//                                 );
//                               },
//                             )),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildCustomDivider() {
//     return Container(
//       width: double.infinity,
//       height: 1,
//       color: ColorResource.colorebeff1,
//     );
//   }

//   onSearchTextChanged(String text) async {
//     widget.filterList.clear();
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }

//     widget.filterList = widget.selectableList
//         .where((b) => b.displayName.toLowerCase().contains(text.toLowerCase()))
//         .toList();

//     setState(() {});
//   }
// }
