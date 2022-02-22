import 'package:intl/intl.dart';
import 'package:origa/utils/constants.dart';

class CurrencyFormate {
  // A number format for "long" compact representations, e.g. "1.2 million" instead of of "1,200,000".
  String getLocaleCurrencyFormate(String? amount) {
    return NumberFormat.compactLong(
      locale:
          'en_IN', // if you want to add currency locale then pass like ie ta_IN (tamil), hi_IN (hindi).
    ).format(amount);
  }

// A number format for compact currency representations, e.g. "$1.2M" instead of "$1,200,000".
  String getCurrencyFormate(String? amount) {
    return NumberFormat.compactCurrency(
      decimalDigits: 3,
      symbol: Constants
          .inr, // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(amount);
  }

  // Note: visit more currency formates.
  // https://api.flutter.dev/flutter/intl/NumberFormat/NumberFormat.compactLong.html
}
