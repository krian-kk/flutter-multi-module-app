class ContractorDetailsModel {
  int? status;
  String? message;
  ContractorResult? result;

  ContractorDetailsModel({this.status, this.message, this.result});

  ContractorDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null
        ? ContractorResult.fromJson(json['result'])
        : null;
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

class ContractorResult {
  String? sId;
  List<FeedbackTemplate>? feedbackTemplate;

  ContractorResult({this.sId, this.feedbackTemplate});

  ContractorResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['feedbackTemplate'] != null) {
      feedbackTemplate = [];
      json['feedbackTemplate'].forEach((v) {
        feedbackTemplate!.add(FeedbackTemplate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (feedbackTemplate != null) {
      data['feedbackTemplate'] =
          feedbackTemplate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeedbackTemplate {
  String? name;
  String? type;
  bool? hide;
  bool? expanded;
  String? label;
  bool? reportColumnMerged;
  List<Data>? data;

  FeedbackTemplate(
      {this.name,
      this.type,
      this.hide,
      this.expanded,
      this.label,
      this.reportColumnMerged,
      this.data});

  FeedbackTemplate.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    hide = json['hide'];
    expanded = json['expanded'];
    label = json['label'];
    reportColumnMerged = json['reportColumnMerged'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['hide'] = hide;
    data['expanded'] = expanded;
    data['label'] = label;
    data['reportColumnMerged'] = reportColumnMerged;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? type;
  bool? hide;
  bool? value;
  String? label;
  bool? required;
  bool? disabled;
  List<Options>? options;

  Data(
      {this.name,
      this.type,
      this.hide,
      this.value,
      this.label,
      this.required,
      this.disabled,
      this.options});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    hide = json['hide'];
    value = json['value'];
    label = json['label'];
    required = json['required'];
    disabled = json['disabled'];
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['hide'] = hide;
    data['value'] = value;
    data['label'] = label;
    data['required'] = required;
    data['disabled'] = disabled;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String? value;
  String? viewValue;

  Options({this.value, this.viewValue});

  Options.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    viewValue = json['viewValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['viewValue'] = viewValue;
    return data;
  }
}
