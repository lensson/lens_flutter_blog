import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lens_flutter_blog/notifier/selected_articles_item_list.dart';
import 'package:lens_flutter_blog/notifier/selected_category.dart';
import 'package:provider/provider.dart';

import 'config/app_routers.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>SelectedCategory()),
        ChangeNotifierProvider(create: (context)=>SelectedArticleItemList()),
      ],
      child: ModularApp(
        module: AppModule(),
      ),
    ),
  );
}
