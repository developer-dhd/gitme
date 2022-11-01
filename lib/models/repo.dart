import 'package:json_annotation/json_annotation.dart';

part 'repo.g.dart';

@JsonSerializable()
class Repo {
  Repo();

  // 项目id
  late num id;
  // 项目名称
  late String name;
  // 项目完整名称
  @JsonKey(name: 'full_name') late String fullName;
  // 项目拥有者简要信息
  late Map<String,dynamic> owner;
  // 是否私有项目
  late bool private;
  // 项目描述
  String? description;
  // 该项目是否为fork的项目
  late bool fork;
  // 该项目的主要编程语言
  String? language;
  // fork了该项目的数量
  @JsonKey(name: 'forks_count') late num forksCount;
  // 该项目的star数量
  @JsonKey(name: 'stargazers_count') late num stargazersCount;
  // 项目占用的存储大小
  late num size;
  // 项目的默认分支
  @JsonKey(name: 'default_branch') late String defaultBranch;
  // 该项目当前打开的issue数量
  @JsonKey(name: 'open_issues_count') late num openIssuesCount;
  // 项目的默认分支
  @JsonKey(name: 'pushed_at') late String pushedAt;
  // 项目的默认分支
  @JsonKey(name: 'created_at') late String createdAt;
  // 项目的默认分支
  @JsonKey(name: 'updated_at') late String updatedAt;
  // {key: mit, name: MIT License, spdx_id: MIT, url: https://api.github.com/licenses/mit, node_id: MDc6TGljZW5zZW1pdA==}
  Map<String,dynamic>? license;
  
  factory Repo.fromJson(Map<String,dynamic> json) => _$RepoFromJson(json);
  Map<String, dynamic> toJson() => _$RepoToJson(this);
}
