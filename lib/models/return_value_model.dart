class RetrunValueModel {
  late bool isSubmit;
  late String caseId;
  RetrunValueModel(this.isSubmit, this.caseId);
  RetrunValueModel.fromJson(Map<String, dynamic> json) {
    isSubmit = json['isSubmit'];
    caseId = json['caseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSubmit'] = isSubmit;
    data['caseId'] = caseId;

    return data;
  }
}
