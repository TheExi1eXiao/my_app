import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/style/imgs.dart';
import 'package:my_app/view/home/index.dart';
import 'package:my_app/view/mine/index.dart';
import 'package:my_app/widget/layout/splash_screen.dart';
import 'package:my_app/widget/tabbar/tabbar.dart';

final GlobalKey<GSYTabBarState> entryIndexKey = GlobalKey<GSYTabBarState>();

class EntryIndex extends StatefulWidget {
  EntryIndex({Key key}) : super(key: key);

  _EntryIndexState createState() => _EntryIndexState();
}

class _EntryIndexState extends State<EntryIndex>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    getData();
  }

  bool showSplash = true;
  bool loading = true;

  @override
  bool get wantKeepAlive => true;

  getData() {
    setState(() {
      loading = false;
      showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ScreenUtil.instance =
        ScreenUtil(width: 375, height: 667, allowFontScaling: false)
          ..init(context);
    List<dynamic> tabs = [
      {"icon": IMGs.Home, "iconSel": IMGs.Home_sel, "text": "主页"},
      {"icon": IMGs.Mine, "iconSel": IMGs.Mine_sel, "text": "我的"},
    ];

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        overflow: Overflow.visible,
        fit: StackFit.expand,
        children: <Widget>[
          !loading
              ? GSYTabBarWidget(
                  type: GSYTabBarWidget.BOTTOM_TAB,
                  key: entryIndexKey,
                  tabItems: tabs,
                  tabViews: [Home(), Mine()],
                )
              : SizedBox(),
          Positioned(
            child: AnimatedSwitcher(
              transitionBuilder: (child, anim) {
                return FadeTransition(child: child, opacity: anim);
              },
              duration: Duration(milliseconds: 300),
              child: showSplash ? SplashScreen() : SizedBox(),
            ),
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
          )
        ],
      ),
    );
  }
}
