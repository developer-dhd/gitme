import 'package:dio/dio.dart';

class CacheObject {
  Response response;

  int timeStamp; //缓存创建时间

  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}
