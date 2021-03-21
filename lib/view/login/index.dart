import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/store/user_store/user_store.dart';
import 'package:my_app/style/common.dart';
import 'package:my_app/style/imgs.dart';
import 'package:my_app/utils/bundle.dart';
import 'package:my_app/utils/navigator_util.dart';
import 'package:my_app/utils/toast.dart';
import 'package:my_app/utils/tools.dart';
import 'package:my_app/widget/btn/buttonWidget.dart';
import 'package:my_app/widget/btn/code_btn.dart';
import 'package:my_app/widget/input/index.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}): super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _phone;
  String _password;
  String _code;
  bool isobscureText = true;
  num type = 1; //登录类型1：密码，2：短信
  void login(context) async {
    if (type == 1) {
      if (_phone == null || _password == null || !checkPassWord(_password)) {
        $toast("请输入正确的登录信息");
      } else {
        final userStore = Provider.of<UserStore>(context, listen: false);
        userStore.login(_phone, _password);
      }
    } else {
      if (_phone == null || _code == null) {
        $toast("请输入正确的登录信息");
      } else {
        // final userStore = Provider.of<UserStore>(context, listen: false);
        // userStore.loginWithSMS(_phone, _code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: GestureDetector(
        //增加一个点击事件，使得点击APP空白处收起软键盘
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Image.asset(
                    IMGs.LOGIN_BG,
                    width: MediaQuery.of(context).size.width - setWidth(50),
                    height: setWidth(224),
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    top: setWidth(5),
                    child: SafeArea(
                      child: Text(
                        "登录",
                        style: TextStyle(fontSize: setFz(18), color: normalTextColor),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: setWidth(10),
                  bottom: setWidth(10),
                  left: setWidth(15),
                  right: setWidth(15),
                ),
                child: SafeArea(
                  right: false,
                  left: false,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
                          child: Stack(
                            children: [
                              PhoneInput(
                                icon: IMGs.LOGIN_PHONE,
                                onChanged: (String value) {
                                  setState(() {
                                    _phone = value;
                                  });
                                },
                              ),
                              Positioned(
                                right: 0,
                                bottom: setWidth(14),
                                child: Offstage(
                                  offstage: type == 1,
                                  child: CodeBtn(
                                    phone: _phone,
                                    type: 2,
                                  ),
                                ),
                              )
                            ]
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
                          child: type == 1
                            ? PasswordInput(
                                icon: IMGs.LOGIN_PASS,
                                onChanged: (value) {
                                  setState(() {
                                    _password = value;
                                  });
                                },
                                isobscureText: isobscureText,
                                onRightTap: () {
                                  setState(() {
                                    isobscureText = !isobscureText;
                                  });
                                }
                              )
                            : TextCodeInput(
                                icon: IMGs.LOGIN_PASS,
                                onChanged: (value) {
                                  setState(() {
                                    _code = value;
                                  });
                                },
                              ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: setWidth(345),
                          height: setWidth(30),
                          padding: EdgeInsets.only(left: setWidth(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _password = "";
                                    _code = "";
                                    type = type == 1 ? 2 : 1;
                                  });
                                },
                                child: Text(
                                  type == 1 ? "切换至短信登录" : "切换至密码登录",
                                  style: fz(color: blue, fontSize: 12),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  $Router.push(
                                    context, 
                                    "forget",
                                    params: Bundle()..putString("type", "1")
                                  );
                                },
                                child: Text(
                                  "忘记密码？   ",
                                  style: fz(color: blue, fontSize: 12),
                                ),
                              ),
                            ],
                          )
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: setWidth(10)),
                          margin: EdgeInsets.only(bottom: setWidth(10)),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: MeetBtn(
                                  text: "登录",
                                  onPressed: () {
                                    login(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: setWidth(10)),
                          padding: EdgeInsets.symmetric(horizontal: setWidth(10)),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: MeetBtn(
                                  color: blue,
                                  text: "还没有账号？快速注册！",
                                  onPressed: () {
                                    $Router.push(context, "register");
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
