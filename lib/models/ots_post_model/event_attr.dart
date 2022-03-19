class OTSEventAttr {
  String date;
  String remarkOts;
  String amntOts;
  String appStatus;
  String mode;
  double altitude;
  double accuracy;
  double altitudeAccuracy;
  double heading;
  double speed;
  double latitude;
  double longitude;
  // ignore: non_constant_identifier_names
  late String? reginal_text;
  // ignore: non_constant_identifier_names
  late String? translated_text;
  late String? audioS3Path;

  OTSEventAttr({
    required this.date,
    required this.remarkOts,
    required this.amntOts,
    required this.appStatus,
    required this.mode,
    required this.altitude,
    required this.accuracy,
    this.altitudeAccuracy = 0,
    required this.heading,
    required this.speed,
    required this.latitude,
    required this.longitude,
    // ignore: non_constant_identifier_names
    this.reginal_text,
    // ignore: non_constant_identifier_names
    this.translated_text,
    this.audioS3Path,
  });

  factory OTSEventAttr.fromJson(Map<String, dynamic> json) => OTSEventAttr(
        date: json['date'] as String,
        remarkOts: json['remarkOts'] as String,
        amntOts: json['amntOts'] as String,
        appStatus: json['appStatus'] as String,
        mode: json['mode'] as String,
        altitude: json['altitude'] as dynamic,
        accuracy: json['accuracy'] as double,
        altitudeAccuracy: json['altitudeAccuracy'] as dynamic,
        heading: json['heading'] as dynamic,
        speed: json['speed'] as dynamic,
        latitude: (json['Latitude'] as num).toDouble(),
        longitude: (json['Longitude'] as num).toDouble(),
        reginal_text: json['reginal_text'],
        translated_text: json['translated_text'],
        audioS3Path: json['audioS3Path'],
      );

  Map<String, dynamic> toJson() =>
      reginal_text != null && translated_text != null && audioS3Path != null
          ? {
              'date': date,
              'remarkOts': remarkOts,
              'amntOts': amntOts,
              'appStatus': appStatus,
              'mode': mode,
              'altitude': altitude,
              'accuracy': accuracy,
              'altitudeAccuracy': altitudeAccuracy,
              'heading': heading,
              'speed': speed,
              'Latitude': latitude,
              'Longitude': longitude,
              'audioS3Path': audioS3Path,
              'translated_text': translated_text,
              'reginal_text': reginal_text,
            }
          : {
              'date': date,
              'remarkOts': remarkOts,
              'amntOts': amntOts,
              'appStatus': appStatus,
              'mode': mode,
              'altitude': altitude,
              'accuracy': accuracy,
              'altitudeAccuracy': altitudeAccuracy,
              'heading': heading,
              'speed': speed,
              'Latitude': latitude,
              'Longitude': longitude,
            };
}
