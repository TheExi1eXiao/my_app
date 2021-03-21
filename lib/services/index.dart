import 'package:my_app/common/model/login/login_params.dart';
import 'package:my_app/common/model/user_info/user_info.dart';
import 'package:my_app/config/url.config.dart';
import 'package:my_app/utils/http.dart';
import 'package:my_app/utils/toast.dart';

class Api {
  ///登录
  static login({
    password, 
    phone, 
    platform, 
    registrationId, 
    uniqueId
  }) async {
    LoginParams _data = new LoginParams(
      password, 
      phone, 
      platform, 
      registrationId, 
      uniqueId
    );
    try {
      var res = await request(
        "post", 
        url[Url.login], 
        _data, 
        loading: true
      );
      res.data = UserInfo.fromJson(res.data);
      $toast("登录成功");
      return res;
    } catch (e) {
      throw e;
    }
  }
}