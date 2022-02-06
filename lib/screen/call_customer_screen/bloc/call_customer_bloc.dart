import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/voice_agency_detail_model/voice_agency_detail_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';

part 'call_customer_event.dart';
part 'call_customer_state.dart';

class CallCustomerBloc extends Bloc<CallCustomerEvent, CallCustomerState> {
  List<String> serviceProviderListDropdownList = [''];
  String serviceProviderListValue = '';
  List<String> callersIDDropdownList = [''];
  String callersIDDropdownValue = '';
  bool isSubmit = true;

  AgencyDetailsModel voiceAgencyDetails = AgencyDetailsModel();
  CallCustomerBloc() : super(CallCustomerInitial()) {
    on<CallCustomerEvent>((event, emit) async {
      if (event is CallCustomerInitialEvent) {
        emit.call(CallCustomerLoadedState());
        if (ConnectivityResult.none ==
            await Connectivity().checkConnectivity()) {
          emit.call(NoInternetState());
        } else {
          Map<String, dynamic> getAgencyDetailsData =
              await APIRepository.apiRequest(
                  APIRequestType.GET, HttpUrl.voiceAgencyDetailsUrl);
          // Map<String, dynamic> getEventDetailsData1 =
          //     await APIRepository.apiRequest(APIRequestType.POST,
          //         'https://devapi.instalmint.com/v1/chat/tokenRequest',
          //         requestBodydata: {});
          // print('Ably Get Values => ${getEventDetailsData1}');

          if (getAgencyDetailsData[Constants.success]) {
            Map<String, dynamic> jsonData = getAgencyDetailsData['data'];
            voiceAgencyDetails = AgencyDetailsModel.fromJson(jsonData);
            serviceProviderListDropdownList.add(
                (voiceAgencyDetails.result?.voiceAgencyData?.first.agencyId) ??
                    '');
            serviceProviderListValue =
                voiceAgencyDetails.result?.voiceAgencyData?.first.agencyId ??
                    '';
            if (voiceAgencyDetails
                .result!.voiceAgencyData!.first.callerIds!.isNotEmpty) {
              callersIDDropdownList = voiceAgencyDetails
                  .result!.voiceAgencyData!.first.callerIds!
                  .cast<String>();

              callersIDDropdownValue = voiceAgencyDetails
                  .result!.voiceAgencyData!.first.callerIds!.first;
              Singleton.instance.callingID = voiceAgencyDetails
                  .result!.voiceAgencyData!.first.callerIds!.first;
            } else {
              Singleton.instance.callingID = null;
            }

            Singleton.instance.callerServiceID =
                voiceAgencyDetails.result?.voiceAgencyData?.first.agencyId ??
                    '';

            Singleton.instance.callID =
                voiceAgencyDetails.result?.agentAgencyContact ?? '';
            emit.call(CallCustomerSuccessState());
          } else {}
        }
        emit.call(CallCustomerLoadingState());
      }
      if (event is DisableSubmitEvent) {
        isSubmit = false;
      }
      if (event is EnableSubmitEvent) {
        isSubmit = true;
      }
    });
  }
}
