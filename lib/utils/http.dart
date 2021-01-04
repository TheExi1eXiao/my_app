import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:my_app/common/model/http_data.dart';
import 'package:my_app/config/api.config.dart';
import 'package:my_app/main.dart' show mainGlobalKey;
import 'package:my_app/utils/log_util.dart';
import 'package:my_app/utils/navigator_util.dart';
import 'package:my_app/utils/storage.dart';
import 'package:my_app/utils/toast.dart';
import 'package:my_app/utils/tools.dart';
import 'package:my_app/view/index.dart';
baseRequest(method, request, onError) async {
  BaseOptions baseoptions = new BaseOptions(
    baseUrl: baseUrl, //开发环境
    connectTimeout: 10000,
    sendTimeout: 10000,
    receiveTimeout: 10000,
  );
  // Dio initDio({String method}) {
  BaseOptions options = baseoptions;
  options.method = method;
  try {
    var token = await Storage.get("token");

    if (token != null || token != "") {
      options.headers.putIfAbsent("token", () => token);
    }
  } catch (e) {
    print(e);
  }

  Dio dio = new Dio(options);
  // Dio dio = new Dio(); // 使用默认配置

  dio.interceptors
    ..add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // 在请求被发送之前做一些事情

      print("\n================== 请求数据 ==========================");
      LogUtil.d("url = ${options.uri.toString()}");
      LogUtil.d("headers = ${options.headers}");

      LogUtil.d(options.method == "POST"
          ? "params = ${options.data?.toJson()}"
          : "params = ${options.queryParameters}");
      return options; //continue
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (Response response) {
      // 在返回响应数据之前做一些预处理

      print("\n================== 响应数据 ==========================");
      print("code = ${response.statusCode}");
      LogUtil.d("data = ${response.data}");

      print("\n");

      // $hideLoading(key);
      return response; // continue
    }, onError: (DioError e) {
      // 当请求失败时做一些预处理
      print("\n================== 错误响应数据 ======================");
      print("type = ${e.type}");
      print("message = ${e.message}");
      // print("stackTrace = ${e.stackTrace}");
      print("\n");

      onError(e);

      // $Toast.$toast("网络错误，请稍后重试");
      throw e; //continue
    }))

    ///加入缓存策略
    ..add(
        DioCacheManager(CacheConfig(baseUrl: baseUrl, maxMemoryCacheCount: 200))
            .interceptor);

  try {
    return request(dio);
  } catch (e) {
    print(e);
    throw e;
  }

  // }
}

request(method, url, data, {loading = false, options}) async {
  //进行Loading
  CancelFunc key;
  if (loading) {
    key = $showLoading();
  }

  success(
    Dio dio,
  ) async {
    Response response = await (method == "post"
        ? dio.request(
            url,
            data: data,
            options: options,
          )
        : dio.request(
            url,
            queryParameters: data?.toJson(),
            options: options,
          ));

    var result = HttpData.fromJson(response.data);
    // print(result);
    // var result = response.data;
    await delayHandler(20);
    $hideLoading(key);
    if (result.code == 0) {
      await delayHandler(20);
      return result;
    } else if (result?.code == 500002) {
      //登录过期
      $toast(result.msg);
      //重置用户信息
      Storage.remove("token");
      Storage.remove("userinfo");
      // final userStore = Provider.of<UserStore>(mainGlobalKey.currentContext,listen: false);
      // userStore.initUser();
      //先回退到主页
      await delayHandler(200);
      $Router.popRoot(entryIndexKey.currentContext);
      // $Router.push(context, path);
      //再进入我的页面
      await delayHandler(100);
      entryIndexKey.currentState.goPage(3);
      throw result;
    } else {
      $toast(result.msg);
      throw result;
    }
  }

  onError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      $toast("网络连接超时");
    } else {
      $toast("网络错误，请稍后重试");
    }

    $hideLoading(key);
  }

  return baseRequest(method, success, onError);
}
