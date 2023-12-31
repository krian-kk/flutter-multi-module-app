class Validator {
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static ValidationState validate(String input, {required List<String> rules}) {
    for (int i = 0; i < rules.length; i++) {
      final String rule = rules[i];
      if (rule == 'required') {
        if (input.trim() == '') {
          return ValidationState(error: 'This field is required');
        }
      }

      if (rule == 'email') {
        if (input == '') {
          return ValidationState(error: 'This field is required');
        }
        if (!_emailRegExp.hasMatch(input)) {
          return ValidationState(error: 'Email format is invalid');
        }
      }

      if (rule.startsWith('min:')) {
        try {
          final int? letterCount = int.tryParse(rule.replaceAll('min:', ''));
          if (input.length < letterCount!) {
            return ValidationState(
                error: 'Value should be min $letterCount character long');
          }
        } catch (_) {
          return ValidationState(error: ' - $rule is incorrect');
        }
      }

      if (rule == 'number_only') {
        final RegExp regex = RegExp(r'(\d+)');
        if (!regex.hasMatch(input)) {
          return ValidationState(error: 'Value is not a number');
        }
      }

      if (rule == 'mobile_number') {
        const String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
        final RegExp regExp = RegExp(pattern);
        if (input.isEmpty) {
          return ValidationState(error: 'Please enter mobile number');
        } else if (!regExp.hasMatch(input)) {
          return ValidationState(error: 'Please enter valid  mobile number');
        }
      }
      if (rule == 'password') {
        const String pattern = r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)';
        final RegExp regExp = RegExp(pattern);
        if (input.isEmpty) {
          return ValidationState(error: 'Please enter new password');
        } else if (!regExp.hasMatch(input)) {
          return ValidationState(
              error:
                  'Password must contain a lowercase letter, a capital (uppercase) letter, a Special character a number and  should be minimum 6 characters in length.');
        }
      }
    }

    return ValidationState(status: true);
  }
}

class ValidationState {
  ValidationState({this.status = false, this.error});
  bool status;
  String? error;
}
