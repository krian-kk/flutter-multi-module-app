import 'package:preference_helper/preference_constants.dart';
import 'package:preference_helper/preference_helper.dart';

abstract class AllocationRepository {
  Future<void> putCurrentLocation(double lat, double long);

  Future<List<String>> allocationInitialData();
}

class AllocationRepositoryImpl extends AllocationRepository {
  @override
  Future<void> putCurrentLocation(double lat, double long) async {
    ///do api call
    // await APIRepository.apiRequest(
    //     APIRequestType.put,
    //     HttpUrl.updateDeviceLocation +
    //         'lat=${result.latitude}&lng=${result.longitude}');
  }

  @override
  Future<List<String>> allocationInitialData() async {
    List<String> initialData = [];

    await PreferenceHelper.getString(keyPair: PreferenceConstants.userType)
        .then((value) {
      initialData.add(value.toString());
    });
    await PreferenceHelper.getString(keyPair: PreferenceConstants.agentName)
        .then((value) {
      initialData.add(value.toString());
    });
    await PreferenceHelper.getString(keyPair: PreferenceConstants.agentRef)
        .then((value) {
      String agrRef = value.toString();
    });
    return initialData;
  }
}
