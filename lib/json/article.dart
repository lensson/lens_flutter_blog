/**
 * @program: lens_flutter_blog
 *
 * @description:
 *
 * @author: Lens Chen
 *
 * @create: 2020-09-22 16:10
 **/


// To parse this JSON data, do
//
//     final getPostResult = getPostResultFromJson(jsonString);

import 'dart:convert';

import 'package:lens_flutter_blog/json/post.dart';

GetPostResult getPostResultFromJson(String str) => GetPostResult.fromJson(json.decode(str));

String getPostResultToJson(GetPostResult data) => json.encode(data.toJson());

class GetPostResult {
  GetPostResult({
    this.success,
    this.resultCode,
    this.message,
    this.model,
  });

  int success;
  String resultCode;
  String message;
  ArticleItem model;

  factory GetPostResult.fromJson(Map<String, dynamic> json) => GetPostResult(
    success: json["success"],
    resultCode: json["resultCode"],
    message: json["message"],
    model: ArticleItem.fromJson(json["model"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "resultCode": resultCode,
    "message": message,
    "model": model.toJson(),
  };
}




