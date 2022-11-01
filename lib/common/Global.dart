import 'dart:convert';

import 'package:flutter/material.dart';
import './Git.dart';
import './NetCache.dart';
import '../models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 提供可选的五套主题颜色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static late SharedPreferences _preferences;

  static NetCache netCache = NetCache();

  static Profile profile = Profile();

  //获取可选主题列表
  static List<MaterialColor> get themes => _themes;

  //是否为release版本
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，在app启动时执行
  static Future init() async {
    //在初始化应用之前与flutter引擎通信
    WidgetsFlutterBinding.ensureInitialized();
    //从SharedPreferences中取出全局变量
    _preferences = await SharedPreferences.getInstance();
    String? storeProfile = _preferences.getString("profile");
    if (storeProfile != null) {
      try {
        Map<String, dynamic> map = jsonDecode(storeProfile);
        print("Global初始化主题：${map["theme"]}");
        profile = Profile.fromJson(map);
      } catch (e) {
        print("异常信息：$e");
      }
    } else {
      // 设置默认主题，代表蓝色
      profile = Profile()
        ..theme = 0
        ..locale = "zh_Hans_CN";
    }

    // 如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;
    print("全局语言 == ${profile.locale}");
    //初始化网络请求相关配置
    Git.init();
  }

  //持久化Profile信息
  static saveProfile() =>
      _preferences.setString("profile", jsonEncode(profile.toJson()));
}
