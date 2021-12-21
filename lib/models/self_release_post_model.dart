class SelfReleasePostModel {
  late String caseId;
  late Repo repo;

  SelfReleasePostModel({
    required this.caseId,
    required this.repo,
  });

  SelfReleasePostModel.fromJson(Map<String, dynamic> json) {
    caseId = json['caseId'];
    repo = json['repo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caseId'] = caseId;
    data['repo'] = repo;
    return data;
  }
}

class Repo {
  late String date;
  late String time;
  late String remarks;
  late List<String> imageLocation;
  String? status;

  Repo({
    required this.date,
    required this.time,
    required this.remarks,
    required this.imageLocation,
    this.status = 'self release',
  });

  Repo.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    remarks = json['remarks'];
    imageLocation = json['imageLocation'].cast<String>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['time'] = time;
    data['remarks'] = remarks;
    data['imageLocation'] = imageLocation;
    data['status'] = status;
    return data;
  }
}
