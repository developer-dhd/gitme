import 'package:flutter/material.dart';
import '../common/CommonWidget.dart';
import '../states/UserModel.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[_buildHeader(), Expanded(child: _buildMenus())],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
        builder: (BuildContext context, UserModel usermodel, Widget? child) {
      return GestureDetector(
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.only(top: 40, bottom: 20),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipOval(
                  child: usermodel.isLogin
                      ? CommonWidget.gmAvatar(usermodel.user!.avatarUrl,
                          width: 80)
                      : Image.asset(
                          "images/avatar-default.png",
                          width: 80,
                        ),
                ),
              ),
              Text(
                usermodel.isLogin ? usermodel.user!.login : S.of(context).login,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        onTap: () {
          if (!usermodel.isLogin) {
            Navigator.of(context).pushNamed("login");
          }
        },
      );
    });
  }

  Widget _buildMenus() {
    return Consumer(
        builder: (BuildContext context, UserModel userModel, Widget? child) {
      var gm = S.of(context);
      return ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(gm.theme),
            onTap: () => Navigator.pushNamed(context, "themes"),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(gm.language),
            onTap: () => Navigator.pushNamed(context, "language"),
          ),
          if (userModel.isLogin)
            ListTile(
              leading: const Icon(Icons.power_settings_new),
              title: Text(gm.logout),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(gm.logoutTip),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(gm.cancel)),
                          TextButton(
                              onPressed: () {
                                userModel.user = null;
                                Navigator.pop(context);
                              },
                              child: Text(gm.ok))
                        ],
                      );
                    });
              },
            )
        ],
      );
    });
  }
}
