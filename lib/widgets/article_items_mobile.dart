import 'package:flutter/material.dart';
import 'package:lens_flutter_blog/config/base_config.dart';
import 'package:lens_flutter_blog/json/post.dart';
import 'package:lens_flutter_blog/notifier/selected_articles_item_list.dart';
import 'package:provider/provider.dart';

import 'article_item.dart';

class MobileArticleItems extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    List<ArticleItem> itemList = Provider.of<SelectedArticleItemList>(context).itemList;

    if (itemList.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      print("showDataList = $itemList");
      return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return true;
        },
        child: ListView.builder(
          itemCount: itemList.length,
          padding: EdgeInsets.all(0.0),
          itemBuilder: (ctx, index) {
            return GestureDetector(
              child: ArticleItemWidget(bean: itemList[index]),
              onTap: () {
                final id = itemList[index].id;
                Navigator.of(context).pushNamed(articlePage + '/$id',
                    arguments: ArticleData(index, itemList));
              },
            );
          },
        ),
      );
    }
  }
}
