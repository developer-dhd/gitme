import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../common/Global.dart';
import '../models/index.dart';
import '../states/UserModel.dart';
import 'package:provider/provider.dart';

import '../common/Git.dart';
import '../generated/l10n.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({Key? key}) : super(key: key);

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool showPwd = false;
  final GlobalKey _formKey = GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  Future<User?> onLogin(BuildContext context) async {
    User? user;
    //先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      EasyLoading.show(status: "loading...");
      try {
        user = await Git(context)
            .login(_unameController.text, _pwdController.text);
      } on DioError catch (e) {
        if (e.response?.statusCode == 401) {
          EasyLoading.showToast("用户名或密码错误");
        } else {
          EasyLoading.showToast(e.toString());
        }
      } finally {
        EasyLoading.dismiss();
      }
    }
    return user;
  }

  @override
  void initState() {
    _unameController.text = Global.profile.lastLogin ?? "";
    if (_unameController.text.isNotEmpty) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(gm.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _unameController,
                  decoration: InputDecoration(
                    labelText: gm.userName,
                    hintText: gm.userName,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (v) {
                    //校验用户名（不能为空）
                    return v == null || v.trim().isNotEmpty
                        ? null
                        : gm.userNameRequired;
                  },
                ),
                TextFormField(
                  autofocus: !_nameAutoFocus,
                  controller: _pwdController,
                  decoration: InputDecoration(
                    labelText: gm.password,
                    hintText: gm.password,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPwd = !showPwd;
                        });
                      },
                      icon: Icon(
                          showPwd ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  obscureText: !showPwd,
                  //校验密码（不能为空）
                  validator: (v) {
                    return v == null || v.trim().isNotEmpty
                        ? null
                        : gm.passwordRequired;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.expand(height: 55.0),
                    child: ElevatedButton(
                      //因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
                      onPressed: () {
                        onLogin(context).then((user) {
                          Provider.of<UserModel>(context, listen: false).user =
                              user;
                          //登录成功则返回
                          if (user != null) Navigator.of(context).pop();
                        });
                      },
                      child: Text(gm.login),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
