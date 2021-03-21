import 'package:flutter/material.dart';
import 'package:my_app/style/common.dart';
import 'package:my_app/utils/bundle.dart';
import 'package:my_app/widget/layout/page_view.dart';

class Home extends StatefulWidget {
  Home({
    Key key,
    this.bundle,
  }): super(key: key);
  final Bundle bundle;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MyPage(
      enableAppBar: false,
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 2000), () {});
      },
      child: Container(
        height: setWidth(1000),
        child: Center(
          child: Text('this is home page'),
        ),
      )
    );
  }
}
