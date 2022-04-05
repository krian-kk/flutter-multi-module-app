class Result {
  Result({
    this.id,
    this.callfrom,
    this.callto,
    this.agent,
    this.startTime,
    this.endTime,
    this.duration,
    this.billsec,
    this.credits,
    this.status,
    this.status2,
    this.recording,
    this.location,
    this.provider,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json['id'] as String?,
        callfrom: json['callfrom'] as String?,
        callto: json['callto'] as String?,
        agent: json['agent'] as String?,
        startTime: json['start_time'] as String?,
        endTime: json['end_time'] as String?,
        duration: json['duration'] as int?,
        billsec: json['billsec'] as String?,
        credits: json['credits'] as String?,
        status: json['status'] as String?,
        status2: json['status2'] as String?,
        recording: json['recording'] as String?,
        location: json['location'] as String?,
        provider: json['provider'] as String?,
      );
  String? id;
  String? callfrom;
  String? callto;
  String? agent;
  String? startTime;
  String? endTime;
  int? duration;
  String? billsec;
  String? credits;
  String? status;
  String? status2;
  String? recording;
  String? location;
  String? provider;

  Map<String, dynamic> toJson() => {
        'id': id,
        'callfrom': callfrom,
        'callto': callto,
        'agent': agent,
        'start_time': startTime,
        'end_time': endTime,
        'duration': duration,
        'billsec': billsec,
        'credits': credits,
        'status': status,
        'status2': status2,
        'recording': recording,
        'location': location,
        'provider': provider,
      };
}
