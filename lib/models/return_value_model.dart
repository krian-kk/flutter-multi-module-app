class RetrunValueModel {
  late bool isSubmit;
  late String caseId;
  late bool isSubmitForMyVisit;
  RetrunValueModel(this.isSubmit, this.caseId, this.isSubmitForMyVisit);
  RetrunValueModel.fromJson(Map<String, dynamic> json) {
    isSubmit = json['isSubmit'];
    caseId = json['caseId'];
    isSubmitForMyVisit = json['isSubmitForMyVisit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSubmit'] = isSubmit;
    data['caseId'] = caseId;
    data['isSubmitForMyVisit'] = isSubmitForMyVisit;
    return data;
  }
}
