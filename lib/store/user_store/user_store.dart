import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:my_app/common/model/user_info/user_info.dart';
import 'package:my_app/services/index.dart';
import 'package:my_app/utils/storage.dart';
import 'package:my_app/utils/tools.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;
final userStore = new UserStore();

abstract class _UserStore with Store {
  @observable
  String token;

  @observable
  UserInfo userinfo;

  @action
  setToken(String payload) async {
    token = payload;
  }

  @action
  setUserinfo(UserInfo payload) async {
    userinfo = payload;

    await Storage.save("userinfo", json.encode(payload?.toJson()));
  }

  @action
  login(String phone, String password) async {
    var password1 = base64.encode(utf8.encode(password));
    try {
      var res = await Api.login(phone: phone, password: password1);
      setToken(res.data.token);
      await delayHandler(300);
      setUserinfo(res.data);
    } catch (e) {}
  }
}
