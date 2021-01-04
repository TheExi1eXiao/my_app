import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/style/common.dart';
import 'package:my_app/utils/tools.dart';
import 'package:my_app/widget/tab/my_tab.dart';
import 'package:preload_page_view/preload_page_view.dart';

class TabPage extends StatefulWidget {
  TabPage({
    Key key,
    this.height = 45,
    this.tabBarViewList,
    this.initialIndex = 0,
    this.showBorder = true,
    this.preload = 0,
    this.tabTitle = const [],
    this.onPageChanged,
    this.tabLength,
    this.centerWidget,
    this.contentHeight,
    this.tabBuilder
  }): super(key: key);

  List<dynamic> tabTitle;
  List<Widget> tabBarViewList;
  num height;
  num contentHeight;
  num initialIndex;
  num tabLength;
  bool showBorder;
  Widget centerWidget;
  num preload;
  Widget Function(
    TabController,
    List<dynamic>,
  ) tabBuilder;
  Function(num) onPageChanged;
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {
  TabController mController;
  PreloadPageController preloadPageController;
  num _tabLength;
  bool first = true;
  bool notOnChange = false;

  num currentIndex = 0;
  void initState() {
    super.initState();
    _tabLength = widget.tabLength ?? widget.tabTitle.length;
    setState(() {
      currentIndex = widget.initialIndex;
    });
    preloadPageController =
      PreloadPageController(initialPage: widget.initialIndex);

    mController = TabController(
      length: _tabLength, vsync: this, initialIndex: widget.initialIndex
    );
    mController.addListener(tabListener);
  }

  @override
  void dispose() {
    timer?.cancel();
    mController?.removeListener(tabListener);
    mController?.dispose();
    preloadPageController?.dispose();
    super.dispose();
  }

  tabListener() async {
    if (mController.index != currentIndex) {
      if (widget.onPageChanged != null) {
        widget.onPageChanged(mController.index);
      }
      // print(mController.index);
      // print();
      // preloadPageController.jumpToPage(mController.index);
      setState(() {
        currentIndex = mController.index;
        notOnChange = true;
      });
      preloadPageController.animateToPage(
        mController.index,
        duration: Duration(milliseconds: 200), 
        curve: Curves.easeInOutCubic
      );
      await delayHandler(200);
      setState(() {
        notOnChange = false;
      });
    }
  }

  Timer timer;

  ///预加载Tab
  preLoadTab() {
    if (widget.preload != 0 && first) {
      timer = new Timer(new Duration(milliseconds: 50), () async {
        if (widget.preload == double.infinity) {
          for (var i = 1; i < mController.length + 1; i++) {
            if (i == mController.length) {
              await Future.delayed(Duration(milliseconds: 500), () {});
              print(widget.initialIndex);
              mController.animateTo(
                widget.initialIndex,
                duration: Duration(milliseconds: 1), 
                curve: null
              );
            } else {
              await Future.delayed(Duration(milliseconds: 150), () {});
              print(i);
              mController.animateTo(
                i,
                duration: Duration(milliseconds: 1), 
                curve: null
              );
            }
          }
          first = false;
        } else {
          num minPre = widget.initialIndex - widget.preload;
          num maxPre =
            widget.initialIndex + widget.preload + 1 >= mController.length
              ? mController.length
              : widget.initialIndex + widget.preload + 1;
          for (var i = minPre <= 0 ? 0 : minPre; i < maxPre + 1; i++) {
            if (i == maxPre) {
              await Future.delayed(Duration(milliseconds: 300), () {});
              print(widget.initialIndex);
              mController.animateTo(
                widget.initialIndex,
                duration: Duration(milliseconds: 1), 
                curve: null
              );
            } else {
              await Future.delayed(Duration(milliseconds: 100), () {});
              print(i);
              mController.animateTo(
                i,
                duration: Duration(milliseconds: 1), 
                curve: null
              );
            }
          }
        }
      });
    }
  }

  onPageChanged(index) {
    if (!notOnChange && index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
      if (widget.onPageChanged != null) {
        widget.onPageChanged(index);
      }
      mController.animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    //默认tabBuilder
    if (widget.tabBuilder == null) {
      widget.tabBuilder = (
        mController,
        tabTitle,
      ) {
        return MyTab(mController: mController, tabTitle: tabTitle);
      };
    }
    if (widget.centerWidget == null) {
      widget.centerWidget = Container();
    }
    // preLoadTab();
    return Column(
      children: <Widget>[
        Container(
          height: setWidth(widget.height),
          decoration: widget.showBorder
            ? new BoxDecoration(border: MyBorder.bottom, color: white)
            : null,
          child: widget.tabBuilder(mController, widget.tabTitle),
        ),
        widget.centerWidget,
        widget.contentHeight != null
          ? Container(
              height: setWidth(widget.contentHeight),
              child: PreloadPageView.builder(
                preloadPagesCount: widget.preload == double.infinity
                  ? widget.tabBarViewList.length
                  : widget.preload,
                itemCount: widget.tabBarViewList.length,
                controller: preloadPageController,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return TabContent(
                    key: Key(index.toString()),
                    child: widget.tabBarViewList[index],
                  );
                },
              )
            )
          : Expanded(
              child: PreloadPageView.builder(
                preloadPagesCount: widget.preload == double.infinity
                  ? widget.tabBarViewList.length
                  : widget.preload,
                itemCount: widget.tabBarViewList.length,
                controller: preloadPageController,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return TabContent(
                    key: Key(index.toString()),
                    child: widget.tabBarViewList[index],
                  );
                },
              )
            )
      ],
    );
  }
}

class TabContent extends StatefulWidget {
  TabContent({Key key, this.child}) : super(key: key);
  Widget child;

  @override
  _TabContentState createState() => _TabContentState();
}

class _TabContentState extends State<TabContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
