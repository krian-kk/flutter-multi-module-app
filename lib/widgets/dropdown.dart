import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/selectable.dart';
import 'package:origa/utils/string_resource.dart';

import 'custom_text.dart';

class DropDown extends StatefulWidget {
  List<Selectable> selectionList = [];
  Selectable selectedItem;
  Function onchanged;

  DropDown(this.selectionList, this.selectedItem, this.onchanged);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Selectable>(
        isExpanded: true,
        style: TextStyle(
            fontFamily: Font.latoRegular.toString(),
            color: ColorResource.colorbfbfbf,
            fontSize: 16),
        hint: CustomText(
          'select',
          fontSize: 16,
          color: ColorResource.colorbfbfbf,
        ),
        items: widget.selectionList.map((Selectable selection) {
          return DropdownMenuItem<Selectable>(
            value: selection,
            child: Text(
              selection.displayName,
              style: const TextStyle(
                  fontSize: 16, color: ColorResource.color000000),
            ),
          );
        }).toList(),
        onChanged: (item) {
          widget.selectedItem = item!;
          widget.onchanged(item);
        },
        value: widget.selectedItem);
  }
}
