class ChatHistoryModel {
  ChatHistoryModel(
      {
      // this.status, this.message,
      this.result});

  ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    // status = json['status'];
    // message = json['message'];
    if (json['data'] != null) {
      result = <ChatResult>[];
      json['data'].forEach((v) {
        result!.add(ChatResult.fromJson(v));
      });
    }
  }
  // int? status;
  // String? message;
  List<ChatResult>? result;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['status'] = status;
    // data['message'] = message;
    if (result != null) {
      data['data'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatResult {
  ChatResult(
      {this.sId,
      this.messageId,
      this.dateSent,
      this.fromId,
      this.message,
      this.toId,
      this.type,
      this.dateSeen});

  ChatResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    messageId = json['messageId'];
    dateSent = json['dateSent'];
    fromId = json['fromId'];
    message = json['message'];
    toId = json['toId'];
    type = json['type'];
    dateSeen = json['dateSeen'];
  }
  String? sId;
  String? messageId;
  String? dateSent;
  String? fromId;
  String? message;
  String? toId;
  dynamic type;
  String? dateSeen;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['messageId'] = messageId;
    data['dateSent'] = dateSent;
    data['fromId'] = fromId;
    data['message'] = message;
    data['toId'] = toId;
    data['type'] = type;
    data['dateSeen'] = dateSeen;
    return data;
  }
}





// class ChatHistoryModel {
//   ChatHistoryModel({this.status, this.message, this.result});

//   ChatHistoryModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['result'] != null) {
//       result = <ChatResult>[];
//       json['result'].forEach((v) {
//         result!.add(ChatResult.fromJson(v));
//       });
//     }
//   }
//   int? status;
//   String? message;
//   List<ChatResult>? result;

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (result != null) {
//       data['result'] = result!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ChatResult {
//   ChatResult(
//       {this.sId,
//       this.messageId,
//       this.dateSent,
//       this.fromId,
//       this.message,
//       this.toId});

//   ChatResult.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     messageId = json['messageId'];
//     dateSent = json['dateSent'];
//     fromId = json['fromId'];
//     message = json['message'];
//     toId = json['toId'];
//   }
//   String? sId;
//   String? messageId;
//   String? dateSent;
//   String? fromId;
//   String? message;
//   String? toId;

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['messageId'] = messageId;
//     data['dateSent'] = dateSent;
//     data['fromId'] = fromId;
//     data['message'] = message;
//     data['toId'] = toId;
//     return data;
//   }
// }
