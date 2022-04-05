import 'dart:math' as math;
import 'dart:typed_data';

const _m = 0x5bd1e995;
const _r = 24;

class ObjectIdWidget {
  ObjectIdWidget() {
    _initialize(
      DateTime.now().millisecondsSinceEpoch,
      _processUnique,
      _getCounter(),
    );
  }
  ObjectIdWidget.fromBytes(List<int> bytes) {
    ArgumentError.checkNotNull(bytes, 'bytes');
    if (bytes.length != byteLength) {
      throw ArgumentError.value(
        bytes,
        'bytes',
        'Bytes array should has length equal to $byteLength',
      );
    }

    for (var i = 0; i < byteLength; i++) {
      _bytes[i] = bytes[i];
    }
  }
  ObjectIdWidget.fromValues(
    int millisecondsSinceEpoch,
    int processUnique,
    int counter,
  ) {
    ArgumentError.checkNotNull(millisecondsSinceEpoch, 'timestamp');
    ArgumentError.checkNotNull(processUnique, 'processUnique');
    ArgumentError.checkNotNull(counter, 'counter');

    _initialize(millisecondsSinceEpoch, processUnique, counter);
  }

  ObjectIdWidget.fromTimestamp(DateTime timestamp) {
    ArgumentError.checkNotNull(timestamp, 'timestamp');

    final secondsSinceEpoch = timestamp.millisecondsSinceEpoch ~/ 1000;

    _bytes[3] = secondsSinceEpoch & 0xff;
    _bytes[2] = (secondsSinceEpoch >> 8) & 0xff;
    _bytes[1] = (secondsSinceEpoch >> 16) & 0xff;
    _bytes[0] = (secondsSinceEpoch >> 24) & 0xff;
  }

  ObjectIdWidget.fromHexString(String hexString) {
    ArgumentError.checkNotNull(hexString, 'hexString');
    if (hexString.length != hexStringLength) {
      throw ArgumentError.value(
          hexString, 'hexString', 'Provided hexString has wrong length.');
    }

    final secondsSinceEpoch = int.parse(hexString.substring(0, 8), radix: 16);
    final millisecondsSinceEpoch = secondsSinceEpoch * 1000;

    final processUnique = int.parse(hexString.substring(8, 18), radix: 16);
    final counter = int.parse(hexString.substring(18, 24), radix: 16);

    _hexString = hexString;

    _initialize(millisecondsSinceEpoch, processUnique, counter);
  }
  static const _maxCounterValue = 0xffffff;
  static const _counterMask = _maxCounterValue + 1;

  static const byteLength = 12;

  static const hexStringLength = byteLength * 2;

  static final int _processUnique = ProcessUnique().getValue();

  static int _counter = math.Random().nextInt(_counterMask);

  static int _getCounter() => (_counter = (_counter + 1) % _counterMask);

  final Uint8List _bytes = Uint8List(byteLength);

  Uint8List get bytes => _bytes;

  void _initialize(int millisecondsSinceEpoch, int processUnique, int counter) {
    final secondsSinceEpoch = millisecondsSinceEpoch ~/ 1000;

    _bytes[3] = secondsSinceEpoch & 0xff;
    _bytes[2] = (secondsSinceEpoch >> 8) & 0xff;
    _bytes[1] = (secondsSinceEpoch >> 16) & 0xff;
    _bytes[0] = (secondsSinceEpoch >> 24) & 0xff;

    _bytes[8] = processUnique & 0xff;
    _bytes[7] = (processUnique >> 8) & 0xff;
    _bytes[6] = (processUnique >> 16) & 0xff;
    _bytes[5] = (processUnique >> 24) & 0xff;
    _bytes[4] = (processUnique >> 32) & 0xff;

    _bytes[11] = counter & 0xff;
    _bytes[10] = (counter >> 8) & 0xff;
    _bytes[9] = (counter >> 16) & 0xff;
  }

  DateTime? _timestamp;

  DateTime get timestamp {
    if (_timestamp != null) {
      return _timestamp!;
    }

    var secondsSinceEpoch = 0;
    for (var x = 3, y = 0; x >= 0; x--, y++) {
      secondsSinceEpoch += _bytes[x] * math.pow(256, y).toInt();
    }

    return _timestamp = DateTime.fromMillisecondsSinceEpoch(
      secondsSinceEpoch * 1000,
    );
  }

  String? _hexString;

  String get hexString {
    if (_hexString == null) {
      final _buffer = StringBuffer();
      for (var i = 0; i < _bytes.length; i++) {
        _buffer.write(_bytes[i].toRadixString(16).padLeft(2, '0'));
      }
      _hexString = _buffer.toString();
    }

    return _hexString!;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    for (var i = 0; i < _bytes.length; i++) {
      if ((other as ObjectIdWidget)._bytes[i] != _bytes[i]) {
        return false;
      }
    }
    return true;
  }

  static bool isValid(String hexString) {
    try {
      if (hexString.length != 24) {
        return false;
      }

      int.parse(hexString.substring(0, 8), radix: 16);
      int.parse(hexString.substring(8, 18), radix: 16);
      int.parse(hexString.substring(18, 24), radix: 16);
    } on FormatException {
      return false;
    }
    return true;
  }

  int? _hashCode;
  @override
  int get hashCode => _hashCode ??= murmurHash2(bytes, runtimeType.hashCode);

  @override
  String toString() => hexString;
}

int murmurHash2(Uint8List data, [int seed = 0]) {
  var len = data.length;
  var h = seed ^ len;

  var pointer = 0;
  while (len >= 4) {
    var k = data[pointer + 3] +
        data[pointer + 2] * 16 +
        data[pointer + 1] * 256 +
        data[pointer] * 4096;

    k *= _m;
    k ^= k >> _r;
    k *= _m;

    h *= _m;
    h ^= k;

    pointer += 4;
    len -= 4;
  }

  assert(
    len == 0,
    'This algorithm does not support data with len where: 12 % 4 == 0',
  );

  h ^= h >> 13;
  h *= _m;
  h ^= h >> 15;

  return h;
}

abstract class ProcessUnique {
  factory ProcessUnique() => getProcessUnique();
  int getValue();
}

class FallbackProcessUnique implements ProcessUnique {
  @override
  int getValue() {
    var value = 0;

    math.Random random;
    try {
      random = math.Random.secure();
    } on UnsupportedError {
      random = math.Random();
    }

    for (var i = 0; i < 10; i++) {
      value += random.nextInt(256) * math.pow(16, i).toInt();
    }

    return value;
  }
}

ProcessUnique getProcessUnique() => FallbackProcessUnique();
