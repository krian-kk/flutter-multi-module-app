import 'dart:io';

class AudioRemarksPostModel {
  String? langCode;
  String? agrRef;

  AudioRemarksPostModel({this.langCode, this.agrRef});

  factory AudioRemarksPostModel.fromJson(Map<String, dynamic> json) {
    return AudioRemarksPostModel(
      langCode: json['lang_code'] as String?,
      agrRef: json['agrRef'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'lang_code': langCode,
        'agrRef': agrRef,
      };
}
