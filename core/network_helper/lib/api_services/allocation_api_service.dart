import 'package:domain_models/request_body/allocation/are_you_at_office_model.dart';
import 'package:domain_models/response_models/allocation/communication_channel_model.dart';
import 'package:domain_models/response_models/allocation/contractor_all_information_model.dart';
import 'package:domain_models/response_models/allocation/contractor_details_model.dart';
import 'package:network_helper/dio/dio_client.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';

class AllocationApiProvider {
  static const String areYouAtOfficeUrl =
      '${mobileBackendUrl}profile/officeCheckIn';

  static const String updateDeviceLocation =
      '${mobileBackendUrl}profile/updateDeviceLocation?';

  static String contractorDetail =
      '${mobileBackendUrl}case-details-events/contractorDetails';
  static String communicationChannel =
      '${mobileBackendUrl}case-details-events/communicationChannels';

  // Future<ApiResult<ProfileResponse>> getInitialProfileData(
  //     String accessToken) async {
  //   dynamic response;
  //
  //   try {
  //     response = await DioClient(baseUrl, accessToken: accessToken)
  //         .get(profileUrl, decryptResponse: true);
  //
  //     final mappedResponse =
  //     ListResponse.fromJson(response, ProfileResponse.fromJson);
  //
  //     return ApiResult.success(data: mappedResponse.result?[0]);
  //   } catch (e) {
  //     return ApiResult.failure(error: NetworkExceptions.getDioException(e));
  //   }
  // }

  Future<ApiResult<BaseResponse>> postCurrentLocation(
      AreYouAtOfficeModel requestBodyData, String accessToken) async {
    dynamic response;
    try {
      response = await DioClient(baseUrl, accessToken: accessToken).post(
        areYouAtOfficeUrl,
        data: requestBodyData,
      );

      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);

      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<BaseResponse>> putCurrentLocation(
      String accessToken, double lat, double long) async {
    dynamic response;
    try {
      response = await DioClient(baseUrl, accessToken: accessToken).put(
        "${updateDeviceLocation}lat=$lat&lng=$long",
      );

      final mappedResponse =
          SingleResponse.fromJson(response, BaseResponse.fromJson);

      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<ContractorResult>> getContractorDetailsFromApi(
      String accessToken) async {
    dynamic response;

    try {
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get(contractorDetail, decryptResponse: true);

      final mappedResponse =
          SingleResponse.fromJson(response, ContractorResult.fromJson);

      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<ContractorDetailsModel>>
      getCustomContractorDetailsDataFromApi(String accessToken) async {
    dynamic response;

    try {
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get(contractorDetail, decryptResponse: true);

      final mappedResponse =
          SingleResponse.fromJson(response, ContractorDetailsModel.fromJson);

      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<CommunicationChannelModel>> getCommunicationChannelsFromApi(
      String accessToken) async {
    dynamic response;

    try {
      response = await DioClient(baseUrl, accessToken: accessToken)
          .get(communicationChannel);

      final mappedResponse =
          SingleResponse.fromJson(response, CommunicationChannelModel.fromJson);

      return ApiResult.success(data: mappedResponse.result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
