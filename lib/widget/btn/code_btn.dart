import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/style/common.dart';
import 'package:my_app/utils/toast.dart';
import 'package:my_app/widget/btn/buttonWidget.dart';

class CodeBtn extends StatefulWidget {
  CodeBtn({
    Key key, 
    this.length = 6, 
    @required this.phone, 
    @required this.type
  }): super(key: key);

  ///手机号
  String phone;

  ///请求验证码类型
  num type;

  ///请求验证码长度
  num length;

  @override
  _CodeBtnState createState() => _CodeBtnState();
}

class _CodeBtnState extends State<CodeBtn> {
  bool codeLoading = false;
  num codeTime = 0;
  Timer timer;

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    timer = null;
  }

  ///获取验证码
  getCode() async {
    if (!RegexUtil.isMobileExact(widget.phone)) {
      $toast('请输入正确的手机号');
      return;
    }
    try {
      $toast("发送成功，请注意查收");
      setState(() {
        codeTime = 60;
        setState(() {
          timer = Timer.periodic(Duration(seconds: 1), (timer) {
            //到时回调
            setState(() {
              codeTime--;
            });
            if (codeTime <= 0) {
              //取消定时器，避免无限回调
              setState(() {
                timer.cancel();
                timer = null;
              });
            }
          });
        });
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: setWidth(80),
      height: setWidth(30),
      child: codeTime <= 0
        ? MeetBtn(
            text: "获取验证码",
            height: 30,
            onPressed: () {
              this.getCode();
            },
            color: blue,
            textStyle: fz(fontSize: 12, color: white),
          )
        : MeetBtn(
            text: "$codeTime s后重试",
            height: 30,
            color: blue,
            textStyle: fz(fontSize: 12, color: white),
          ),
    );
  }
}
