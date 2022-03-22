class AudioConvertModel {
  int? status;
  String? message;
  Result? result;

  AudioConvertModel({this.status, this.message, this.result});

  AudioConvertModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  String? acceptRanges;
  String? lastModified;
  int? contentLength;
  String? eTag;
  String? contentType;
  // Metadata? metadata;
  Body? body;

  Result(
      {this.acceptRanges,
      this.lastModified,
      this.contentLength,
      this.eTag,
      this.contentType,
      // this.metadata,
      this.body});

  Result.fromJson(Map<String, dynamic> json) {
    acceptRanges = json['AcceptRanges'];
    lastModified = json['LastModified'];
    contentLength = json['ContentLength'];
    eTag = json['ETag'];
    contentType = json['ContentType'];
    // metadata = json['Metadata'] != null ? new Metadata.fromJson(json['Metadata']) : null;
    body = json['Body'] != null ? Body.fromJson(json['Body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AcceptRanges'] = acceptRanges;
    data['LastModified'] = lastModified;
    data['ContentLength'] = contentLength;
    data['ETag'] = eTag;
    data['ContentType'] = contentType;
    // if (metadata != null) {
    //   data['Metadata'] = metadata!.toJson();
    // }
    if (body != null) {
      data['Body'] = body!.toJson();
    }
    return data;
  }
}

class Metadata {
  // Metadata({});

  // Metadata.fromJson(Map<String, dynamic> json) {
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

class Body {
  String? type;
  List<int>? data;

  Body({this.type, this.data});

  Body.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['data'] = data;
    return data;
  }
}
