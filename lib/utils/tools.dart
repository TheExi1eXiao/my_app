import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:my_app/style/common.dart';

showPicker(
  BuildContext context, 
  num selectDateIndex, 
  List<dynamic> list,
  Function(String, num) onConfirm
) {
  Picker picker = new Picker(
    adapter: PickerDataAdapter<String>(pickerdata: list),
    changeToFirst: true,
    textAlign: TextAlign.left,
    columnPadding: const EdgeInsets.all(1),
    cancelText: "取消",
    height: setWidth(180),
    itemExtent: setWidth(40),
    selectedTextStyle: fz(fontSize: 22),
    textStyle: fz(fontSize: 22),
    selecteds: [selectDateIndex],
    cancelTextStyle: fz(fontSize: 15, color: blue),
    confirmTextStyle: fz(fontSize: 15, color: blue),
    confirmText: "确定",
    onConfirm: (Picker picker, List value) {
      onConfirm(picker.getSelectedValues()[0], value[0]);
    }
  );
  picker.showModal(context);
}

delayHandler(num milliseconds) {
  if (milliseconds == 0) {
    return Future.delayed(Duration.zero, () {});
  } else {
    return Future.delayed(Duration(milliseconds: milliseconds), () {});
  }
}


///获取设备ID
Future<String> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }
}
