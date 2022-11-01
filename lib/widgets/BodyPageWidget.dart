import 'package:flutter/material.dart';
import '../common/Git.dart';
import '../models/repo.dart';
import '../states/UserModel.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import 'RepoItem.dart';

class BodyPageWidget extends StatefulWidget {
  const BodyPageWidget({Key? key}) : super(key: key);

  @override
  State<BodyPageWidget> createState() => _BodyPageWidgetState();
}

class _BodyPageWidgetState extends State<BodyPageWidget> {
  static const loadingTag = "##loading##"; //表尾标记
  List<Repo> items = [Repo()..name = loadingTag];
  bool hasMore = true; //是否还有数据
  int page = 1; //当前请求是第几页

  void _retrieveData(BuildContext context) async {
    List<Repo> data = await Git(context).getRepos(
      queryParameters: {
        "page": page,
        "per_page": 20,
      },
    );
    //如果返回数据小于指定的条数，则表示没有更多数据，反之则有更多数据
    hasMore = data.isNotEmpty && data.length % 20 == 0;
    setState(() {
      //把请求到的新数据插入到items列表中
      items.insertAll(items.length - 1, data);
      page++;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).loginTip,
              style: const TextStyle(
                  color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("login");
              },
              child: Text(S.of(context).login),
            )
          ],
        ),
      );
    }
    return ListView.separated(
        itemBuilder: (context, index) {
          if (items[index].name == loadingTag) {
            if (hasMore) {
              _retrieveData(context);
              //加载时候显示loading
              return Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              );
            } else {
              //已经加载了100条数据，不在获取数据
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          }
          //显示单词列表项
          return RepoItem(items[index]);
        },
        separatorBuilder: (context, index) => const Divider(height: 0),
        itemCount: items.length);
  }
}
