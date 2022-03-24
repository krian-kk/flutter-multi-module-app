import 'package:flutter/gestures.dart';
import 'package:origa/models/payment_mode_button_model.dart';

typedef OnItemSelected = void Function(dynamic selectedItem);
typedef OnChange = void Function(String?);
typedef OnChangeBoolFuction = void Function(
    String?, bool?, GestureTapCallback?);
typedef OnChangeForPickDate = void Function(String?, String?);
typedef OnClickForPaymentMode = void Function(
    OptionBottomSheetButtonModel element);
