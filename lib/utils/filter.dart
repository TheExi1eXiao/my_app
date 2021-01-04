import 'package:flutter_daydart/flutter_daydart.dart';
import 'package:simple_moment/simple_moment.dart';

///
/// @param {日期} value
/// @return  
String dayInt2String(int value) {
  switch (value) {
    case 1:
      return "星期一";
    case 2:
      return "星期二";
    case 3:
      return "星期三";
    case 4:
      return "星期四";
    case 5:
      return "星期五";
    case 6:
      return "星期六";
    case 7:
      return "星期日";

    default:
      return "星期一";
  }
}

///
/// @param {日期} value
/// @return  MM-DD HH:mm格式时间
String time2MMDDHHmm(value) {
  // var time =Moment.parse(value).format()
  var time = DayDart.fromString(value).format(fm: 'MM-DD HH:mm');
  return time;
}

///
/// @param {日期} value
/// @return  距离现在的时间
String beforeTime(value) {
  var date = Moment.parse(value);
  // var now = DayDart();
  // var mill = now.millisecond()-date.millisecond();
  return date.fromNow(true);
}

///
/// @param {日期} value
/// @return  HH:mm格式时间
String time2HHmm(value) {
  // let date = new Date(value.replace(/-/g, "/"));
  var time = DayDart.fromString(value).format(fm: 'HH:mm');

  return time;
}

///
/// @param {日期} value
/// @return  MM/DD格式时间
String time2MMDD(value) {
  var time = DayDart.fromString(value).format(fm: 'MM/DD');
  return time;
}

///
/// @param {数字} value
/// @return  只显示后四位的数字
String hideNumber(values) {
  String str;
  String value = values.toString();
  if (value != null) {
    var length = value.length - 4;
    // var str1 = value.substring(0, length-1);

    var code = '';
    for (var i = 0; i < length; i++) {
      code += '*';
    }
    str = code + value.substring(value.length - 4);
    // let str = value.replace(str1,"*")
  } else {
    str = "";
  }
  return str;
}

///
/// @param {数字} value
/// @return  数值过万处理

String million(values) {
  num value = num.tryParse(values);
  String number;
  if (value > 9999) {
    //大于9999显示x.xx万
    number = ((value / 1000).floor() / 10).toString() + '万';
  } else if (value < 9999 && value > -9999) {
    number = value.toString();
  } else if (value < -9999) {
    //小于-9999显示-x.xx万
    number = (-(((value).abs() / 1000) / 10).floor()).toString() + '万';
  }
  return number;
}

///
/// @param {数字} value
/// @return  数值过99处理

num hundred(values) {
  num value = num.parse(values) >= 99 ? 99 : num.parse(values);
  return value;
}
