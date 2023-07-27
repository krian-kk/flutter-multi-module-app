import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String placeholder;

  const TextFormFieldWidget({
    Key? key,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
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
    );
  }
}
