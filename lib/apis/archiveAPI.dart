import 'package:flutter/cupertino.dart';
import 'package:lens_flutter_blog/config/base_config.dart';
import 'package:lens_flutter_blog/json/archive.dart';
import 'package:lens_flutter_blog/utils/http.dart';

/**
 * @program: lens_flutter_blog
 *
 * @description:
 *
 * @author: Lens Chen
 *
 * @create: 2020-09-22 09:11
 **/
class ArchiveAPI{

  static Future<ArchiveListResult> getArchiveList({
    @required BuildContext context,
    bool refresh = false,
    bool cacheDisk = false,
  }) async {
    var response = await HttpUtil().get(
      GET_ARCHIVE_LIST_URI,
      context: context,
      refresh: refresh,
      cacheDisk: cacheDisk,
    );
    return ArchiveListResult.fromJson(response);
  }

}