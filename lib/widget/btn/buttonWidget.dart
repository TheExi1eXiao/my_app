import 'package:flutter/material.dart';
import 'package:my_app/style/common.dart';

class MeetBtn extends StatelessWidget {
  MeetBtn({
    Key key,
    this.onPressed,
    this.color = mainColor,
    this.width,
    this.height = 40,
    this.textStyle,
    this.text
  }): super(key: key);

  ///宽度
  num width;

  ///高度
  num height;

  ///背景色
  Color color;

  ///文本
  String text;

  ///文本样式
  TextStyle textStyle;

  void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    textStyle = textStyle ?? fz(color: white, fontSize: 15);
    return Container(
      width: width != null ? setWidth(width) : null,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: MaterialButton(
                color: color,
                disabledColor: grey9,
                padding: EdgeInsets.all(0),
                height: setWidth(height),
                onPressed: () {
                  onPressed?.call();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Text(
                  text,
                  style: textStyle,
                ),
              )
            ),
          )
        ],
      )
    );
  }
}
