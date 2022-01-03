class ContractorDetailsModel {
  int? status;
  String? message;
  Result? result;

  ContractorDetailsModel({this.status, this.message, this.result});

  ContractorDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? sId;
  List<FeedbackTemplate>? feedbackTemplate;

  Result({this.sId, this.feedbackTemplate});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['feedbackTemplate'] != null) {
      feedbackTemplate = [];
      json['feedbackTemplate'].forEach((v) {
        feedbackTemplate!.add(new FeedbackTemplate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.feedbackTemplate != null) {
      data['feedbackTemplate'] =
          this.feedbackTemplate!.map((v) => v.toJson()).toList();
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
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['hide'] = this.hide;
    data['expanded'] = this.expanded;
    data['label'] = this.label;
    data['reportColumnMerged'] = this.reportColumnMerged;
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
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['hide'] = this.hide;
    data['value'] = this.value;
    data['label'] = this.label;
    data['required'] = this.required;
    data['disabled'] = this.disabled;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['viewValue'] = this.viewValue;
    return data;
  }
}
