import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "cacheConfig.dart";
part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile();

  // Github账号信息，结构见"user.json"
  User? user;
  // 登录用户的token(oauth)或密码
  String? token;
  // 主题索引
  num? theme;
  // 缓存策略信息，结构见"cacheConfig.json"
  CacheConfig? cache;
  // 最近一次的注销登录的用户名
  String? lastLogin;
  // APP语言信息
  String? locale;
  
  factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
