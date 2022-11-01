// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repo _$RepoFromJson(Map<String, dynamic> json) => Repo()
  ..id = json['id'] as num
  ..name = json['name'] as String
  ..fullName = json['full_name'] as String
  ..owner = json['owner'] as Map<String, dynamic>
  ..private = json['private'] as bool
  ..description = json['description'] as String?
  ..fork = json['fork'] as bool
  ..language = json['language'] as String?
  ..forksCount = json['forks_count'] as num
  ..stargazersCount = json['stargazers_count'] as num
  ..size = json['size'] as num
  ..defaultBranch = json['default_branch'] as String
  ..openIssuesCount = json['open_issues_count'] as num
  ..pushedAt = json['pushed_at'] as String
  ..createdAt = json['created_at'] as String
  ..updatedAt = json['updated_at'] as String
  ..license = json['license'] as Map<String, dynamic>?;

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'owner': instance.owner,
      'private': instance.private,
      'description': instance.description,
      'fork': instance.fork,
      'language': instance.language,
      'forks_count': instance.forksCount,
      'stargazers_count': instance.stargazersCount,
      'size': instance.size,
      'default_branch': instance.defaultBranch,
      'open_issues_count': instance.openIssuesCount,
      'pushed_at': instance.pushedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'license': instance.license,
    };
