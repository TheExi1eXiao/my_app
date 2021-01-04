import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_app/style/common.dart';
import 'package:my_app/style/imgs.dart';

class AppBarState {
  AppBarState({this.title, this.backInit, this.goBack});
  ///标题
  String title;
  ///后退是否刷新
  bool backInit;
  ///后退
  void Function(BuildContext, bool) goBack;
}

class PageLoading extends StatelessWidget {
  PageLoading({Key key, this.appBarState}): super(key: key);
  AppBarState appBarState;
  @override
  Widget build(BuildContext context) {
    return appBarState == null
      ? Container(
          color: white,
          alignment: Alignment.center,
          // width: double.infinity,
          // height: double.infinity,
          child: new Image.asset(
            IMGs.MeetLoading,
            width: setWidth(82),
            height: setWidth(72),
          ),
        )
      : Column(
          children: <Widget>[
            AppBar(
              centerTitle: true,
              backgroundColor: meetColor,
              leading: InkWell(
                onTap: () => {
                  appBarState.goBack(context, appBarState.backInit)
                },
                child: new Icon(
                  Entypo.chevron_thin_left,
                  color: white,
                  size: 20,
                ),
              ),
              title: new Text(
                appBarState.title,
                style: TextStyle(
                  color: white,
                  fontSize: setFz(16),
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Container(
              color: white,
              alignment: Alignment.center,
              // width: double.infinity,
              // height: double.infinity,
              child: new Image.asset(
                IMGs.MeetLoading,
                width: setWidth(82),
                height: setWidth(72),
              ),
            )
          ],
        );
  }
}
