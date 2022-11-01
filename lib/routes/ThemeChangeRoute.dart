import 'package:flutter/material.dart';
import '../common/Global.dart';
import '../states/ThemeModel.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';

class ThemeChangeRoute extends StatelessWidget {
  const ThemeChangeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).change_theme),
      ),
      body: ListView(
        children: Global.themes.map<Widget>((e) {
          return GestureDetector(
            child: Padding(
              padding:const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Container(
                color: e,
                height: 45,
              ),
            ),
            onTap: () {
              Provider.of<ThemeModel>(context, listen: false).theme = e;
            },
          );
        }).toList(),
      ),
    );
  }
}
