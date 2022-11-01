# github app

## 说明

github客户端app, 本app仅供学习Flutter使用，代码来自于 [《Flutter实战·第二版》](https://book.flutterchina.club/)

**打包教程地址，[点击查看](https://decoderx.cc/posts/59b1662f.html)**

## 使用

1. 直接clone代码到IDE， 执行` flutter pub get`安装依赖，启动调试。
2. 本项目已经配置好了打包相关内容，只需要在`D盘根目录下`生成` key.jks`，然后执行` flutter build apk` 就能签名打包了。
3. 密钥证书的配置` key.properties`在android根目录下，请根据自身生成证书时候的配置来配置它。
4. 生成证书的步骤，请看官方教程：[点击查看官方打包教程](https://flutter.cn/docs/deployment/android)
5. app中登录的密码是github生成的`token`，因为github现在不允许使用密码登录了。关于生成token， [请点击我查看](https://docs.github.com/cn/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)。

## 下载

Release中提供一个打包好的版本，仅供测试参考！！！

## 应用截图

![Demo照片02](https://bucket.decoderx.cc/blog-image/FlutterBuildApk/Demo照片02.jpg)
![Demo照片01](https://bucket.decoderx.cc/blog-image/FlutterBuildApk/Demo照片01.jpg)
