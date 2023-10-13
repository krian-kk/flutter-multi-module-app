class LanguageModel {
  LanguageModel(this.language, this.isTitle, this.title, this.languageCode);
  String title;
  String language;
  bool isTitle;
  String languageCode;
}

class CustomerLanguagePreferenceModel {
  CustomerLanguagePreferenceModel({this.language, this.languageCode});
  String? language;
  String? languageCode;
}
