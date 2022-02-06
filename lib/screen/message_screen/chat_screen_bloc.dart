import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/agent_information_model.dart';
import 'package:origa/screen/message_screen/chat_screen_event.dart';
import 'package:origa/utils/constants.dart';

import 'chat_screen_state.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  ChatScreenBloc() : super(ChatScreenInitial());

  AgentInformation agentDetails = AgentInformation();

  @override
  Stream<ChatScreenState> mapEventToState(ChatScreenEvent event) async* {
    if (event is ChatInitialEvent) {
      yield ChatScreenInitial();

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
      } else {
        Map<String, dynamic> chatHistory = await APIRepository.apiRequest(
            APIRequestType.GET, HttpUrl.chatHistory);

        if (chatHistory[Constants.success]) {
          print(
              "Chat History  from instalmint API == > ${chatHistory['data']}");
        } else {}

        Map<String, dynamic> agentInformation = await APIRepository.apiRequest(
            APIRequestType.GET,
            HttpUrl.agentInformation + 'aRef=${event.toAref}');

        if (agentInformation[Constants.success]) {
          Map<String, dynamic> jsonData = agentInformation['data'];
          agentDetails = AgentInformation.fromJson(jsonData);
          print(agentInformation['data']);
        } else {}
      }

      yield ChatScreenLoadedState();
    }
  }
}
