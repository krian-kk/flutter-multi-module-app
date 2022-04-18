import 'dart:convert';

class JwtDecoderWidget {
  static Map<String, dynamic> decode(String token) {
    final List<String> splitToken = token.split('.');
    if (splitToken.length != 3) {
      throw const FormatException('Invalid token');
    }
    try {
      final String payloadBase64 = splitToken[1];

      final String normalizedPayload = base64.normalize(payloadBase64);

      final String payloadString =
          utf8.decode(base64.decode(normalizedPayload));

      final dynamic decodedPayload = jsonDecode(payloadString);

      return decodedPayload;
    } catch (error) {
      throw const FormatException('Invalid payload');
    }
  }

  static Map<String, dynamic>? tryDecode(String token) {
    try {
      return decode(token);
    } catch (error) {
      return null;
    }
  }

  static bool isExpired(String token) {
    final DateTime expirationDate = getExpirationDate(token);

    return DateTime.now().isAfter(expirationDate);
  }

  static DateTime getExpirationDate(String token) {
    final Map<String, dynamic> decodedToken = decode(token);

    final DateTime expirationDate = DateTime.fromMillisecondsSinceEpoch(0)
        .add(Duration(seconds: decodedToken['exp'].toInt()));
    return expirationDate;
  }

  static Duration getTokenTime(String token) {
    final Map<String, dynamic> decodedToken = decode(token);

    final DateTime issuedAtDate = DateTime.fromMillisecondsSinceEpoch(0)
        .add(Duration(seconds: decodedToken['iat']));
    return DateTime.now().difference(issuedAtDate);
  }

  static Duration getRemainingTime(String token) {
    final DateTime expirationDate = getExpirationDate(token);

    return expirationDate.difference(DateTime.now());
  }
}
