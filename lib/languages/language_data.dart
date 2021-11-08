class LanguageData {
  final String flag;
  final String name;
  final String languageCode;

  LanguageData(this.flag, this.name, this.languageCode);

  static List<LanguageData> languageList() {
    return <LanguageData>[
      LanguageData("🇺🇸", "English", 'en'),
      LanguageData("🇺🇸", "தமிழ்", 'ta'),
      /* LanguageData("🇸🇦", "اَلْعَرَبِيَّةُ‎", "ar"),
      LanguageData("🇮🇳", "हिंदी", 'hi'),*/
      LanguageData("🇸🇦", "اَلْعَرَبِيَّةُ‎", "ar"),
      LanguageData("🇮🇳", "हिंदी", 'hi'),
    ];
  }
}
