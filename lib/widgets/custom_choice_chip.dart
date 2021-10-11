// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';

class ChoiceChipData {
  final String label;
  final bool isSelected;
  Color textColor;
  Color selectedColor;

  ChoiceChipData({
    required this.label,
    required this.isSelected,
    required this.textColor,
    required this.selectedColor,
  });
}

List<ChoiceChipData> choiceChipData = [
  ChoiceChipData(
      label: 'Left message',
      isSelected: false,
      textColor: ColorResource.color000000,
      selectedColor: ColorResource.color000000),
  ChoiceChipData(
      label: 'Left message',
      isSelected: false,
      textColor: ColorResource.color000000,
      selectedColor: ColorResource.color000000),
  ChoiceChipData(
      label: 'Left message',
      isSelected: false,
      textColor: ColorResource.color000000,
      selectedColor: ColorResource.color000000),
];

class CustomChoiceChip extends StatefulWidget {
  final String labelText;
  final bool selected;
  final Color labelColor;
  final FontWeight fontWeight;
  CustomChoiceChip(
    this.labelText,
    this.selected, {
    Key? key,
    this.labelColor = ColorResource.color000000,
    this.fontWeight = FontWeight.w700,
  }) : super(key: key);

  @override
  State<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
  @override
  Widget build(BuildContext context) => Wrap(
        runSpacing: 10,
        spacing: 10,
        children: choiceChipData
            .map((choiceChip) => ChoiceChip(
                  label: Text(choiceChip.label),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  // onSelected: (isSelected) => setState(() {
                  //   choiceChipData = choiceChip.map((otherChip) {
                  //     final newChip = otherChip.copy(isSelected: false);

                  //     return choiceChip == newChip
                  //         ? newChip.copy(isSelected: isSelected)
                  //         : newChip;
                  //   }).toList();
                  // }),
                  selected: choiceChip.isSelected,
                  selectedColor: Colors.green,
                  backgroundColor: Colors.blue,
                ))
            .toList(),
      );
  // {
  //   return Wrap(
  //     spacing: 10,
  //     children: [

  //       // ListView.builder(
  //       //     physics: NeverScrollableScrollPhysics(),
  //       //     shrinkWrap: true,
  //       //     itemCount: 10,
  //       //     itemBuilder: (BuildContext context, int index) {
  //       //       return
  //       //           // Container(
  //       //           //     height: 40,
  //       //           //     decoration: BoxDecoration(
  //       //           //         color: ColorResource.colorF8F9FB,
  //       //           //         borderRadius: BorderRadius.all(Radius.circular(5.0))),
  //       //           //     child: Padding(
  //       //           //       padding: const EdgeInsets.symmetric(
  //       //           //           horizontal: 20.0, vertical: 5),
  //       //           //       child: CustomText(
  //       //           //         widget.labelText.toUpperCase(),
  //       //           //         color: ColorResource.color000000,
  //       //           //         fontSize: FontSize.fourteen,
  //       //           //         fontStyle: FontStyle.normal,
  //       //           //         fontWeight: FontWeight.w700,
  //       //           //         lineHeight: 1.7,
  //       //           //       ),
  //       //           //     )
  //       //           ChoiceChip(
  //       //         label: CustomText(widget.labelText,
  //       //             color: widget.labelColor,
  //       //             fontWeight: widget.fontWeight,
  //       //             fontSize: FontSize.fourteen,
  //       //             fontStyle: FontStyle.normal),
  //       //         labelPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
  //       //         selected: widget.selected,
  //       //         shape: RoundedRectangleBorder(
  //       //             borderRadius: BorderRadius.all(Radius.circular(5))),
  //       //         selectedColor: ColorResource.colorFFB800.withOpacity(0.67),
  //       //         disabledColor: ColorResource.colorE7E7E7,
  //       //       );
  //       //     }),
  //     ],
  //   );
  // }

}
