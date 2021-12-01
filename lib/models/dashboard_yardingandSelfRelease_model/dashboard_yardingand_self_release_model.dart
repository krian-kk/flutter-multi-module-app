class DashboardYardingandSelfReleaseModel {
  int? status;
  String? message;
  List<dynamic>? result;

  DashboardYardingandSelfReleaseModel({
    this.status,
    this.message,
    this.result,
  });

  factory DashboardYardingandSelfReleaseModel.fromJson(
      Map<String, dynamic> json) {
    return DashboardYardingandSelfReleaseModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}
