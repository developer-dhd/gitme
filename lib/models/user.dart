import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  // 用户登录名
  late String login;
  // 用户ID
  late num id;
  // 节点id
  @JsonKey(name: 'node_id') late String nodeId;
  // 用户头像地址
  @JsonKey(name: 'avatar_url') late String avatarUrl;
  // 用户类型，可能是组织
  late String type;
  // 用户名字
  String? name;
  // 公司
  String? company;
  // 博客地址
  String? blog;
  // 用户所处地理位置
  String? location;
  // 邮箱
  String? email;
  bool? hireable;
  // 用户简介
  String? bio;
  // 公开项目数
  @JsonKey(name: 'public_repos') late num publicRepos;
  // 关注该用户的人数
  late num followers;
  // 该用户关注的人数
  late num following;
  // 账号创建时间
  @JsonKey(name: 'created_at') late String createdAt;
  // 账号信息更新时间
  @JsonKey(name: 'updated_at') late String updatedAt;
  
  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
