/**
 * @program: lens_flutter_blog
 *
 * @description:
 *
 * @author: Lens Chen
 *
 * @create: 2020-09-22 09:09
 **/
// To parse this JSON data, do
//
//     final archiveListResult = archiveListResultFromJson(jsonString);

import 'dart:convert';

import 'package:lens_flutter_blog/json/post.dart';

ArchiveListResult archiveListResultFromJson(String str) => ArchiveListResult.fromJson(json.decode(str));

String archiveListResultToJson(ArchiveListResult data) => json.encode(data.toJson());

class ArchiveListResult {
  ArchiveListResult({
    this.success,
    this.resultCode,
    this.message,
    this.models,
  });

  int success;
  String resultCode;
  String message;
  List<ArchiveModel> models;

  factory ArchiveListResult.fromJson(Map<String, dynamic> json) => ArchiveListResult(
    success: json["success"],
    resultCode: json["resultCode"],
    message: json["message"],
    models: List<ArchiveModel>.from(json["models"].map((x) => ArchiveModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "resultCode": resultCode,
    "message": message,
    "models": List<dynamic>.from(models.map((x) => x.toJson())),
  };
}

class ArchiveModel {
  ArchiveModel({
    this.articleTotal,
    this.archiveDate,
    this.archivePosts,
  });

  int articleTotal;
  int archiveDate;

  // For tag archive page
  String tagName;

  List<ArticleItem> archivePosts;

  factory ArchiveModel.fromJson(Map<String, dynamic> json) => ArchiveModel(
    articleTotal: json["articleTotal"],
    archiveDate: json["archiveDate"],
    archivePosts: List<ArticleItem>.from(json["archivePosts"].map((x) => ArticleItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "articleTotal": articleTotal,
    "archiveDate": archiveDate,
    "archivePosts": List<dynamic>.from(archivePosts.map((x) => x.toJson())),
  };
}




