import 'package:flutter/cupertino.dart';
import 'package:lens_flutter_blog/json/post.dart';

/**
 * @program: lens_flutter_blog
 *
 * @description:
 *
 * @author: Lens Chen
 *
 * @create: 2020-09-21 09:44
 **/
class SelectedArticleItemList extends ChangeNotifier{

  List <ArticleItem> itemList = new List<ArticleItem>();

  get list => this.itemList;

  setItemList(List<ArticleItem> list){
    this.itemList = list;
    notifyListeners();
  }
}