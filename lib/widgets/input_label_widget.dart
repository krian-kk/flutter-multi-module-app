import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';

class InputLabelWidget extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType inputType;
  final bool isObscure;
  final TextEditingController textEditingController;
  final bool isEnabled;
  final bool isReadOnly;
  final TextCapitalization textCapitalization;
  final int maxLength;
  final List<TextInputFormatter>? inputformaters;
  final String? error;

  const InputLabelWidget(this.label, this.hint, this.textEditingController,
      {Key? key,
      this.inputType = TextInputType.text,
      this.isObscure = false,
      this.isEnabled = true,
      this.isReadOnly = false,
      this.textCapitalization = TextCapitalization.none,
      this.maxLength = 40,
      this.inputformaters,
      this.error})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: isObscure,
      enabled: isEnabled,
      readOnly: isReadOnly,
      maxLength: maxLength,
      keyboardType: inputType,
      textCapitalization: textCapitalization,
      inputFormatters: inputformaters,
      style: TextStyle(
          fontFamily: Font.latoRegular.toString(),
          fontSize: 14,
          color: ColorResource.color232222),
      decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorResource.colorECEBf1),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: label,
          labelStyle: TextStyle(
              fontFamily: Font.latoRegular.toString(),
              fontSize: 14,
              color: ColorResource.color232222),
          hintText: hint,
          errorText: error,
          hintStyle: TextStyle(
              color: ColorResource.colorD1D1D1,
              fontSize: 14,
              fontFamily: Font.latoRegular.toString())),
    );
  }
}
