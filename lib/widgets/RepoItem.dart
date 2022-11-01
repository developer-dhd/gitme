import 'package:flutter/material.dart';
import '../common/CommonWidget.dart';
import '../widgets/MyIcons.dart';

import '../generated/l10n.dart';
import '../models/repo.dart';

class RepoItem extends StatefulWidget {
  final Repo repo;

  // 将`repo.id`作为RepoItem的默认key
  RepoItem(this.repo) : super(key: ValueKey(repo.id));

  @override
  State<RepoItem> createState() => _RepoItemState();
}

class _RepoItemState extends State<RepoItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
          bottom: BorderSide(color: Theme.of(context).dividerColor, width: .5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                dense: true,
                leading: CommonWidget.gmAvatar(
                  widget.repo.owner["avatar_url"],
                  width: 24.0,
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(
                  widget.repo.owner["login"],
                  textScaleFactor: .9,
                ),
                trailing: Text(widget.repo.language ?? "--"),
              ),
              // 构建项目标题和简介
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.repo.fork
                          ? widget.repo.fullName
                          : widget.repo.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: widget.repo.fork
                            ? FontStyle.italic
                            : FontStyle.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 12),
                      child: widget.repo.description == null
                          ? Text(S.of(context).noDescription,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[700],
                              ))
                          : Text(
                              widget.repo.description!,
                              maxLines: 3,
                              style: TextStyle(
                                height: 1.15,
                                color: Colors.blueGrey[700],
                                fontSize: 13,
                              ),
                            ),
                    ),
                    //构建卡片底部信息
                    _buildBottom()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    const paddingWidth = 10;
    return IconTheme(
      data: const IconThemeData(
        color: Colors.grey,
        size: 15,
      ),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.grey, fontSize: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(builder: (context) {
            var children = <Widget>[
              const Icon(MyIcons.star),
              Text(
                  " ${widget.repo.stargazersCount.toString().padRight(paddingWidth)}"),
              const Icon(MyIcons.issue),
              Text(
                  " ${widget.repo.openIssuesCount.toString().padRight(paddingWidth)}"),
              const Icon(MyIcons.fork),
              Text(
                  " ${widget.repo.forksCount.toString().padRight(paddingWidth)}"),
            ];
            if (widget.repo.fork) {
              children.addAll(<Widget>[
                const Icon(MyIcons.forked),
                Text("Forked".padRight(paddingWidth))
              ]);
            }
            if (widget.repo.private == true) {
              children.addAll(<Widget>[
                const Icon(Icons.lock),
                Text(" private".padRight(paddingWidth))
              ]);
            }
            return Row(
              children: children,
            );
          }),
        ),
      ),
    );
  }
}
