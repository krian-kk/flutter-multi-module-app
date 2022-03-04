class RetrunValueModel {
  late bool isSubmit;
  late String caseId;
  late bool isSubmitForMyVisit;
  late String eventType;
  late dynamic returnCaseAmount;
  late dynamic returnCollectionAmount;
  late String selectedClipValue;
  RetrunValueModel(
    this.isSubmit,
    this.caseId,
    this.isSubmitForMyVisit,
    this.eventType,
    this.returnCaseAmount,
    this.returnCollectionAmount,
    this.selectedClipValue,
  );
  RetrunValueModel.fromJson(Map<String, dynamic> json) {
    isSubmit = json['isSubmit'];
    caseId = json['caseId'];
    isSubmitForMyVisit = json['isSubmitForMyVisit'];
    eventType = json['eventType'];
    returnCaseAmount = json['returnCaseAmount'];
    returnCollectionAmount = json['returnCollectionAmount'];
    selectedClipValue = json['selectedClipValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSubmit'] = isSubmit;
    data['caseId'] = caseId;
    data['isSubmitForMyVisit'] = isSubmitForMyVisit;
    data['eventType'] = eventType;
    data['returnCaseAmount'] = returnCaseAmount;
    data['returnCollectionAmount'] = returnCollectionAmount;
    data['selectedClipValue'] = selectedClipValue;
    return data;
  }
}
