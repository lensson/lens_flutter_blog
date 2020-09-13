import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';


import 'package:lens_flutter_blog/config/base_config.dart';
import 'package:lens_flutter_blog/json/archive_item_bean.dart';
import 'package:lens_flutter_blog/widgets/common_layout.dart';
import 'package:lens_flutter_blog/widgets/web_bar.dart';


class TagPage extends StatefulWidget {
  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  List<ArchiveItemBean> beans = [];

  @override
  void initState() {
    ArchiveItemBean.loadAsset('config_tag').then((data) {
      beans.addAll(data);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isNotMobile = !PlatformType().isMobile();

    return CommonLayout(
      pageType: PageType.tag,
      child: Container(
        margin: isNotMobile
            ? EdgeInsets.only(top: 80, left: width / 10, right: width / 10)
            : const EdgeInsets.all(20),
        child: Card(
          child: beans.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  alignment: Alignment.center,
                  height: isNotMobile ? height / 2 : height,
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: List.generate(beans.length, (index) {
                        final bean = beans[index];
                        return FlatButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, archivePage,
                                arguments: [bean]);
                          },
                          child: Text(
                            bean.tag,
                            style: TextStyle(
                              fontSize: (Random().nextInt(40) + 20).toDouble(),
                              fontFamily: 'huawen_kt',
                              color: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
