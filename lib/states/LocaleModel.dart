import 'package:flutter/material.dart';
import '../common/ProfileChangeNotifier.dart';

class LocaleModel extends ProfileChangeNotifier {
  // 获取当前用户App语言配置Locale类，如果为null，则语言跟随系统语言
  Locale? getLocale() {
    Locale? locale;
    String? tempLocale = profile.locale;
    if (tempLocale != null) {
      List<String> list = tempLocale.split("_");
      String languageCode = list[0];
      String countryCode = list[1];
      if (list.length > 2) {
        String scriptCode = list[1];
        countryCode = list[2];
        locale = Locale.fromSubtags(
            languageCode: languageCode,
            scriptCode: scriptCode,
            countryCode: countryCode);
      }else{
        locale = Locale.fromSubtags(
            languageCode: languageCode, countryCode: countryCode);
      }
    }
    return locale;
  }

  // 获取当前Locale的字符串表示
  String get locale => profile.locale!;

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  set locale(String localeStr) {
    if (localeStr != profile.locale) {
      profile.locale = localeStr;
      notifyListeners();
    }
  }
}
