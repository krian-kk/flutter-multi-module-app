class YardingPostModel {
  late String caseId;
  late Repo repo;
  late String contractor;

  YardingPostModel({
    required this.caseId,
    required this.repo,
    required this.contractor,
  });

  YardingPostModel.fromJson(Map<String, dynamic> json) {
    caseId = json['caseId'];
    repo = json['repo'];
    contractor = json['contractor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caseId'] = caseId;
    data['repo'] = repo;
    data['contractor'] = contractor;
    return data;
  }
}

class Repo {
  late String yard;
  late String date;
  late String time;
  late String remarks;
  late List<String> imageLocation;
  late String status;

  Repo({
    required this.yard,
    required this.date,
    required this.time,
    required this.remarks,
    required this.imageLocation,
    this.status = 'yarding',
  });

  Repo.fromJson(Map<String, dynamic> json) {
    yard = json['yard'];
    date = json['date'];
    time = json['time'];
    remarks = json['remarks'];
    imageLocation = json['imageLocation'].cast<String>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['yard'] = yard;
    data['date'] = date;
    data['time'] = time;
    data['remarks'] = remarks;
    data['imageLocation'] = imageLocation;
    data['status'] = status;
    return data;
  }
}
