import 'package:preference_helper/preference_constants.dart';
import 'package:preference_helper/preference_helper.dart';

Future<String> getAccessToken() async {
  return await PreferenceHelper.getString(
          keyPair: PreferenceConstants.accessToken) ??
      '';
}
