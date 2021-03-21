import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/style/common.dart';

Widget myDoubleButton({
  padding,
  gravity,
  height,
  isClickAutoDismiss = true, //点击按钮后自动关闭
  withDivider = false, //中间分割线
  text1,
  color1,
  fontSize1,
  fontWeight1,
  fontFamily1,
  VoidCallback onTap1,
  text2,
  color2,
  fontSize2,
  yyDialog,
  fontWeight2,
  fontFamily2,
  onTap2,
}) {
  return SizedBox(
    height: height ?? setWidth(45),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: FlatButton(
            onPressed: () {
              if (onTap1 != null) onTap1();
            },
            padding: EdgeInsets.all(0.0),
            child: Text(
              text1 ?? "",
              style: TextStyle(
                color: color1 ?? null,
                fontSize: fontSize1 ?? null,
                fontWeight: fontWeight1,
                fontFamily: fontFamily1,
              ),
            ),
          ),
        ),
        Visibility(
          visible: withDivider,
          child: VerticalDivider(),
        ),
        Expanded(
          child: FlatButton(
            onPressed: () {
              if (onTap2 != null) onTap2();
            },
            padding: EdgeInsets.all(0.0),
            child: Text(
              text2 ?? "",
              style: TextStyle(
                color: color2 ?? Colors.black,
                fontSize: fontSize2 ?? 14.0,
                fontWeight: fontWeight2,
                fontFamily: fontFamily2,
              ),
            ),
          ),
        )
      ],
    ),
  );
}