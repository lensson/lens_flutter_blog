import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lens_flutter_blog/config/assets.dart';
import 'package:lens_flutter_blog/json/friend_link.dart';
import '../config/url_launcher.dart';


class FriendLinkItem extends StatelessWidget {

  const FriendLinkItem({Key key, @required this.bean}) : super(key: key);

  final FriendLink bean;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 380,
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 50),
            child: Card(
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                width: 250,
                height: 250,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll) {
                      overScroll.disallowGlow();
                      return true;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child: Text(
                            bean.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'huawen_kt',
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.all(10),

                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Text(bean.description,
                                    style: TextStyle(
                                      fontFamily: Assets.HuawenKt,
                                      fontSize: (Random().nextInt(10) + 15)
                                          .toDouble(),
                                      color: Colors.primaries[Random()
                                          .nextInt(
                                          Colors.primaries.length)],
                                    )),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () => launchURL(bean.logo),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    image: DecorationImage(
                      image: NetworkImage(bean.logo),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 300),
              child: FlatButton(
                color:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                child: Text(
                  "进入博客",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: Assets.HuawenKt,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () => launchURL(bean.href),
              ),
            ),
          )
        ],
      ),
    );
  }
}
