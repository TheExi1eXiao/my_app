import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_app/style/common.dart';

$toast(String text) {
  BotToast.showText(
    text: text,
    textStyle: TextStyle(fontSize: setFz(14), color: white),
    borderRadius: BorderRadius.all(Radius.circular(6)),
    contentColor: Color.fromARGB(210, 0, 0, 0)
  ); //popup a text toast;
}

CancelFunc $showLoading({String text = "加载中..."}) {
  CancelFunc key;
  key = BotToast.showCustomLoading(
    backgroundColor: Color.fromARGB(0, 0, 0, 0),
    toastBuilder: (textCancel) {
      return Align(
        alignment: Alignment.center,
        child: new Container(
          constraints: BoxConstraints(maxWidth: setWidth(260)),
          child: Card(
            color: Color.fromARGB(220, 0, 0, 0),
            elevation: 10,
            margin: EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  height: setWidth(44),
                  child: SpinKitWave(
                    color: Color.fromARGB(210, 229, 52, 57),
                    size: setFz(14),
                    duration: Duration(milliseconds: 1000),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Text(
                      text,
                      style: TextStyle(color: white, fontSize: setFz(14)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      );
    }
  );
  return key;
}

$hideLoading(CancelFunc hide) {
  if (hide != null) {
    hide();
  }
}
