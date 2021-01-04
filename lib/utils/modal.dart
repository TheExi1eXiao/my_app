import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:my_app/style/common.dart';
import 'package:my_app/widget/modal/index.dart';

void $showModal({
  void Function(CancelFunc) cancel,
  void Function(CancelFunc) confirm,
  bool blockPopup = true,
  bool autoClose = true,
  String cancelText = "取消",
  String confirmText = "确定",
  String title = "",
  double aniStartX = 0.0,
  double aniStartY = 0.8,
  Widget content,
  VoidCallback backgroundReturn,
  VoidCallback physicalBackButton
}) {
  BotToast.showAnimationWidget(
    clickClose: false,
    allowClick: false,
    onlyOne: true,
    crossPage: true,
    wrapAnimation: (controller, cancel, child) => BackgroundRoute(
      child: child,
      blockPopup: blockPopup,
      cancelFunc: cancel,
      physicalButtonPopCallback: () {
        physicalBackButton?.call();
      },
    ),
    wrapToastAnimation: (controller, cancel, child) => Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // cancel();
            backgroundReturn?.call();
          },
          //The DecoratedBox here is very important,he will fill the entire parent component
          child: AnimatedBuilder(
            builder: (_, child) => Opacity(
              opacity: controller.value,
              child: child,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.black26),
              child: SizedBox.expand(),
            ),
            animation: controller,
          ),
        ),
        CustomOffsetAnimation(
          controller: controller,
          child: child,
          startX: aniStartX,
          startY: aniStartY,
        )
      ],
    ),
    toastBuilder: (cancelFunc) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(
        title,
        style: fz(fontSize: 18),
      ),
      content: content,
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (autoClose) cancelFunc();
            cancel?.call(cancelFunc);
          },
          highlightColor: const Color(0x55FF8A80),
          splashColor: const Color(0x99FF8A80),
          child: Text(
            cancelText,
            style: fz(color: Colors.redAccent),
          ),
        ),
        FlatButton(
          onPressed: () {
            if (autoClose) cancelFunc();
            confirm?.call(cancelFunc);
          },
          child: Text(
            confirmText,
            style: fz(color: blue),
          ),
        ),
      ],
    ),
    animationDuration: Duration(milliseconds: 300)
  );
}

class BackgroundRoute extends StatefulWidget {
  final Widget child;
  final bool blockPopup;
  final CancelFunc cancelFunc;
  final VoidCallback physicalButtonPopCallback;

  const BackgroundRoute({
    Key key,
    this.child,
    this.blockPopup,
    this.cancelFunc,
    this.physicalButtonPopCallback
  }): super(key: key);

  @override
  _BackgroundRouteState createState() => _BackgroundRouteState();
}

class _BackgroundRouteState extends State<BackgroundRoute> {
  bool _needPop = false;
  NavigatorState _navigatorState;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _navigatorState = Navigator.of(context);
      _navigatorState.push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, __, ___) => IgnorePointer(
            child: WillPopScope(
              child: Align(),
              onWillPop: () async {
                if (_needPop) {
                  return true;
                }
                if (!widget.blockPopup) {
                  widget.physicalButtonPopCallback?.call();
                  widget.cancelFunc();
                }
                return false;
              },
            ),
          )
        )
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _needPop = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _navigatorState.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class CustomOffsetAnimation extends StatefulWidget {
  final AnimationController controller;
  final Widget child;
  final double startX;
  final double startY;
  CustomOffsetAnimation({
    Key key, 
    this.startX, 
    this.startY, 
    this.controller, 
    this.child
  }): super(key: key);

  @override
  _CustomOffsetAnimationState createState() => _CustomOffsetAnimationState();
}

class _CustomOffsetAnimationState extends State<CustomOffsetAnimation> {
  Tween<Offset> tweenOffset;
  Tween<double> tweenScale;

  Animation<double> animation;

  @override
  void initState() {
    tweenOffset = Tween<Offset>(
      begin: Offset(widget.startX, widget.startY),
      end: Offset.zero,
    );
    tweenScale = Tween<double>(begin: 0.3, end: 1.0);
    animation = CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: widget.child,
      animation: widget.controller,
      builder: (BuildContext context, Widget child) {
        return FractionalTranslation(
          translation: tweenOffset.evaluate(animation),
          child: ClipRect(
            child: Transform.scale(
              scale: tweenScale.evaluate(animation),
              child: Opacity(
                child: child,
                opacity: animation.value,
              ),
            ),
          )
        );
      },
    );
  }
}

YYDialog $showDialog({
  void Function() cancel,
  void Function() confirm,
  bool blockPopup = true,
  bool autoClose = true,
  String cancelText = "取消",
  String confirmText = "确定",
  Color cancelColor = blue,
  Color confirmColor = blue,
  String title,
  double aniStartX = 0.0,
  double aniStartY = 0,
  Widget content,
  num width = 260,
  BuildContext context,
  VoidCallback backgroundReturn,
  VoidCallback physicalBackButton
}) {
  YYDialog yyDialog;
  yyDialog = YYDialog().build(context)
    ..width = setWidth(width)
    // ..borderRadius = 4.0
    ..gravityAnimationEnable = true
    ..gravity = Gravity.center
    ..duration = Duration(milliseconds: 200)
    ..barrierDismissible = !blockPopup
    ..decoration = BoxDecoration(
      boxShadow: [
        BoxShadow(
          blurRadius: 5,
          offset: Offset(2, 2),
          spreadRadius: 2,
          color: normalTextColor.withAlpha(50)
        )
      ],
      color: white,
      border: Border.all(width: 0, color: white),
      borderRadius: BorderRadius.circular(8)
    )
    ..animatedFunc = (child, animation) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..translate(
            0.0,
            Tween<double>(begin: maxWidth * aniStartY, end: 0)
              .animate(
                CurvedAnimation(curve: Curves.decelerate, parent: animation),
              )
              .value,
          )
          ..scale(
            Tween<double>(begin: 0.3, end: 1.0)
              .animate(
                CurvedAnimation(curve: Curves.decelerate, parent: animation),
              )
              .value,
          ),
        child: child,
      );
    }
    ..text(
      padding: title != null
        ? EdgeInsets.only(
            top: setWidth(15),
            left: setWidth(15),
            right: setWidth(15),
            bottom: setWidth(10)
          )
        : EdgeInsets.all(0),
      text: title,
      alignment: Alignment.center,
      textAlign: TextAlign.center,
      color: normalTextColor,
      fontSize: setFz(15),
      fontWeight: FontWeight.w500,
    )
    ..widget(
      Container(
        // constraints: BoxConstraints(
        //   minHeight: maxHeight * .05,
        // ),
        padding: EdgeInsets.symmetric(horizontal: setWidth(15)),
        child: content,
      ) ??
      SizedBox(
        height: setWidth(20),
      )
    )
    ..widget(
      Container(
        padding: EdgeInsets.only(top: setWidth(8)),
        child: myDoubleButton(
          isClickAutoDismiss: autoClose,
          gravity: Gravity.center,
          text1: cancelText,
          color1: cancelColor,
          fontSize1: setFz(15),
          onTap1: () {
            if (autoClose) {
              yyDialog.dismiss();
            }
            cancel?.call();
          },
          text2: confirmText,
          color2: confirmColor,
          fontSize2: setFz(15),
          onTap2: () {
            if (autoClose) {
              yyDialog.dismiss();
            }
            confirm?.call();
          },
        ),
      )
    )
    ..show();
  return yyDialog;
}
