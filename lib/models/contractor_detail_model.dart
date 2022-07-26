class ContractorDetailsModel {
  ContractorDetailsModel({this.status, this.message, this.result});

  ContractorDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null
        ? ContractorResult.fromJson(json['result'])
        : null;
  }
  int? status;
  String? message;
  ContractorResult? result;

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
  String? sId;
  List<FeedbackTemplate>? feedbackTemplate;

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
  FeedbackTemplate(
      {this.name,
      this.type,
      this.hide,
      this.expanded,
      this.label,
      this.reportColumnMerged,
      this.data,
      this.dropDownValue});

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
  String? name;
  String? type;
  bool? hide;
  bool? expanded;
  String? label;
  bool? reportColumnMerged;
  List<Data>? data;
  String? dropDownValue;

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
  String? name;
  String? type;
  bool? hide;
  bool? value;
  String? label;
  bool? required;
  bool? disabled;
  List<Options>? options;

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
  Options({this.value, this.viewValue});

  Options.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    viewValue = json['viewValue'];
  }
  String? value;
  String? viewValue;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['viewValue'] = viewValue;
    return data;
  }
}
