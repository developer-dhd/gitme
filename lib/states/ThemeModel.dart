import 'package:flutter/material.dart';
import '../common/Global.dart';
import '../common/ProfileChangeNotifier.dart';

class ThemeModel extends ProfileChangeNotifier {
  // 获取当前主题，如果未设置主题，则默认使用蓝色主题
  MaterialColor get theme {
    List<MaterialColor> themes = Global.themes;
    MaterialColor tempThemeColor =  themes.firstWhere((e) {
      return e.value == themes[profile.theme!.toInt()].value;
    }, orElse: () => Colors.blue);
    return tempThemeColor;
  }

  //主题改变后，通知其依赖项，新主题会立即生效
  set theme(MaterialColor color) {
    if (color != theme) {
      profile.theme = Global.themes.indexOf(color);
      notifyListeners();
    }
  }
}
