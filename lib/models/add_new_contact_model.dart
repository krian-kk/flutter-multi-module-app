import 'package:flutter/material.dart';

class AddNewContactFieldModel {
  AddNewContactFieldModel(this.controller, this.formValue, this.focusNode);
  TextEditingController controller;
  String formValue;
  FocusNode focusNode;
}
