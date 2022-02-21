class ChatHistoryModel {
  int? status;
  String? message;
  List<ChatResult>? result;

  ChatHistoryModel({this.status, this.message, this.result});

  ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <ChatResult>[];
      json['result'].forEach((v) {
        result!.add(ChatResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatResult {
  String? sId;
  String? messageId;
  String? dateSent;
  String? fromId;
  String? message;
  String? toId;

  ChatResult(
      {this.sId,
      this.messageId,
      this.dateSent,
      this.fromId,
      this.message,
      this.toId});

  ChatResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    messageId = json['messageId'];
    dateSent = json['dateSent'];
    fromId = json['fromId'];
    message = json['message'];
    toId = json['toId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['messageId'] = messageId;
    data['dateSent'] = dateSent;
    data['fromId'] = fromId;
    data['message'] = message;
    data['toId'] = toId;
    return data;
  }
}
