import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/event_details_api_model/event_details_api_model.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';

part 'event_details_event.dart';
part 'event_details_state.dart';

class EventDetailsPlayAudioModel {
  bool isPlaying;
  bool isPaused;
  bool loadingAudio;
  EventDetailsPlayAudioModel({
    this.isPlaying = false,
    this.isPaused = false,
    this.loadingAudio = false,
  });
}

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  EventDetailsApiModel eventDetailsAPIValue = EventDetailsApiModel();
  List<EventDetailsPlayAudioModel> eventDetailsPlayAudioModel = [];

  EventDetailsBloc() : super(EventDetailsInitial()) {
    on<EventDetailsEvent>((event, emit) async {
      if (event is EventDetailsInitialEvent) {
        emit.call(EventDetailsLoadingState());
        if (ConnectivityResult.none ==
            await Connectivity().checkConnectivity()) {
          emit.call(NoInternetState());
        } else {
          Map<String, dynamic> getEventDetailsData =
              await APIRepository.apiRequest(
                  APIRequestType.get,
                  HttpUrl.eventDetailsUrl(
                    caseId: event.caseId,
                    userType: event.userType,
                  ));

          if (getEventDetailsData[Constants.success] == true) {
            Map<String, dynamic> jsonData = getEventDetailsData['data'];

            eventDetailsAPIValue = EventDetailsApiModel.fromJson(jsonData);
          } else {
            AppUtils.showToast(getEventDetailsData['data']['message']);
          }
        }
        eventDetailsAPIValue.result?.forEach((element) {
          eventDetailsPlayAudioModel.add(EventDetailsPlayAudioModel());
        });
        emit.call(EventDetailsLoadedState());
      }
    });
  }
}
