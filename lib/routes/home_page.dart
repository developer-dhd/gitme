import 'package:flutter/material.dart';
import '../widgets/MyDrawer.dart';

import '../generated/l10n.dart';
import '../widgets/BodyPageWidget.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).home),
      ),
      body: const BodyPageWidget(), //主页
      drawer: const MyDrawer(),
      //drawer: DrawerPageWidget(), //抽屉页面
    );
  }
}
