import 'package:flutter/material.dart';

class AddNewContactFieldModel {
  TextEditingController controller;
  String formValue;
  FocusNode focusNode;
  AddNewContactFieldModel(this.controller, this.formValue, this.focusNode);
}
