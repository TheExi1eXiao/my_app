import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 项目主颜色
const Color meetColor = Color(0xFFE53439);

/// 灰色9
const Color grey9 = Color(0xFF999999);

/// 灰色6
const Color grey6 = Color(0xFF666666);

/// 黑色3 主字体颜色
const Color normalTextColor = Color(0xFF333333);

/// 白色
const Color white = Color(0xFFFFFFFF);

/// 蓝色
const Color blue = Color(0xFF508cee);

/// 根据屏幕设置长度
num setWidth(num value) {
  if (value == null) return null;

  if (value < 0) {
    num _value = -value;

    return -ScreenUtil().setWidth(_value);
  } else {
    return ScreenUtil().setWidth(value);
  }
}

/// 根据屏幕设置字体
num setFz(num value) {
  final _size = ScreenUtil().setSp(value);
  return _size;
}

/// 屏幕宽度
num maxWidth = MediaQueryData.fromWindow(window).size.width;

/// 屏幕高度
num maxHeight = MediaQueryData.fromWindow(window).size.height;

/// 状态栏高度
final statusBarHeight = MediaQueryData.fromWindow(window).padding.top;

/// 快捷设置边框
class MyBorder {
  static final Color borderColor = Color(0xffebedf0);

  static final BoxBorder horizontal = new Border(
      left: BorderSide(color: borderColor),
      right: BorderSide(color: borderColor));
  static final BoxBorder vertical = new Border(
      bottom: BorderSide(color: borderColor),
      top: BorderSide(color: borderColor));
  static final BoxBorder right =
      new Border(right: BorderSide(color: borderColor));
  static final BoxBorder bottom =
      new Border(bottom: BorderSide(color: borderColor));
  static final BoxBorder top = new Border(top: BorderSide(color: borderColor));
  static final BoxBorder left =
      new Border(left: BorderSide(color: borderColor));
  static final BoxBorder all = new Border.all(color: borderColor);
}

/// 快捷设置文字样式
TextStyle fz(
    {double fontSize = 14, color = normalTextColor, double lineHeight}) {
  var style = TextStyle(
    fontSize: setFz(fontSize),
    color: color,
    height: lineHeight,
  );
  return style;
}

/// 16进制转颜色对象
Color hexToColor(String s) {
  // 如果传入的十六进制颜色值不符合要求，返回默认值
  if (s == null ||
      s.length != 7 ||
      int.tryParse(s.substring(1, 7), radix: 16) == null) {
    s = '#999999';
  }

  return new Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
}
