import 'package:flutter/material.dart';
import './Global.dart';
import '../models/index.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存profile变更
    super.notifyListeners(); //通知依赖的widget更新
  }
}
