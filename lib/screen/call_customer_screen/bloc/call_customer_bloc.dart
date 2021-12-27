import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/voice_agency_details/voice_agency_details.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';

part 'call_customer_event.dart';
part 'call_customer_state.dart';

class CallCustomerBloc extends Bloc<CallCustomerEvent, CallCustomerState> {
  VoiceAgencyDetailsModel voiceAgencyDetails = VoiceAgencyDetailsModel();
  CallCustomerBloc() : super(CallCustomerInitial()) {
    on<CallCustomerEvent>((event, emit) async {
      if (event is CallCustomerInitialEvent) {
        emit.call(CallCustomerLoadedState());
        if (ConnectivityResult.none ==
            await Connectivity().checkConnectivity()) {
          emit.call(NoInternetState());
        } else {
          Map<String, dynamic> getEventDetailsData =
              await APIRepository.apiRequest(
                  APIRequestType.GET, HttpUrl.voiceAgencyDetailsUrl);

          if (getEventDetailsData[Constants.success]) {
            Map<String, dynamic> jsonData = getEventDetailsData['data'];
            print('---------Voice Agency detail-------');
            print(jsonData['result']['voiceAgencyData']);
            voiceAgencyDetails = VoiceAgencyDetailsModel.fromJson(jsonData);
            emit.call(CallCustomerSuccessState());
          } else {}
        }
        emit.call(CallCustomerLoadingState());
      }
    });
  }
}
