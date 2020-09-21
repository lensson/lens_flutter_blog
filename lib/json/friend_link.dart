// To parse this JSON data, do
//
//     final friendlyLinkListResult = friendlyLinkListResultFromJson(jsonString);

import 'dart:convert';

FriendlyLinkListResult friendlyLinkListResultFromJson(String str) => FriendlyLinkListResult.fromJson(json.decode(str));

String friendlyLinkListResultToJson(FriendlyLinkListResult data) => json.encode(data.toJson());

class FriendlyLinkListResult {
    FriendlyLinkListResult({
        this.success,
        this.resultCode,
        this.message,
        this.models,
        this.pageInfo,
    });

    int success;
    String resultCode;
    String message;
    List<FriendLink> models;
    PageInfo pageInfo;

    factory FriendlyLinkListResult.fromJson(Map<String, dynamic> json) => FriendlyLinkListResult(
        success: json["success"],
        resultCode: json["resultCode"],
        message: json["message"],
        models: List<FriendLink>.from(json["models"].map((x) => FriendLink.fromJson(x))),
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

class FriendLink {
    FriendLink({
        this.id,
        this.title,
        this.name,
        this.href,
        this.logo,
        this.sort,
        this.description,
    });

    int id;
    String title;
    String name;
    String href;
    String logo;
    int sort;
    String description;

    factory FriendLink.fromJson(Map<String, dynamic> json) => FriendLink(
        id: json["id"],
        title: json["title"],
        name: json["name"],
        href: json["href"],
        logo: json["logo"],
        sort: json["sort"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "name": name,
        "href": href,
        "logo": logo,
        "sort": sort,
        "description": description,
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
