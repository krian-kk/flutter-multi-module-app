class LanguageModel {
  String title;
  String language;
  bool isTitle;
  String languageCode;
  LanguageModel(this.language, this.isTitle, this.title, this.languageCode);
}

class CustomerLanguagePreferenceModel {
  String? language;
  String? languageCode;
  CustomerLanguagePreferenceModel({this.language, this.languageCode});
}
