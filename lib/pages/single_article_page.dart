import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lens_flutter_blog/apis/postAPI.dart';
import 'package:markdown_widget/markdown_widget.dart';

import 'package:lens_flutter_blog/config/platform_type.dart';
import 'package:lens_flutter_blog/json/post.dart';
import 'package:lens_flutter_blog/widgets/web_bar.dart';
import 'package:lens_flutter_blog/config/url_launcher.dart';
import 'package:lens_flutter_blog/widgets/toast_widget.dart';
import 'package:lens_flutter_blog/widgets/toc_item.dart';
import 'package:lens_flutter_blog/widgets/common_layout.dart';



class ArticlePage extends StatefulWidget {



  final ArticleItem articleItem;
  final String id;

  const ArticlePage({Key key, this.articleItem, @required this.id})
      : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  ArticleItem bean;
  String markdownData = '';
  final TocController controller = TocController();



  @override
  void initState() {
    final int id = int.parse(Uri.decodeFull(widget.id));
    if(widget.articleItem == null){
      loadArticle(id);
    }else{
      markdownData = widget.articleItem.summary;
    }

    super.initState();
  }

  void loadArticle(int id) {

    PostAPI.getArticleItem(
        context: context,
        id: id,
    ).then((value) {
      bean = value.model;
      markdownData = bean.summary;
      Future.delayed(Duration(milliseconds: 200),(){
        setState(() {});
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isNotMobile = !PlatformType().isMobile();

    return CommonLayout(
      pageType: PageType.article,
      floatingActionButton: isNotMobile
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.white.withOpacity(0.8),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return buildTocListWidget(fontSize: 18);
                    });
              },
              child: Icon(
                Icons.format_list_bulleted,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
      child: Container(
          alignment: Alignment.center,
          margin: isNotMobile
              ? const EdgeInsets.all(0)
              : const EdgeInsets.only(left: 20, right: 20),
          child: markdownData.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowGlow();
                    return true;
                  },
                  child: isNotMobile
                      ? getWebLayout(width,  height, context)
                      : getMobileLayout(width, height, bean),
                )),
    );
  }

  Widget getWebLayout(double width,  double height,
      BuildContext context) {

    final isDark =
        Theme.of(context).brightness == Brightness.dark ? true : false;

    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 50, 10, 50),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '文章目录:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),

                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(5, 10, 6, 10),
                              child: Text(
                                bean.title,
                                style: TextStyle(
                                    color: isDark ? Colors.grey:Colors.green,
                                    fontSize: 14,
                                    fontFamily: 'huawen_kt'),
                              ),
                            ),
                            onTap: () {
                              loadArticle(bean.id);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: getBodyCard(bean, height, width, context),
              flex: 3,
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 50, left: 20),
                    child: IconButton(
                      icon: Transform.rotate(
                        child: Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        angle: pi,
                      ),
                      onPressed: () {
                        if (controller.isAttached) controller.jumpTo(index: 0);
                      },
                    ),
                  ),
                  Expanded(
                    child: buildTocListWidget(),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 50, left: 20),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      onPressed: () {
                        if (controller.isAttached)
                          controller.jumpTo(index: controller.endIndex);
                      },
                    ),
                  ),
                ],
              ),
            )),
          ],
        ));
  }

  TocListWidget buildTocListWidget({double fontSize = 12.0}) {
    return TocListWidget(
      controller: controller,
      tocItem: (toc, isCurrent) {
        return TocItemWidget(
          isCurrent: isCurrent,
          toc: toc,
          fontSize: fontSize,
          onTap: () {
            controller.jumpTo(index: toc.index);
          },
        );
      },
    );
  }

  Widget getMobileLayout(double width, double height, ArticleItem bean) {
    return Container(
      width: width,
      padding: EdgeInsets.only(left: 4, right: 4),
      child: getMarkdownBody(height, width, context),
    );
  }

  Widget getBodyCard(
      ArticleItem bean, double height, double width, BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.all(20),
        child: getMarkdownBody(height, width, context),
      ),
    );
  }

  Widget getMarkdownBody(double height, double width, BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark ? true : false;

    return MarkdownWidget(
      data: markdownData,
      controller: controller,
      loadingWidget: Container(),
      styleConfig: StyleConfig(
          pConfig: PConfig(
            onLinkTap: (url) => launchURL(url),
            selectable: false
          ),
          titleConfig: TitleConfig(
            showDivider: false,
            commonStyle: TextStyle(color: Theme.of(context).textSelectionColor),
          ),
          imgBuilder: (url, attr) {
            double w;
            double h;
            if (attr['width'] != null) w = double.parse(attr['width']);
            if (attr['height'] != null) h = double.parse(attr['height']);
            return GestureDetector(
              onTap: () => launchURL(url),
              child: Card(
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/img/loading.gif',
                  placeholderScale: 0.5,
                  image: url ?? '',
                  height: h,
                  width: w,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          preConfig: PreConfig(preWrapper: (child, text) {
            return Stack(
              children: <Widget>[
                child,
                Container(
                  margin: EdgeInsets.only(top: 5, right: 5),
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: text));
                      Widget toastWidget = Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 50),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xff006EDF), width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(
                              4,
                            )),
                            color: Color(0xff007FFF)
                          ),
                          width: 100,
                          height: 30,
                          child: Center(
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                '复制成功',
                                style: TextStyle(fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                      ToastWidget().showToast(context, toastWidget, 1);
                    },
                    icon: Icon(Icons.content_copy, size: 10,),
                  ),
                )
              ],
            );
          }, language: 'dart'),
          markdownTheme:
              isDark ? MarkdownTheme.darkTheme : MarkdownTheme.lightTheme),
    );
  }

  void refresh() {
    if (mounted) setState(() {});
  }
}


