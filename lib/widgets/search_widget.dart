import 'package:flutter/material.dart';

import 'package:lens_flutter_blog/config/base_config.dart';

import 'package:lens_flutter_blog/json/post.dart';

import 'package:lens_flutter_blog/logic/query_logic.dart';

class SearchWidget extends StatefulWidget {
  final Map dataMap;
  final List<ArticleItem> itemList;
  const SearchWidget({Key key, @required this.dataMap,@required this.itemList}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final logic = QueryLogic();
  String query = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        query = _controller.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final List<Data> showDataList =
        logic.queryArticles(query, Map.from(widget.dataMap));

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            alignment: Alignment.topCenter,
            width: size.width,
            height: size.height,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              width: size.width / 2 < 300 ? 300 : size.width / 2,
              height: showDataList.isEmpty ? 150 : size.height - 200,
              alignment: Alignment.topCenter,
              child: Card(
                color: Theme.of(context).cardColor.withOpacity(0.9),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: '输入标题、内容进行搜索吧',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      color: Colors.grey,
                    ),
                    Expanded(child: getLoadingWidget(showDataList)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getLoadingWidget(List<Data> showDataList) {
    if (query.isEmpty)
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: const Text(
          '☕️...',
          style: TextStyle(fontSize: 30),
        ),
      );
    if (showDataList.isEmpty)
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: const Text(
          '😅啥也没有...',
          style: TextStyle(fontSize: 30),
        ),
      );
    else
      return ListView.builder(
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
                    final id = this.getArticleItemIdByName(name);
                    Navigator.of(context).pushNamed(
                      articlePage + '/$id',
                      arguments: ArticleData(
                        index,
                        List.generate(
                          showDataList.length,
                          (index) => ArticleItem(
                            title: showDataList[index].title,
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
      );
  }


  int getArticleItemIdByName(String name){
    widget.itemList.forEach((element) {
      if(element.title == name)
        return element.id;
    });
    return -1;
  }
}
