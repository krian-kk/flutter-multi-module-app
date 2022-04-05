import 'package:flutter/material.dart';
import 'package:origa/listener/item_selected_listener.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/custom_text.dart';

class SelectPaymentModeButtonWidget {
  static List<Widget> buildOptionBottomSheetOpenButton(
    List<OptionBottomSheetButtonModel> list,
    BuildContext context,
    OnClickForPaymentMode function,
    String selectValue,
  ) {
    final List<Widget> widgets = [];
    for (var element in list) {
      widgets.add(InkWell(
        onTap: () {
          function(element);
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
              color: element.title == selectValue
                  ? ColorResource.color23375A
                  : ColorResource.colorFFFFFF,
              border: Border.all(color: ColorResource.color23375A, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(50.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            child: CustomText(
              element.title.toString().toUpperCase(),
              color: element.title == selectValue
                  ? ColorResource.colorFFFFFF
                  : ColorResource.color23375A,
              fontWeight: FontWeight.w700,
              fontSize: FontSize.thirteen,
              lineHeight: 1.35,
            ),
          ),
        ),
      ));
    }
    return widgets;
  }
}
