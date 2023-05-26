import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/models/agent_information_model.dart';
import 'package:origa/models/chat_history.dart';
import 'package:origa/screen/message_screen/chat_model/message_model.dart';
import 'package:origa/screen/message_screen/chat_screen_event.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';

import '../../models/profile_api_result_model/profile_api_result_model.dart';
import '../../singleton.dart';
import 'chat_screen_state.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  ChatScreenBloc() : super(ChatScreenInitial());

  AgentInformation agentDetails = AgentInformation();
  ChatHistoryModel chatHistoryData = ChatHistoryModel();
  List<ChatHistory> messageHistory = [];
  List<dynamic> unSeenMesg = [];

  String? toId;

  ProfileApiModel profileAPIValue = ProfileApiModel();

  @override
  Stream<ChatScreenState> mapEventToState(ChatScreenEvent event) async* {
    if (event is ChatInitialEvent) {
      yield ChatScreenInitial();

      // final date = DateTime.now();
      // final String currentDate = DateFormat('yyyy-MM-dd').format(date);
      // final String fromDate = DateFormat('yyyy-MM-dd')
      //     .format(DateTime(date.year - 1, date.month, date.day - 3));

      if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
        AppUtils.showErrorToast('No internet connection');
      } else {
        // Get toAref from profile detail API
        if (event.toAref == null) {
          debugPrint('get toAref data from profile api ');
          final Map<String, dynamic> getProfileData =
              await APIRepository.apiRequest(
                  APIRequestType.get, HttpUrl.profileUrl, encrypt: true);

          if (getProfileData['success']) {
            final Map<String, dynamic> jsonData = getProfileData['data'];
            profileAPIValue = ProfileApiModel.fromJson(jsonData);
            toId = profileAPIValue.result![0].parent;
          } else if (getProfileData['statusCode'] == 401 ||
              getProfileData['data'] == Constants.connectionTimeout ||
              getProfileData['statusCode'] == 502) {
            AppUtils.showErrorToast(getProfileData['data'].toString());
          }
        }

        final Map<String, dynamic> agentInformation =
            await APIRepository.apiRequest(
                APIRequestType.get,
                HttpUrl.agentInformation +
                    'aRef=${event.toAref ?? profileAPIValue.result![0].parent}', encrypt: true);

        if (agentInformation[Constants.success]) {
          final Map<String, dynamic> jsonData = agentInformation['data'];
          agentDetails = AgentInformation.fromJson(jsonData);
        } else {}

        // final Map<String, dynamic> chatHistory = await APIRepository.apiRequest(
        //     APIRequestType.get,
        //     HttpUrl.chatHistory + '?fromDate=$fromDate&todate=$currentDate');

        final String? history =
            HttpUrl.chatHistory2 + Singleton.instance.agentRef! + '/';
        final Map<String, dynamic> chatHistory = await APIRepository.apiRequest(
            APIRequestType.get, '$history${event.toAref ?? toId}');

        if (chatHistory[Constants.success]) {
          final Map<String, dynamic> jsonData = chatHistory['data'];
          chatHistoryData = ChatHistoryModel.fromJson(jsonData);

          chatHistoryData.result?.forEach((element) {
            messageHistory.add(ChatHistory(
              data: element.message,
              name: element.toId,
              dateTime: DateTime.parse(element.dateSent!),
            ));
            if (element.dateSeen == null) {
              unSeenMesg.add({
                '_id': element.sId,
                'type': element.type,
                'fromId': element.fromId,
                'toId': element.toId,
                'message': element.message,
                'dateSent': element.dateSent,
                'dateSeen': DateTime.now().toString()
              });
            }
          });
        } else {}

        // debugPrint('check unseen msg ----> $unSeenMesg');
        // When user seen the mseeage that is updated to seened mesg
        if (unSeenMesg.isNotEmpty || unSeenMesg != []) {
          final Map<String, dynamic> postResult =
              await APIRepository.apiRequest(
            APIRequestType.post,
            HttpUrl.updateChatSeen,
            requestBodydata: {'msgs': unSeenMesg},
          );
          // if (postResult[Constants.success]) {}
        }
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

// import 'package:bloc/bloc.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/rendering.dart';
// import 'package:intl/intl.dart';
// import 'package:origa/http/api_repository.dart';
// import 'package:origa/http/httpurls.dart';
// import 'package:origa/models/agent_information_model.dart';
// import 'package:origa/models/chat_history.dart';
// import 'package:origa/screen/message_screen/chat_model/message_model.dart';
// import 'package:origa/screen/message_screen/chat_screen_event.dart';
// import 'package:origa/utils/app_utils.dart';
// import 'package:origa/utils/constants.dart';

// import '../../models/profile_api_result_model/profile_api_result_model.dart';
// import 'chat_screen_state.dart';

// class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
//   ChatScreenBloc() : super(ChatScreenInitial());

//   AgentInformation agentDetails = AgentInformation();
//   ChatHistoryModel chatHistoryData = ChatHistoryModel();
//   List<ChatHistory> messageHistory = [];

//   String? toId;

//   ProfileApiModel profileAPIValue = ProfileApiModel();

//   @override
//   Stream<ChatScreenState> mapEventToState(ChatScreenEvent event) async* {
//     if (event is ChatInitialEvent) {
//       yield ChatScreenInitial();

//       final date = DateTime.now();
//       final String currentDate = DateFormat('yyyy-MM-dd').format(date);
//       final String fromDate = DateFormat('yyyy-MM-dd')
//           .format(DateTime(date.year - 1, date.month, date.day - 3));

//       if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
//       } else {
//         final Map<String, dynamic> chatHistory = await APIRepository.apiRequest(
//             APIRequestType.get,
//             HttpUrl.chatHistory + '?fromDate=$fromDate&todate=$currentDate');

//         if (chatHistory[Constants.success]) {
//           final Map<String, dynamic> jsonData = chatHistory['data'];
//           chatHistoryData = ChatHistoryModel.fromJson(jsonData);

//           chatHistoryData.result?.forEach((element) {
//             messageHistory.add(ChatHistory(
//               data: element.message,
//               name: element.fromId,
//               dateTime: DateTime.parse(element.dateSent!),
//             ));
//           });
//           debugPrint(
//               "Chat History  from instalmint API == > ${chatHistory['data']}");
//         } else {}

//         // Get toAref from profile detail API
//         if (event.toAref == null) {
//           final Map<String, dynamic> getProfileData =
//               await APIRepository.apiRequest(
//                   APIRequestType.get, HttpUrl.profileUrl);

//           if (getProfileData['success']) {
//             final Map<String, dynamic> jsonData = getProfileData['data'];
//             profileAPIValue = ProfileApiModel.fromJson(jsonData);
//             toId = profileAPIValue.result![0].parent;
//           } else if (getProfileData['statusCode'] == 401 ||
//               getProfileData['data'] == Constants.connectionTimeout ||
//               getProfileData['statusCode'] == 502) {
//             AppUtils.showErrorToast(getProfileData['data'].toString());
//           }
//         }

//         final Map<String, dynamic> agentInformation =
//             await APIRepository.apiRequest(
//                 APIRequestType.get,
//                 HttpUrl.agentInformation +
//                     'aRef=${event.toAref ?? profileAPIValue.result![0].parent}');

//         if (agentInformation[Constants.success]) {
//           final Map<String, dynamic> jsonData = agentInformation['data'];
//           agentDetails = AgentInformation.fromJson(jsonData);
//         } else {}
//       }

//       yield ChatScreenLoadedState();
//     }
//   }
// }

// // class DateFormateUtils {
// //   DateFormateUtils._();
// //   static String chatDate(String date) =>
// //       DateFormat('yyyy-MM-dd  HH:mm').format(DateTime.parse(date));
// // }
