
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/style/common.dart';

///支持顶部和顶部的TabBar控件
///配合AutomaticKeepAliveClientMixin可以keep住
class GSYTabBarWidget extends StatefulWidget {
  ///底部模式type
  static const int BOTTOM_TAB = 1;

  ///顶部模式type
  static const int TOP_TAB = 2;

  final int type;

  final bool resizeToAvoidBottomPadding;

  final List<dynamic> tabItems;

  final List<Widget> tabViews;

  final Color backgroundColor;

  final Color indicatorColor;

  final Widget title;

  final Widget drawer;

  final Widget floatingActionButton;

  final FloatingActionButtonLocation floatingActionButtonLocation;

  final Widget bottomBar;

  final TarWidgetControl tarWidgetControl;

  final ValueChanged<int> onPageChanged;

  GSYTabBarWidget({
    Key key,
    this.type,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.drawer,
    this.bottomBar,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.resizeToAvoidBottomPadding = true,
    this.tarWidgetControl,
    this.onPageChanged,
  }): super(key: key);

  @override
  GSYTabBarState createState() => GSYTabBarState(
    type,
    tabViews,
    indicatorColor,
    drawer,
    floatingActionButton,
    tarWidgetControl,
    onPageChanged,
  );
}

class GSYTabBarState extends State<GSYTabBarWidget>
    with SingleTickerProviderStateMixin {
  final int _type;

  final List<Widget> _tabViews;

  final Color _indicatorColor;

  List<Widget> tabList;

  List<BottomNavigationBarItem> bottomTabList;

  final Widget _drawer;

  int currentIndex = 0;

  final Widget _floatingActionButton;

  final TarWidgetControl _tarWidgetControl;

  PageController pageController = PageController(
    // viewportFraction: 0.99,
    initialPage: 0,
  );

  final ValueChanged<int> _onPageChanged;

  goPage(num key) async {
    pageController.jumpToPage(key);
  }

  _renderBottomBar(List arr) {
    List res = [];
    for (var i in arr) {
      res.add(
        BottomNavigationBarItem(
          icon: Image.asset(
            i["icon"],
            width: setWidth(28),
            height: setWidth(28),
          ),
          activeIcon: Image.asset(
            i["iconSel"],
            width: setWidth(28),
            height: setWidth(28),
          ),
          label: i["text"],
        ),
      );
    }
    setState(() {
      bottomTabList = [...res];
    });
  }

  _renderTab(icon, iconSel, text, color, colorSel, index) {
    return Container(
      color: white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            transitionBuilder: (child, anim) {
              return ScaleTransition(child: child, scale: anim);
            },
            duration: const Duration(milliseconds: 150),
            child: index == currentIndex
              ? Image.asset(
                  iconSel,
                  key: Key(iconSel),
                  width: setWidth(28),
                  height: setWidth(28),
                )
              : Image.asset(
                  icon,
                  key: Key(icon),
                  width: setWidth(28),
                  height: setWidth(28),
                ),
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            child: Text(
              text,
            ),
            style: TextStyle(
              color: index == currentIndex ? colorSel : color,
              fontSize: index == currentIndex ? setFz(12) : setFz(11)
            ),
          ),
        ],
      ),
    );
  }

  GSYTabBarState(
    this._type,
    this._tabViews,
    this._indicatorColor,
    this._drawer,
    this._floatingActionButton,
    this._tarWidgetControl,
    this._onPageChanged,
  ): super();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _renderBottomBar(widget.tabItems);
    // _renderTabArr(widget.tabItems);
    _tabController =
        TabController(vsync: this, length: widget.tabItems.length);
  }

  ///整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///底部tab bar
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: PageView(
          controller: pageController,
          dragStartBehavior: DragStartBehavior.down,
          children: _tabViews,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            // _tabController.animateTo(index);
            setState(() {
              currentIndex = index;
            });
            _onPageChanged?.call(index);
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Card(
              margin: EdgeInsets.all(0),
              borderOnForeground: false,
              elevation: 6.0,
              child: Container(
                height: setWidth(50),
                width: double.infinity,
                color: white,
                child: TabBar(
                  //TabBar导航标签，底部导航放到Scaffold的bottomNavigationBar中
                  controller: _tabController, //配置控制器
                  tabs: [
                    for (var i in widget.tabItems)
                      _renderTab(
                        i["icon"],
                        i["iconSel"],
                        i["text"],
                        Color(0xff999999),
                        mainColor,
                        widget.tabItems.indexOf(i)
                      )
                  ],
                  indicatorWeight: 0.0001,
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                    _onPageChanged?.call(index);
                    goPage(index);
                  }, //tab标签的下划线颜色
                ),
              ),
            ),
        )
      ),
    );
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}
