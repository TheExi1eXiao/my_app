import 'package:bot_toast/bot_toast.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:my_app/config/application.dart';
import 'package:my_app/router/routes.dart';
import 'package:my_app/store/user_store/user_store.dart';
import 'package:my_app/style/common.dart';
import 'package:my_app/utils/moment_local_CN.dart';
import 'package:provider/provider.dart';
import 'package:simple_moment/simple_moment.dart';

GlobalKey mainGlobalKey = new GlobalKey();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  // debugPaintSizeEnabled = true;
  final FluroRouter router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;
  WidgetsFlutterBinding.ensureInitialized();
  //设置moment本地化信息
  Moment.setLocaleGlobally(new LocaleCN());
  //状态栏
  FlutterStatusbarManager.setColor(Color.fromARGB(0, 0, 0, 0), animated: true);
  runApp(MultiProvider(providers: [
    Provider<UserStore>(
      create: (_) => UserStore(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "root",
      builder: BotToastInit(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: hexToColor("#f1f1f1"),
        platform: TargetPlatform.iOS
      ),
      key: mainGlobalKey,
      // debugShowCheckedModeBanner: false,
      // showPerformanceOverlay: false,
      onGenerateRoute: Application.router.generator,
      // navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}
