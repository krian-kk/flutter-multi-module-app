import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/agent_information_model.dart';
import 'package:origa/models/chat_history.dart';
import 'package:origa/screen/message_screen/chat_model/message_model.dart';
import 'package:origa/screen/message_screen/chat_screen_event.dart';
import 'package:origa/utils/constants.dart';

import 'chat_screen_state.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  ChatScreenBloc() : super(ChatScreenInitial());

  AgentInformation agentDetails = AgentInformation();
  ChatHistoryModel chatHistoryData = ChatHistoryModel();
  List<ChatHistory> messageHistory = [];

  @override
  Stream<ChatScreenState> mapEventToState(ChatScreenEvent event) async* {
    if (event is ChatInitialEvent) {
      yield ChatScreenInitial();

      var date = DateTime.now();
      String currentDate = DateFormat('yyyy-MM-dd').format(date);
      String fromDate = DateFormat('yyyy-MM-dd')
          .format(DateTime(date.year - 1, date.month, date.day - 3));

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
      } else {
        Map<String, dynamic> chatHistory = await APIRepository.apiRequest(
            APIRequestType.get,
            HttpUrl.chatHistory + '?fromDate=$fromDate&todate=$currentDate');

        if (chatHistory[Constants.success]) {
          Map<String, dynamic> jsonData = chatHistory['data'];
          chatHistoryData = ChatHistoryModel.fromJson(jsonData);

          chatHistoryData.result?.forEach((element) {
            messageHistory.add(ChatHistory(
              data: element.message,
              name: element.fromId,
              dateTime: DateTime.parse(element.dateSent!),
            ));
          });
          print(
              "Chat History  from instalmint API == > ${chatHistory['data']}");
        } else {}

        Map<String, dynamic> agentInformation = await APIRepository.apiRequest(
            APIRequestType.get,
            HttpUrl.agentInformation + 'aRef=${event.toAref}');

        if (agentInformation[Constants.success]) {
          Map<String, dynamic> jsonData = agentInformation['data'];
          agentDetails = AgentInformation.fromJson(jsonData);
        } else {}
      }

      yield ChatScreenLoadedState();
    }
  }
}

// class DateFormateUtils {
//   DateFormateUtils._();
//   static String chatDate(String date) =>
//       DateFormat('yyyy-MM-dd  HH:mm').format(DateTime.parse(date));
// }
