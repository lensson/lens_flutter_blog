import 'package:flutter/material.dart';

import 'package:lens_flutter_blog/apis/archiveAPI.dart';
import 'package:lens_flutter_blog/apis/postAPI.dart';
import 'package:lens_flutter_blog/config/assets.dart';
import 'package:lens_flutter_blog/config/base_config.dart';
import 'package:lens_flutter_blog/json/archive.dart';
import 'package:lens_flutter_blog/json/post.dart';
import 'package:lens_flutter_blog/utils/date.dart';
import 'package:lens_flutter_blog/widgets/web_bar.dart';
import 'package:lens_flutter_blog/widgets/common_layout.dart';



class ArchivePage extends StatefulWidget {
  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  List<ArchiveModel> modelList = [];

//  List<ArticleItem> listOnTag = [];
  bool isFromTag = false;

  bool hasInitialed = false;

  void initialData() {
    hasInitialed = true;
    List arguments = ModalRoute.of(context).settings.arguments;

    if (arguments != null && arguments.length == 1 && (arguments[0] is Tag)) {
      isFromTag = true;

      GetPostsRequest param = new GetPostsRequest();
      Tag tag = arguments[0] as Tag;
      param.postsTagsId = tag.id.toString();

      PostAPI.getArticleItemList(
        context: context,
        params: param,
      ).then((value) {
        List<ArticleItem> listOnTag = value.models;
        ArchiveModel archiveModel = new ArchiveModel();
        archiveModel.tagName = tag.name;
        archiveModel.archivePosts = listOnTag;
        modelList.add(archiveModel);
        setState(() {});
      });
    } else {
      ArchiveAPI.getArchiveList(
        context: context,
      ).then((result) {
        if (result != null) {
          this.modelList.addAll(result.models);
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNotMobile = !PlatformType().isMobile();

    if (!hasInitialed) {
      initialData();
    }

    return CommonLayout(
      pageType: PageType.archive,
      child: modelList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: isNotMobile
                  ? const EdgeInsets.only(top: 50, left: 50, right: 50)
                  : const EdgeInsets.all(20),
              child: Card(
                margin: const EdgeInsets.only(bottom: 0.0),
                child: Container(
                  margin: isNotMobile
                      ? const EdgeInsets.only(top: 20, left: 50, right: 50)
                      : const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll) {
                      overScroll.disallowGlow();
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: modelList.length,
                      itemBuilder: (ctx, index) {
                        final List<ArticleItem> archivePostList =
                            modelList[index].archivePosts;
                        String label;
                        if (!isFromTag) {
                          DateTime date = DateTime.fromMillisecondsSinceEpoch(
                              modelList[index].archiveDate);
                          label = DateUtil.getYearAndMonth(date);
                        } else {
                          label = modelList[index].tagName;
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${label}',
                              style: isNotMobile
                                  ? Theme.of(context).textTheme.headline4
                                  : Theme.of(context).textTheme.headline6,
                            ),
                            Container(
                              margin: isNotMobile
                                  ? const EdgeInsets.only(
                                      top: 10, left: 50, right: 50)
                                  : EdgeInsets.all(0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(archivePostList.length,
                                    (index2) {
                                  final archivePost = archivePostList[index2];
                                  return Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: isNotMobile
                                        ? ListTile(
                                            onTap: () {
                                              openArticlePage(
                                                  context,
                                                  List.generate(
                                                      archivePostList.length,
                                                      (index) => ArticleItem(
                                                          title:
                                                              archivePostList[
                                                                      index]
                                                                  .title,
                                                          id: archivePostList[
                                                                  index]
                                                              .id)),
                                                  index2);
                                            },
                                            leading: Text(
                                              '${archivePost.title}',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: Assets.HuawenKt),
                                            ),
                                            trailing: Text(
                                              '${getDate(DateTime.fromMillisecondsSinceEpoch(archivePost.createTime))}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          )
                                        : FlatButton(
                                            onPressed: () => openArticlePage(
                                                context,
                                                List.generate(
                                                    archivePostList.length,
                                                    (index) => ArticleItem(
                                                        id: archivePostList[index].id,
                                                        title: archivePostList[
                                                                index]
                                                            .title)),
                                                index2),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  30,
                                              child: Text(
                                                '${archivePost.title}',
                                                style: TextStyle(
                                                    fontSize:
                                                        isNotMobile ? 20 : 15,
                                                    fontFamily:
                                                        Assets.HuawenKt),
                                              ),
                                            ),
                                          ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void openArticlePage(
      BuildContext context, List<ArticleItem> beans, int index) {
    final id = beans[index].id;

    Navigator.of(context)
        .pushNamed(articlePage + '/$id', arguments: ArticleData(index, beans));
  }

  String getDate(DateTime time) {
    return '${time.year}.${time.month}.${time.day}';
  }
}
