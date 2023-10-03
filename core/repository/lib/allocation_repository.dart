import 'package:domain_models/request_body/allocation/are_you_at_office_model.dart';
import 'package:network_helper/api_services/allocation_api_service.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:preference_helper/preference_constants.dart';
import 'package:preference_helper/preference_helper.dart';

abstract class AllocationRepository {
  Future<void> putCurrentLocation(double lat, double long);

  Future<ApiResult<BaseResponse>> areYouAtOffice(
      AreYouAtOfficeModel requestBodyData);

  Future<List<String>> allocationInitialData();
}

class AllocationRepositoryImpl extends AllocationRepository {
  AllocationApiProvider apiProvider = AllocationApiProvider();

  Future<String> getAccessToken() async {
    return await PreferenceHelper.getString(
            keyPair: PreferenceConstants.accessToken) ??
        '';
  }

  @override
  Future<ApiResult<BaseResponse>> areYouAtOffice(
      AreYouAtOfficeModel requestBodyData) async {
    String? accessToken = await getAccessToken();
    final ApiResult<BaseResponse> response =
        await apiProvider.postCurrentLocation(requestBodyData, accessToken);
    return response;
  }

  @override
  Future<void> putCurrentLocation(double lat, double long) async {

    String? accessToken = await getAccessToken();
    final ApiResult<BaseResponse> response =
    await apiProvider.putCurrentLocation(double lat, double long);
    return response;

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
