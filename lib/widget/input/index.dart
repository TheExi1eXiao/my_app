import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/style/common.dart';
import 'package:my_app/style/imgs.dart';

/// 带图标的输入框
class IconInput extends StatefulWidget {
  final bool obscureText;

  final String hintText;
  final String labelText;

  final String icon;
  final num iconWidth;
  final num iconHeight;
  final List<TextInputFormatter> inputFormatters;

  final ValueChanged<String> onChanged;

  final TextStyle textStyle;

  final TextEditingController controller;

  IconInput({
    Key key,
    this.labelText,
    this.hintText,
    this.icon,
    this.iconWidth,
    this.iconHeight,
    this.onChanged,
    this.textStyle,
    this.controller,
    this.inputFormatters,
    this.obscureText = false
  }): super(key: key);

  @override
  _IconInputState createState() => _IconInputState();
}

class _IconInputState extends State<IconInput> {
  _IconInputState() : super();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: mainColor),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        textInputAction: TextInputAction.next,
        obscureText: widget.obscureText,
        cursorColor: mainColor,
        inputFormatters: widget.inputFormatters != null ? [...widget.inputFormatters] : null,
        decoration: InputDecoration(
          hintText: widget.hintText,
          focusedBorder: UnderlineInputBorder(),
          border: null,
          hintStyle: TextStyle(color: grey9, fontSize: setFz(14)),
          labelStyle: TextStyle(color: mainColor, fontSize: setFz(16)),
          labelText: widget.labelText,
          icon: widget.icon == null
            ? null
            : Image.asset(
                widget.icon,
                fit: BoxFit.fill,
                width: setWidth(widget.iconWidth),
                height: setWidth(widget.iconHeight),
              ),
        ),
      ),
    );
  }
}

///手机号输入框
class PhoneInput extends StatelessWidget {
  PhoneInput({
    Key key,
    this.icon,
    this.type,
    this.phone,
    this.controller,
    this.onChanged
  }): super(key: key);
  // final _formKey = GlobalKey<FormState>();
  final String icon;
  final num type;
  final String phone;
  void Function(String) onChanged;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: controller,
        maxLength: 11,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        style: fz(),
        cursorColor: mainColor,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        toolbarOptions: ToolbarOptions(),
        buildCounter: null,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: setWidth(6), 
            horizontal: setWidth(10)
          ),
          labelText: "手机号",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 1)
          ),
          border: InputBorder.none,
          counter: Container(),
          hintStyle: TextStyle(color: grey9, fontSize: setFz(14)),
          labelStyle: TextStyle(color: grey9, fontSize: setFz(15)),
          icon: icon == null
            ? null
            : Image.asset(
                icon,
                fit: BoxFit.fill,
                width: setWidth(16),
                height: setWidth(16),
              ),
        ),
      ),
    );
  }
}

class DefaultInput extends StatelessWidget {
  DefaultInput({
    Key key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.maxLength,
    this.style,
    this.readOnly = false,
    this.obscureText = false,
    this.enabled = true,
    this.initialValue,
    this.keyboardType,
    this.inputFormatters,
    this.textAlign = TextAlign.left,
    this.hintStyle
  }): super(key: key);
  String hintText;
  String initialValue;
  TextStyle hintStyle;
  num maxLength;
  TextStyle style;
  bool readOnly;
  bool obscureText;
  bool enabled;
  List<TextInputFormatter> inputFormatters;
  TextAlign textAlign;
  void Function(String) onChanged;
  TextInputType keyboardType;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    this.hintStyle = this.hintStyle ?? fz(fontSize: 15, color: grey9);
    this.style = this.style ?? fz();

    return TextFormField(
      toolbarOptions: ToolbarOptions(),
      cursorColor: mainColor,
      cursorWidth: setWidth(2),
      scrollPadding: EdgeInsets.all(0),
      maxLength: maxLength,
      enabled: enabled,
      obscureText: obscureText,
      readOnly: readOnly,
      textAlign: textAlign,
      onChanged: onChanged,
      controller: controller,
      style: style,
      keyboardType: keyboardType,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: setWidth(9)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        border: InputBorder.none,
        hintText: hintText,
        counter: Container(
          width: 0,
          height: 0,
        ),
        hintStyle: hintStyle,
      ),
    );
  }
}

///密码输入框
class PasswordInput extends StatelessWidget {
  PasswordInput({
    Key key,
    this.isobscureText,
    this.onRightTap,
    this.icon,
    this.controller,
    this.onChanged
  }): super(key: key);
  final String icon;
  bool isobscureText;
  TextEditingController controller;
  void Function(String) onChanged;
  void Function() onRightTap;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: controller,
        toolbarOptions: ToolbarOptions(),
        textInputAction: TextInputAction.done,
        cursorColor: mainColor,
        obscureText: isobscureText,
        onChanged: onChanged,
        style: TextStyle(
          letterSpacing: 4, 
          fontSize: setFz(14), 
          color: normalTextColor
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]|[0-9]")),
        ],
        decoration: InputDecoration(
          labelText: "密码",
          contentPadding: EdgeInsets.symmetric(
            vertical: setWidth(6), 
            horizontal: setWidth(10)
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 1)
          ),
          border: InputBorder.none,
          hintStyle: TextStyle(color: grey9, fontSize: setFz(14), letterSpacing: 0),
          labelStyle: TextStyle(color: grey9, fontSize: setFz(15)),
          suffix: Container(
            child: InkWell(
              onTap: onRightTap,
              child: isobscureText
                ? Image.asset(
                    IMGs.PASSWORD_EYE_CLOSE,
                    height: setWidth(8),
                    width: setWidth(14),
                  )
                : Image.asset(
                    IMGs.PASSWORD_EYE,
                    height: setWidth(8),
                    width: setWidth(14),
                  ),
            ),
          ),
          icon: icon == null
              ? null
              : Image.asset(
                  icon,
                  fit: BoxFit.fill,
                  width: setWidth(16),
                  height: setWidth(16),
                ),
        ),
      ),
    );
  }
}

///验证码输入框
class TextCodeInput extends StatelessWidget {
  TextCodeInput({
    Key key, 
    this.icon, 
    this.controller, 
    this.onChanged
  }): super(key: key);
  final String icon;
  TextEditingController controller;
  void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: controller,
        toolbarOptions: ToolbarOptions(),
        textInputAction: TextInputAction.done,
        cursorColor: mainColor,
        obscureText: false,
        onChanged: onChanged,
        style: fz(),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]|[0-9]")),
        ],
        decoration: InputDecoration(
          labelText: "短信验证码",
          contentPadding: EdgeInsets.symmetric(
            vertical: setWidth(6), 
            horizontal: setWidth(10)
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 1)
          ),
          border: InputBorder.none,
          hintStyle: TextStyle(color: grey9, fontSize: setFz(14), letterSpacing: 0),
          labelStyle: TextStyle(color: grey9, fontSize: setFz(15)),
          icon: icon == null
            ? null
            : Image.asset(
                icon,
                fit: BoxFit.fill,
                width: setWidth(16),
                height: setWidth(16),
              ),
        ),
      ),
    );
  }
}
