
import 'package:shared_preferences/shared_preferences.dart';
import 'package:funica/constants/export.dart';

class UserSimplePreferences {
  static SharedPreferences? pref;

  static const _languageIndexKey = 'languageKey';
  static const _chooseLanguageFirstTime = 'chooseLanguageFirstTime';
  static Future init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future setLanguageIndex(int index) async {
    await pref!.setInt(_languageIndexKey, index);
  }

  static Future getLanguageIndex() async {
    return await pref!.getInt(_languageIndexKey);
  }

  static Future isFirstLaunch(bool value) async {
    await pref!.setBool(_chooseLanguageFirstTime, value);
  }

  static Future getIsFirstLaunch() async {
    return await pref!.getBool(_chooseLanguageFirstTime);
  }
}
