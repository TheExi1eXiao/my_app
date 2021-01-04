import 'package:flutter/material.dart';
import 'package:my_app/style/common.dart';
import 'package:my_app/style/imgs.dart';

class MyEmpty extends StatelessWidget {
  MyEmpty({
    Key key, this.text = "这里空空如也"
  }): super(key: key);
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            IMGs.NO_DATA,
            width: setWidth(100),
            height: setWidth(100),
          ),
          Text(
            text,
            style: fz(color: grey9),
            textAlign: TextAlign.center,
          ),
        ],
      )
    );
  }
}
