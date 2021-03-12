import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  Future<void> init() async {
    if (_sharedPrefs == null)
      _sharedPrefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get instance => _sharedPrefs;

  bool get presentationMode =>
      _sharedPrefs.getBool("presentationMode") ?? false;
  set presentationMode(bool value) =>
      _sharedPrefs.setBool("presentationMode", value);

  bool get useEmotionNn => _sharedPrefs.getBool("useEmotionNn") ?? true;
  set useEmotionNn(bool value) => _sharedPrefs.setBool("useEmotionNn", value);

  String get excludedName => _sharedPrefs.getString("excludedName") ?? "";
  set excludedName(String value) =>
      _sharedPrefs.setString("excludedName", value);
}

final SharedPrefs sharedPrefs = SharedPrefs();
