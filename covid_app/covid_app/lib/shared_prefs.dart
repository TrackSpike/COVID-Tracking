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
}

final SharedPrefs sharedPrefs = SharedPrefs();
