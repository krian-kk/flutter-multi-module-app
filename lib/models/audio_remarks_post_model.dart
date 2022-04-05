class AudioRemarksPostModel {
  AudioRemarksPostModel({this.langCode, this.agrRef});

  factory AudioRemarksPostModel.fromJson(Map<String, dynamic> json) {
    return AudioRemarksPostModel(
      langCode: json['lang_code'] as String?,
      agrRef: json['agrRef'] as String?,
    );
  }

  String? langCode;
  String? agrRef;

  Map<String, dynamic> toJson() => {
        'lang_code': langCode,
        'agrRef': agrRef,
      };
}
