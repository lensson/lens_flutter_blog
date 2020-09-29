import 'package:flutter/cupertino.dart';
import 'package:lens_flutter_blog/apis/categoryAPI.dart';
import 'package:lens_flutter_blog/apis/postAPI.dart';
import 'package:lens_flutter_blog/json/category.dart';
import 'package:lens_flutter_blog/json/post.dart';
import 'package:lens_flutter_blog/notifier/selected_articles_item_list.dart';
import 'package:provider/provider.dart';

/**
 * @program: lens_flutter_blog
 *
 * @description:
 *
 * @author: Lens Chen
 *
 * @create: 2020-09-15 09:36
 **/

class SelectedCategory extends ChangeNotifier{

  Category selectMode;

  static SelectedCategory All;
  static getDefaultCategory(){
    if(All == null){
      All = new SelectedCategory();
      All.setSelected(new Category(id:0,name: "All"));
    }
    return All;
  }

  get selected => this.selectMode;

  setSelected(Category selected){
    this.selectMode = selected;
    notifyListeners();
  }


//  Map<Category, List> categoryArticleMap = new Map<Category,List>();

//  SelectedCategory(this.selectMode){
//    this.notifyListeners();
//  }electedCategory(this.selectMode){
//    this.notifyListeners();
//  }

//  SelectedCategory(){
//    CategoryAPI.getCategoryList(
//
//    ).then((value){
//      List<Category>categoryList = value.models;
//      categoryList.sort((a,b){
//        if(a.id<b.id)
//          return -1;
//        return 1;
//      });
//      categoryList.map((e) {
//        categoryArticleMap.putIfAbsent(e, ()=>new List());
//      });
//    });
//    this.notifyListeners();
//  }




//  void setSelected(Category select){
//    this.selectMode = select;
//
//    PostListRequestEntity entity = new PostListRequestEntity();
//
//    entity.categoryId = this.selectMode.id;
//    entity.categoryName = this.selectMode.name;
//
//    PostAPI.getArticleItemList(
//      params: entity,
//    ).then((value) {
//      List<ArticleItem> itemList = value.models;
//
//      if(itemList!=null){
//        categoryArticleMap.putIfAbsent(selectMode, () => itemList);
//
//        this.notifyListeners();
//      }
//
//    });
//  }


}