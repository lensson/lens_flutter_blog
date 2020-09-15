import 'package:flutter/cupertino.dart';
import 'package:lens_flutter_blog/json/category.dart';
import 'package:lens_flutter_blog/utils/http.dart';

/**
 * @program: lens_flutter_blog
 *
 * @description:
 *
 * @author: Lens Chen
 *
 * @create: 2020-09-14 14:54
 **/

class PostAPI{
  static Future<CategoryListResult> getCategoryList({
    @required BuildContext context,
    CategoryListRequest params,
    bool refresh = false,
    bool cacheDisk = false,
  }) async {
    var response = await HttpUtil().get(
      '/news',
      context: context,
      params: params?.toJson(),
      refresh: refresh,
      cacheDisk: cacheDisk,
//      cacheKey: STORAGE_INDEX_NEWS_CACHE_KEY,
    );
    return CategoryListResult.fromJson(response);
  }
}