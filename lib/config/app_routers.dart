import 'package:flutter/material.dart' hide Router;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lens_flutter_blog/pages/friend_link_page.dart';

import 'package:lens_flutter_blog/pages/module.dart';
import 'base_config.dart';



class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(homePage, child: (_, args) => HomePage()),
    ModularRouter(tagPage, child: (_, args) => TagPage()),
    ModularRouter(archivePage, child: (_, args) => ArchivePage()),
    ModularRouter(linkPage, child: (_, args) => FriendLinkPage()),
    ModularRouter(aboutPage, child: (_, args) => AboutPage()),
    ModularRouter("$articlePage/:name",
        child: (_, args) => ArticlePage(
          id: args.params['id'],
          articleData: args.data,
        )),
      ];

  @override
  Widget get bootstrap => MyApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int curHour = DateTime.now().hour;
    return MaterialApp(
      title: 'Mala blog',
      theme: ThemeData(
        brightness:
            (curHour > 18 || curHour < 7) ? Brightness.dark : Brightness.light,
      ),

      // modular route
      initialRoute: homePage,
      onGenerateRoute: Modular.generateRoute,
      navigatorKey: Modular.navigatorKey,

      //not debug flag
      debugShowCheckedModeBanner: false,
    );
  }
}

void goHome(context){
  Navigator.pushNamed(context, homePage);
}
