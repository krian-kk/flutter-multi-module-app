class UpdateStaredCase {
  UpdateStaredCase({this.caseId, this.starredCase});

  UpdateStaredCase.fromJson(Map<String, dynamic> json) {
    caseId = json['caseId'];
    starredCase = json['starredCase'];
  }
  String? caseId;
  bool? starredCase;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caseId'] = caseId;
    data['starredCase'] = starredCase;
    return data;
  }
}
