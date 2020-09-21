// To parse this JSON data, do
//
//     final postListResponseEntity = postListResponseEntityFromJson(jsonString);

import 'dart:convert';

PostListResponseEntity postListResponseEntityFromJson(String str) => PostListResponseEntity.fromJson(json.decode(str));

String postListResponseEntityToJson(PostListResponseEntity data) => json.encode(data.toJson());

class PostListResponseEntity {
  PostListResponseEntity({
    this.success,
    this.resultCode,
    this.message,
    this.models,
    this.pageInfo,
  });

  int success;
  String resultCode;
  String message;
  List<ArticleItem> models;
  PageInfo pageInfo;

  factory PostListResponseEntity.fromJson(Map<String, dynamic> json) => PostListResponseEntity(
    success: json["success"],
    resultCode: json["resultCode"],
    message: json["message"],
    models: List<ArticleItem>.from(json["models"].map((x) => ArticleItem.fromJson(x))),
    pageInfo: PageInfo.fromJson(json["pageInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "resultCode": resultCode,
    "message": message,
    "models": List<dynamic>.from(models.map((x) => x.toJson())),
    "pageInfo": pageInfo.toJson(),
  };
}

class ArticleItem {
  ArticleItem({
    this.id,
    this.title,
    this.comments,
    this.status,
    this.summary,
    this.views,
    this.weight,
    this.createTime,
    this.updateTime,
    this.syncStatus,
    this.author,
    this.thumbnail,
    this.tagsList,
    this.categoryId,
    this.categoryName,
  });



  int id;
  String title;
  int comments;
  int status;
  String summary;
  int views;
  int weight;
  int createTime;
  int updateTime;
  int syncStatus;
  String author;
  String thumbnail;
  List<Tag> tagsList = List();
  int categoryId;
  String categoryName;

  factory ArticleItem.fromJson(Map<String, dynamic> json) => ArticleItem(
    id: json["id"],
    title: json["title"],
    comments: json["comments"],
    status: json["status"],
    summary: json["summary"],
    views: json["views"],
    weight: json["weight"],
    createTime: json["createTime"],
    updateTime: json["updateTime"],
    syncStatus: json["syncStatus"],
    author: json["author"],
    thumbnail: json["thumbnail"],
    tagsList: List<Tag>.from(json["tagsList"].map((x) => Tag.fromJson(x))),
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() {
    if(tagsList==null)
      tagsList = new List<Tag>();
    return {
      "id": id,
      "title": title,
      "comments": comments,
      "status": status,
      "summary": summary,
      "views": views,
      "weight": weight,
      "createTime": createTime,
      "updateTime": updateTime,
      "syncStatus": syncStatus,
      "author": author,
      "thumbnail": thumbnail,
      "tagsList": List<dynamic>.from(tagsList.map((x) => x.toJson())),
      "categoryId": categoryId,
      "categoryName": categoryName,
    };
  }
}

class Tag {
  Tag({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class PageInfo {
  PageInfo({
    this.page,
    this.size,
    this.total,
  });

  int page;
  int size;
  int total;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    page: json["page"],
    size: json["size"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "size": size,
    "total": total,
  };


}
class PostListRequestEntity extends ArticleItem{

}
