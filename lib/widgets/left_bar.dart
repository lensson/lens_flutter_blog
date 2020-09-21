import 'package:flutter/material.dart';
import 'package:lens_flutter_blog/apis/categoryAPI.dart';
import 'package:lens_flutter_blog/apis/postAPI.dart';
import 'package:lens_flutter_blog/config/assets.dart';
import 'package:lens_flutter_blog/config/platform_type.dart';
import 'package:lens_flutter_blog/json/category.dart';
import 'package:lens_flutter_blog/json/post.dart';
import 'package:lens_flutter_blog/notifier/selected_articles_item_list.dart';
import 'package:lens_flutter_blog/notifier/selected_category.dart';

import 'package:provider/provider.dart';

class LeftBar extends StatefulWidget {

  final double homePageSize;

  LeftBar(this.homePageSize);

  @override
  State<StatefulWidget> createState() {
    return new LeftBarState();
  }
}

class LeftBarState extends State<LeftBar> {

  List<Category> categoryList = [];

  @override
  void initState() {

    CategoryAPI.getCategoryList(context: this.context).then((value){
      this.categoryList = value.models;
      this.categoryList.sort((a,b){
        if(a.id<b.id)
          return -1;
        return 1;
      });

      Category sc = categoryList[0];
      if(categoryList!=null && categoryList.length>0) {
        Provider.of<SelectedCategory>(context).setSelected(sc);

        getArticleItemListByCategory(sc);
      }

      this.refresh();
    });

    super.initState();
  }

  void getArticleItemListByCategory(Category sc){

    PostListRequestEntity entity;
    if(sc!=null) {
      entity = new PostListRequestEntity();
      entity.categoryId = sc.id;
      entity.categoryName = sc.name;
    }

    PostAPI.getArticleItemList(
      context: context,
      params: entity!=null?entity:null,
      cacheDisk: false,
      refresh: true,

    ).then((value){
      if(value!=null) {
        Provider.of<SelectedArticleItemList>(context).setItemList(value.models);
      }
    });
  }


  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {


    final detector = PlatformType();
    final isNotMobile = !detector.isMobile();
    final height = widget.homePageSize;
    final fontSizeByHeight = height * 30 / 1200;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,


      children: <Widget>[
        Text(
          "Mala\nBlog",
          style: TextStyle(
            fontSize: getScaleSizeByHeight(height, 90.0),
            fontFamily: Assets.MontserratBold,
          ),
        ),
        SizedBox(
          height: getScaleSizeByHeight(height, 40.0),
        ),

        this.getCategoryContainer(height, fontSizeByHeight),

        if (isNotMobile)
          Container()
        else
          SizedBox(
            height: getScaleSizeByHeight(height, 40.0),
          ),
      ],
    );
  }

  Widget getCategoryContainer(height,fontSizeByHeight){
    if(this.categoryList==null || this.categoryList.length==0){
      return Container();
    }
//    final selectedCategory = Provider.of<SelectedCategory>(context);

//    selectedCategory.setSelected(categoryList[0].id,categoryList[0].name);

    return Consumer<SelectedCategory>(
        builder: (context,sc,child){
          return Container(
            child: Column(
              children: List.generate(this.categoryList.length, (index){
                return Container(
                  child: Column(
                    children: [
                      getCategoryButton(this.categoryList[index], fontSizeByHeight),
                      getCategorySpacerBox(height),
                    ],
                  ),
                );
              }),
            ),
          );
        }
    );


  }

  Widget getCategorySpacerBox(height){
    return SizedBox(
      height: getScaleSizeByHeight(height, 40.0),
    );
  }

  Widget getCategoryButton(Category category,double fontSizeByHeight){
    int myId = category.id;
    final sc = Provider.of<SelectedCategory>(context);

    return FlatButton(
      onPressed: ()=>handleTap(category),
      child: Text(
        category.name,
        style: TextStyle(
          fontSize: fontSizeByHeight,
          color: myId == sc.selectMode.id ? null : Color(0xff9E9E9E),
          fontFamily: Assets.MontserratBold,
        ),
      ),
    );
  }

  handleTap(Category buttonModel){
    if(getCurrentSelected().selectMode.id == buttonModel.id){
      return;
    }
    getCurrentSelected().setSelected(buttonModel);

    getArticleItemListByCategory(buttonModel);
  }




  SelectedCategory getCurrentSelected(){
    return Provider.of<SelectedCategory>(context);
  }

  double getScaleSizeByWidth(double width, double size) {
    return size * width / 1600;
  }

  double getScaleSizeByHeight(double height, double size) {
    return size * height / 1200;
  }
}