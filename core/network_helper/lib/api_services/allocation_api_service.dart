// import 'package:network_helper/dio/dio_client.dart';
// import 'package:network_helper/network_base_models/api_result.dart';
//
// class AllocationApiProvider {
//   Future<ApiResult<ProfileResponse>> getInitialProfileData(
//       String accessToken) async {
//     dynamic response;
//
//     try {
//       response = await DioClient(baseUrl, accessToken: accessToken)
//           .get(profileUrl, decryptResponse: true);
//
//       final mappedResponse =
//       ListResponse.fromJson(response, ProfileResponse.fromJson);
//
//       return ApiResult.success(data: mappedResponse.result?[0]);
//     } catch (e) {
//       return ApiResult.failure(error: NetworkExceptions.getDioException(e));
//     }
//   }
// }