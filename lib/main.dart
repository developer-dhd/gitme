import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './common/Global.dart';
import './routes/LanguageRoute.dart';
import './routes/LoginRoute.dart';
import './routes/ThemeChangeRoute.dart';
import './routes/home_page.dart';
import './states/LocaleModel.dart';
import './states/ThemeModel.dart';
import './states/UserModel.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

void main() {
  Global.init().then((e) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (BuildContext context, themeModel, localeModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: themeModel.theme),
            onGenerateTitle: (context) {
              return S.of(context).title;
            },
            locale: localeModel.getLocale(),
            localizationsDelegates: const [
              //本地化代理类
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              //生成的代理类
              S.delegate
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeResolutionCallback: (local, supportedLocales) {
              if (localeModel.getLocale() != null) {
                //如果已经选定语言
                print("选定语言 == ${localeModel.getLocale()}");
                return localeModel.getLocale();
              } else {
                //跟随系统
                Locale tempLocale;
                if (supportedLocales.contains(local)) {
                  tempLocale = local!;
                } else {
                  //如果系统语言不是中文简体或美国英语，则默认使用美国英语
                  tempLocale = const Locale.fromSubtags(
                      languageCode: 'zh',
                      scriptCode: 'Hans',
                      countryCode: 'CN');
                }
                return tempLocale;
              }
            },
            // 注册路由表
            routes: <String, WidgetBuilder>{
              "login": (context) => const LoginRoute(),
              "themes": (context) => const ThemeChangeRoute(),
              "language": (context) => const LanguageRoute(),
            },
            home: const HomeRoute(),
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
