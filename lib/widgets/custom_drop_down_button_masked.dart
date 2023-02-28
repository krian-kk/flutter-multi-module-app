import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/listener/item_selected_listener.dart';
import 'package:origa/models/contractor_information_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class MaskedCustomDropDownButton extends StatefulWidget {
  MaskedCustomDropDownButton(this.labelText, this.listOfItems,
      {Key? key,
      this.hintWidget,
      this.icon,
      this.underline,
      this.isExpanded = true,
      this.style,
      this.valueTextStyle,
      this.focusNode,
      this.underlineColor = ColorResource.colorE5EAF6,
      this.autoFocus = false,
      this.onChanged,
      this.focusColor,
      this.menuMaxHeight,
      this.selectedValue,
      this.maskNumber,
      this.numbers})
      : super(key: key);

  // final String value;
  final String labelText;
  final List<String> listOfItems;
  final String? selectedValue;
  final Widget? hintWidget;
  final Widget? icon;
  final Widget? underline;
  final bool isExpanded;
  final TextStyle? style;
  final TextStyle? valueTextStyle;
  final Color? focusColor;
  final Color? underlineColor;
  final FocusNode? focusNode;
  final bool autoFocus;
  final OnChange? onChanged;
  final double? menuMaxHeight;
  bool? maskNumber = false;
  Map<int, String>? numbers = <int, String>{};

  @override
  State<MaskedCustomDropDownButton> createState() =>
      _MaskedCustomDropDownButtonState();
}

class _MaskedCustomDropDownButtonState
    extends State<MaskedCustomDropDownButton> {
  @override
  void initState() {
    super.initState();
    if (widget.maskNumber == true) {
      for (var index = 0; index < widget.listOfItems.length; index++) {
        widget.listOfItems[index].replaceRange(2, 7, 'XXXXX');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedItem = widget.selectedValue ?? widget.listOfItems[0];
    if (widget.maskNumber == true) {
      selectedItem.replaceRange(2, 7, 'XXXXX');
    }
    debugPrint(selectedItem);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        widget.labelText != ''
            ? CustomText(
                widget.labelText,
                color: ColorResource.color666666,
                fontSize: FontSize.twelve,
              )
            : const SizedBox(),
        MediaQuery.removePadding(
          removeBottom: true,
          // removeTop: true,
          context: context,
          child: SizedBox(
            // height: 35,
            child: DropdownButton<String>(
              value: selectedItem,
              icon: Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 3),
                child: widget.icon ??
                    SvgPicture.asset(
                      ImageResource.downArrow,
                      width: 10,
                      height: 16,
                    ),
              ),
              // iconSize: 24,
              isExpanded: widget.isExpanded,
              style: widget.style ??
                  TextStyle(
                      color: (widget.selectedValue == 'select')
                          ? ColorResource.color666666
                          : ColorResource.color333333,
                      fontWeight: FontWeight.w700,
                      height: 0.5,
                      fontSize: FontSize.fourteen,
                      fontStyle: FontStyle.normal),
              underline: Container(
                height: 1,
                color: widget.underlineColor,
              ),
              menuMaxHeight: widget.menuMaxHeight,
              focusNode: widget.focusNode,
              // onChanged: (newValue) {
              //   setState(() {
              //     selectedValue = newValue;
              //   });
              // },
              onTap: () => FocusScope.of(context).unfocus(),
              onChanged: widget.onChanged,
              autofocus: widget.autoFocus,
              focusColor: widget.focusColor,
              hint: widget.hintWidget,
              items: widget.listOfItems
                  .map<DropdownMenuItem<String>>((String value) {
                if (widget.maskNumber == true) {
                  value = value.replaceRange(2, 7, 'XXXXX');
                }
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: widget.valueTextStyle ??
                        const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
