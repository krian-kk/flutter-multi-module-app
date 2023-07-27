import 'package:flutter/material.dart';

class TextFormFieldValidateWidget extends StatelessWidget {
  final String placeholder;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool isPassword;

  const TextFormFieldValidateWidget({
    Key? key,
    required this.placeholder,
    required this.onChanged,
    required this.isPassword,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword ? true : false,
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
        hintText: placeholder,
        hintStyle: const TextStyle(
          color: Color(0xFFCbcbd0),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        filled: true,
        fillColor: const Color(0xFFFFFFFF),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xFFC5C8CE),
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        // border: OutlineInputBorder(borderRadius: BorderRadius.zero)),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
