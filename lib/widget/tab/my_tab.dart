import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/style/common.dart';

class MyTab extends StatefulWidget {
  MyTab({
    Key key, 
    this.mController, 
    this.tabTitle, 
    this.onClick
  }): super(key: key);

  TabController mController;
  List<String> tabTitle;
  Function(int) onClick;
  @override
  _MyTabState createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: false,
      indicatorWeight: setWidth(3),
      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: setFz(14)),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
      labelPadding: EdgeInsets.symmetric(horizontal: 0),
      //是否可以滚动
      controller: widget.mController,
      labelColor: mainColor,
      indicatorColor: Colors.red,
      indicatorPadding: EdgeInsets.symmetric(
        horizontal: setWidth((375 / widget.tabTitle.length - 15) / 2)
      ),
      unselectedLabelColor: normalTextColor,
      tabs: widget.tabTitle.map((item) {
        return Tab(
          text: item,
        );
      }).toList(),
    );
  }
}
