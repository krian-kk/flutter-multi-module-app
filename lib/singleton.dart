class Singleton {
  String? accessToken;
  String? refreshToken;
  String? sessionID;
  String? agentRef;
  static final Singleton instance = Singleton.internal();

  factory Singleton() {
    return instance;
  }

  Singleton.internal();
}
