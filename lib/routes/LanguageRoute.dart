import 'package:flutter/material.dart';
import '../states/LocaleModel.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';

class LanguageRoute extends StatelessWidget {
  const LanguageRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gm = S.of(context);
    var color = Theme.of(context).primaryColor;
    var localModel = Provider.of<LocaleModel>(context);
    print("当前语言：${localModel.locale}");
    Widget buildLanguageItem(String lang, value) {
      return ListTile(
        title: Text( //对当前语言进行高亮显示
          lang,
          style: TextStyle(
            color: localModel.locale == value ? color : null,
          ),
        ),
        trailing: localModel.locale == value
            ? Icon(
                Icons.done,
                color: color,
              )
            : null,
        onTap: (){
          // 此行代码会通知Material App重新build
          localModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(gm.language),
      ),
      body: ListView(
        children: [
          buildLanguageItem("中文简体", "zh_Hans_CN"),
          buildLanguageItem("English", "en_US")
        ],
      ),
    );
  }
}
