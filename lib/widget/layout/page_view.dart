import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_app/style/common.dart';
import 'package:my_app/utils/navigator_util.dart';
import 'package:my_app/widget/layout/football_header.dart';
import 'package:my_app/widget/layout/page_loading.dart';
import 'package:my_app/widget/layout/status_bar.dart';

_backBefore() {}

class MyPage extends StatelessWidget {
  MyPage({
    Key key,
    @required this.child,
    this.title,
    this.right,
    this.backgroundColor = const Color(0xfff1f1f1),
    this.loading = false,
    this.enableAppBar = true,
    this.showBack = true,
    this.backInit = false,
    this.floatingActionButton,
    this.customAppBar,
    this.drawerKey,
    this.contentKey,
    this.endDrawer,
    this.backBefore = _backBefore,
    this.onRefresh,
    this.showNativeHeader = false,
  }): super(key: key);

  ///页面内容
  Widget child;

  ///页面标题
  String title;

  ///导航栏右侧内容
  Widget right;

  ///自制顶部导航栏
  Widget customAppBar;

  ///抽屉
  Widget endDrawer;

  //抽屉Key
  GlobalKey drawerKey;

  //页面主体Key
  GlobalKey contentKey;

  ///浮动按钮
  Widget floatingActionButton;

  ///加载状态
  bool loading;

  ///显示返回按钮
  bool showBack;

  ///启用顶部导航栏
  bool enableAppBar;

  ///后退传参（用于前一个页面判断是否更新数据）
  bool backInit;

  ///背景色
  Color backgroundColor;

  ///后退之前
  void Function() backBefore;

  ///刷新页面
  Future Function() onRefresh;

  ///启用原始刷新头部
  bool showNativeHeader;

  ///后退逻辑
  void Function(BuildContext, bool) goBack =
      (BuildContext context, isInit) => {$Router.back(context, init: isInit)};

  @override
  Widget build(BuildContext context) {
    return Material(
      // onWillPop: () {
      //   if (showBack) {
      //     goBack(context, backInit);
      //   } else {
      //     return Future.value(false);
      //   }
      // },
      child: GestureDetector(
        //增加一个点击事件，使得点击APP空白处收起软键盘
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
            // key: scaffoldKey,
            floatingActionButton: !loading ? floatingActionButton : null,
            backgroundColor: backgroundColor,
            extendBody: true,
            endDrawer: endDrawer,
            drawerEdgeDragWidth: 0,
            body: PageViewContent(
              child: child,
              key: contentKey,
              loading: loading,
              enableAppBar: enableAppBar,
              onRefresh: onRefresh,
              showNativeHeader: showNativeHeader,
            ),
            appBar: enableAppBar
                ? customAppBar == null
                    ? PreferredSize(
                        // preferredSize: Size(setWidth(375), setWidth(44)),
                        preferredSize: Size(setWidth(375), setWidth(56)),
                        child: new AppBar(
                          actions: <Widget>[
                            new Container(
                              child: right,
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(right: setWidth(15)),
                            )
                          ],
                          centerTitle: true,
                          backgroundColor: meetColor,
                          leading: showBack
                              ? InkWell(
                                  onTap: () => {goBack(context, backInit)},
                                  child: new Icon(
                                    Entypo.chevron_thin_left,
                                    color: white,
                                    size: 20,
                                  ),
                                )
                              : Container(),
                          title: new Text(
                            title,
                            style: TextStyle(
                              color: white,
                              fontSize: setFz(16),
                              fontWeight: FontWeight.w500
                            ),
                          ), //设置标题
                          elevation: 6.0, //设置阴影辐射范围
                        ),
                      )
                    : customAppBar
                : null),
      ),
    );
  }
}

class PageViewContent extends StatefulWidget {
  PageViewContent({
    Key key,
    this.child,
    this.loading,
    this.enableAppBar,
    this.onRefresh,
    this.showNativeHeader,
  }) : super(key: key);

  ///页面内容
  Widget child;

  ///加载状态
  bool loading;

  ///启用顶部导航拦
  bool enableAppBar;

  ///刷新页面
  Future Function() onRefresh;

  ///启用原始刷新头部
  bool showNativeHeader;

  @override
  PageViewContentState createState() => PageViewContentState();
}

class PageViewContentState extends State<PageViewContent> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: fz(),
      child: Stack(
        fit: StackFit.expand,
        children: widget.enableAppBar
          ? <Widget>[
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: widget.child
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: AnimatedSwitcher(
                  transitionBuilder: (child, anim) {
                    return FadeTransition(child: child, opacity: anim);
                  },
                  duration: Duration(milliseconds: 300),
                  child: widget.loading ? new PageLoading() : Container(),
                ),
              )
            ]
          : [
              EasyRefresh(
                onRefresh: () async {
                  await widget.onRefresh();
                },
                header: widget.showNativeHeader
                  ? MaterialHeader()
                  : FootBallFlyHeader(),
                footer: BezierBounceFooter(),
                child: widget.child,
              ),
              StatusBarGray(),
            ],
      )
    );
  }
}
