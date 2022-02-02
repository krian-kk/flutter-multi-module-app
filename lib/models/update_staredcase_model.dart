class UpdateStaredCase {
  String? caseId;
  bool? starredCase;

  UpdateStaredCase({this.caseId, this.starredCase});

  UpdateStaredCase.fromJson(Map<String, dynamic> json) {
    caseId = json['caseId'];
    starredCase = json['starredCase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caseId'] = caseId;
    data['starredCase'] = starredCase;
    return data;
  }
}
