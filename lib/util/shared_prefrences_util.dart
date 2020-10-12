import 'package:shared_preferences/shared_preferences.dart';

class PresistantStorageUtil {
  PresistantStorageUtil._();
  static SharedPreferences _perfs;

  static Future<bool> setBool(String key, bool value) =>
      _perfs?.setBool(key, value);
  static bool getBool(String key) => _perfs?.getBool(key);

  static getInstance() async {
    _perfs = await SharedPreferences.getInstance();
    return _perfs;
  }
}

class PresistantKey {
  static String get isOnbaordSeen => "onboard seen";
}
