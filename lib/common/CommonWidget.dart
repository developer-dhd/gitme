import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommonWidget{
  static Widget gmAvatar(String url,
      {double width = 30,
        double? height,
        BoxFit? fit,
        BorderRadius? borderRadius}) {
    var placeholder = Image.asset(
      "images/avatar-default.png", //头像占位
      width: width,
      height: height,
      fit: fit,
    );
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(2),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => placeholder,
        errorWidget: (context, url, error) => placeholder,
      ),
    );
  }
}