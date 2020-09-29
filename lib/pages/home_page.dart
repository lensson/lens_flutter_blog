import 'package:flutter/material.dart';
import 'package:lens_flutter_blog/apis/postAPI.dart';

import 'package:lens_flutter_blog/config/platform_type.dart';
import 'package:lens_flutter_blog/json/article_item_bean.dart';
import 'package:lens_flutter_blog/logic/home_page_logic.dart';
import 'package:lens_flutter_blog/json/category.dart';
import 'package:lens_flutter_blog/notifier/selected_articles_item_list.dart';
import 'package:lens_flutter_blog/widgets/article_items_mobile.dart';
import 'package:lens_flutter_blog/widgets/article_items_pc.dart';
import 'package:lens_flutter_blog/widgets/left_bar.dart';
import 'package:lens_flutter_blog/widgets/module.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final logic = HomePageLogic();
  ArticleType type = ArticleType.study;

//  List<ArticleItemBean> showDataList = [];
  Map<ArticleType, List<ArticleItemBean>> dataMap = Map();
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  List<Category> categoryList = [];



  @override
  void initState() {

    PostAPI.getArticleItemList(
      context: context,
    ).then((value){
      if(value!=null) {
        Provider.of<SelectedArticleItemList>(context).setItemList(value.models);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final fontSizeByHeight = height * 30 / 1200;
    final detector = PlatformType();
    final isNotMobile = !detector.isMobile();

    return CommonLayout(
      globalKey: globalKey,
      drawer: LeftBar(height),
      child: Container(
        child: isNotMobile
            ? getPcGrid(size, fontSizeByHeight, context)
            : getMobileList(),
      ),
    );
  }

  Row getPcGrid(Size size, double fontSizeByHeight,
      BuildContext context) {
    double width = size.width;
    double height = size.height;

    return Row(
      children: <Widget>[
        LeftBar(height),
        Consumer<SelectedArticleItemList>(
          builder: (context,sc,child){
            return new PCArticleItems(size);
          },
        ),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }

  Widget getMobileList() {
      return Consumer<SelectedArticleItemList>(
        builder: (context,sc,child){
          return new MobileArticleItems();
        },
      );
  }

  double getScaleSizeByWidth(double width, double size) {
    return size * width / 1600;
  }

  double getScaleSizeByHeight(double height, double size) {
    return size * height / 1200;
  }
}

enum ArticleType { life, study, topic }
