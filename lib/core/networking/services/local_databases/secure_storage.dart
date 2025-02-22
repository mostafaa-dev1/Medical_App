import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static final _storage = const FlutterSecureStorage();

  static Future<void> saveValue(
      {required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> readValue({required String key}) async {
    return await _storage.read(key: key);
  }
}
