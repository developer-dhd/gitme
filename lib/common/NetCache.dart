import 'dart:collection';

import 'package:dio/dio.dart';
import './CacheObject.dart';
import './Global.dart';

class NetCache extends Interceptor {
  //为确保迭代器顺序和对象插入时间一致顺序一致，使用LinkedHashMap
  LinkedHashMap<String, CacheObject> cache = LinkedHashMap();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!Global.profile.cache!.enable) {
      return handler.next(options);
    }

    //refresh标记是否下拉刷新
    //option.extra是专门用于扩展请求参数的
    bool refresh = options.extra["refresh"] == true;
    //如果是下拉刷新，先删除相关缓存
    if (refresh) {
      //如果是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
      if (options.extra["list"] == true) {
        cache.removeWhere((key, value) => key.contains(options.path));
      } else {
        //如果不是列表，则只删除uri相同的缓存
        delete(options.uri.toString());
      }
      return handler.next(options);
    }
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      var ob = cache[key];
      if (ob != null) {
        //如缓存未过期，则返回缓存内容
        if ((DateTime.now().microsecondsSinceEpoch - ob.timeStamp) / 1000 <
            Global.profile.cache!.maxAge) {
          return handler.resolve(ob.response);
        } else {
          //如已经过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 如果启用缓存，将返回结果保存到缓存
    if (Global.profile.cache!.enable) {
      _saveCache(response);
    }
    handler.next(response);
  }

  void _saveCache(Response response) {
    var options = response.requestOptions;
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      //如果缓存数量超过最大数量限制，则移除最早的一条记录
      if(cache.length == Global.profile.cache!.maxCount){
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      cache[key] = CacheObject(response);
    }
  }

  void delete(String key) {
    cache.remove(key);
  }
}
