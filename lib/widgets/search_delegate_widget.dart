import 'package:flutter/material.dart';

import 'package:lens_flutter_blog/config/base_config.dart';
import 'package:lens_flutter_blog/json/post.dart';
import 'package:lens_flutter_blog/logic/query_logic.dart';

class SearchDelegateWidget extends SearchDelegate<String> {
  final Map dataMap;
  List<ArticleItem> itemList;
  final logic = QueryLogic();

  SearchDelegateWidget(this.dataMap, this.itemList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // final List<ArticleItem> showDataList = itemList;

    final List<Data> showDataList =
        logic.queryArticles(query, Map.from(dataMap));

    return showDataList.isEmpty
        ? const Center(
            child: Text(
              '😅啥也没有...',
              style: TextStyle(fontSize: 30),
            ),
          )
        : Container(
            child: ListView.builder(
              itemCount: showDataList.length,
              itemBuilder: (ctx, index) {
                final Data data = showDataList[index];
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.sort),
                        title: logic.getTitle(data, query),
                        onTap: () {
                          final name = showDataList[index].title;
                          // final result = Uri.encodeFull(name);
                          final id = this.getArticleItemIdByName(name);
                          Navigator.of(context).pushNamed(
                            articlePage + '/$id',
                            arguments: ArticleData(
                              index,
                              List.generate(
                                showDataList.length,
                                (index) => ArticleItem(
                                  title: showDataList[index].title,
                                  id: id,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Container(
                          width: 2,
                        ),
                        title: logic.getContent(data, query),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }

  Widget getContent(Data data, String query) {
    if (data.content != null) {
      List<String> contentList = data.contentList;
      return Text.rich(
        TextSpan(
          children: List.generate(
            contentList.length,
            (index) {
              final String text = contentList[index];
              return TextSpan(
                  text: text,
                  style: TextStyle(
                      color: text == query ? Colors.redAccent : null));
            },
          ),
        ),
      );
    } else
      return Text(subStringText(data.content));
  }

  String subStringText(String content) {
    return content.length > 100 ? content.substring(0, 100) : content;
  }


  Widget getTitle(Data data, String query) {
    if (data.title != null) {
      List<String> titleList = [data.title];
      return Text.rich(
        TextSpan(
          children: List.generate(
            titleList.length,
            (index) {
              final text = titleList[index];
              return TextSpan(
                text: text,
                style: TextStyle(
                  color: text == query ? Colors.redAccent : null,
                ),
              );
            },
          ),
        ),
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    } else
      return Text(
        data.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 2,
      ),
      title: const Text('输入标题、内容进行搜索吧'),
    );
  }

  int getArticleItemIdByName(String name) {
    ArticleItem item = itemList.firstWhere((element) {
      return element.title == name;
    });
    if (item != null) return item.id;
  }
}
