/**
 * @program: lens_flutter_blog
 *
 * @description:
 *
 * @author: Lens Chen
 *
 * @create: 2020-09-14 13:53
 **/

// To parse this JSON data, do
//
//     final categoryListResult = categoryListResultFromJson(jsonString);

import 'dart:convert';

CategoryListResult categoryListResultFromJson(String str) =>
    CategoryListResult.fromJson(json.decode(str));

String categoryListResultToJson(CategoryListResult data) =>
    json.encode(data.toJson());

class CategoryListResult {
  CategoryListResult({
    this.success,
    this.resultCode,
    this.message,
    this.models,
  });

  int success;
  String resultCode;
  String message;
  List<Model> models;

  factory CategoryListResult.fromJson(Map<String, dynamic> json) =>
      CategoryListResult(
        success: json["success"],
        resultCode: json["resultCode"],
        message: json["message"],
        models: List<Model>.from(json["models"].map((x) => Model.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "success": success,
        "resultCode": resultCode,
        "message": message,
        "models": List<dynamic>.from(models.map((x) => x.toJson())),
      };
}

class Model {
  Model({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Model.fromJson(Map<String, dynamic> json) =>
      Model(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
      };
}


class CategoryListRequest {
  int id;
  String name;

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
      };
}