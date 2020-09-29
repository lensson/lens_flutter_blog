/**
 * @program: lens_flutter_blog
 *
 * @description:
 *
 * @author: Lens Chen
 *
 * @create: 2020-09-23 08:54
 **/
// To parse this JSON data, do
//
//     final getTagListResult = getTagListResultFromJson(jsonString);

import 'dart:convert';

import 'package:lens_flutter_blog/json/post.dart';

GetTagListResult getTagListResultFromJson(String str) => GetTagListResult.fromJson(json.decode(str));

String getTagListResultToJson(GetTagListResult data) => json.encode(data.toJson());

class GetTagListResult {
  GetTagListResult({
    this.success,
    this.resultCode,
    this.message,
    this.models,
  });

  int success;
  String resultCode;
  String message;
  List<Tag> models;

  factory GetTagListResult.fromJson(Map<String, dynamic> json) => GetTagListResult(
    success: json["success"],
    resultCode: json["resultCode"],
    message: json["message"],
    models: List<Tag>.from(json["models"].map((x) => Tag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "resultCode": resultCode,
    "message": message,
    "models": List<dynamic>.from(models.map((x) => x.toJson())),
  };
}



