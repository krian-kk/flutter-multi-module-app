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
  CallCustomerBloc() : super(CallCustomerInitial()) {
    on<CallCustomerEvent>(
        (CallCustomerEvent event, Emitter<CallCustomerState> emit) async {
      if (event is CallCustomerInitialEvent) {
        emit.call(CallCustomerLoadedState());
        if (ConnectivityResult.none ==
            await Connectivity().checkConnectivity()) {
          emit.call(NoInternetState());
        } else {
          final Map<String, dynamic> getAgencyDetailsData =
              await APIRepository.apiRequest(
                  APIRequestType.get, HttpUrl.voiceAgencyDetailsUrl);

          if (getAgencyDetailsData[Constants.success]) {
            final Map<String, dynamic> jsonData = getAgencyDetailsData['data'];
            voiceAgencyDetails = AgencyDetailsModel.fromJson(jsonData);
            if (voiceAgencyDetails.result?.voiceAgencyData?.isNotEmpty ==
                true) {
              serviceProviderListDropdownList.add((voiceAgencyDetails
                      .result?.voiceAgencyData?.first.agencyId) ??
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
              Singleton.instance.invalidNumber = 'false';

              Singleton.instance.callID =
                  voiceAgencyDetails.result?.agentAgencyContact ?? '';
              emit.call(CallCustomerSuccessState());
            } else {}
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
      if (event is NavigationPhoneBottomSheetEvent) {
        emit.call(NavigationPhoneBottomSheetState(event.callId));
      }
    });
  }

  List<String> serviceProviderListDropdownList = <String>[''];
  String serviceProviderListValue = '';
  List<String> callersIDDropdownList = <String>[''];
  String callersIDDropdownValue = '';
  bool isSubmit = true;

  AgencyDetailsModel voiceAgencyDetails = AgencyDetailsModel();
}
