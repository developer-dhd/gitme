import '../models/index.dart';

import '../common/ProfileChangeNotifier.dart';

class UserModel extends ProfileChangeNotifier {

  User? get user => profile.user;

  //APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => user != null;

  set user(User? user) {
    if (user?.login != this.user?.login) {
      profile.lastLogin = this.user?.login;
      profile.user = user;
      notifyListeners();
    }
  }
}
