import 'package:json_annotation/json_annotation.dart';

part 'cacheConfig.g.dart';

@JsonSerializable()
class CacheConfig {
  CacheConfig();

  // 是否启用缓存
  late bool enable;
  // 缓存的最长时间，单位（秒）
  late num maxAge;
  // 最大缓存数
  late num maxCount;
  
  factory CacheConfig.fromJson(Map<String,dynamic> json) => _$CacheConfigFromJson(json);
  Map<String, dynamic> toJson() => _$CacheConfigToJson(this);
}
