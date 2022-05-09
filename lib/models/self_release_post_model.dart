class SelfReleasePostModel {
  SelfReleasePostModel({
    required this.id,
    required this.repo,
    required this.contractor,
  });

  SelfReleasePostModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    repo = json['repo'];
    contractor = json['contractor'];
  }
  late String id;
  late Repo repo;
  late String contractor;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['repo'] = repo;
    data['contractor'] = contractor;
    return data;
  }
}

class Repo {
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
  late String date;
  late String time;
  late String remarks;
  late List<String> imageLocation;
  String? status;

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
