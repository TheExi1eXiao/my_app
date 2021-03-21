import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_app/router/route_builder.dart';
import 'package:my_app/router/routes/router.dart';
import 'package:my_app/view/index.dart';

Map<String, RouteBuilder> routeConfig = {}..addAll(routeConfigName);

class Routes {
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notFoundHandler;

    router.define(
      "root",
      handler: rootHandler,
      transitionType: TransitionType.cupertino
    );
    routeConfig.forEach((path, page) {
      router.define(
        path.toString(),
        handler: page.getHandler(),
        transitionType: TransitionType.cupertino
      );
    });
  }
}

// 根路由函数
Handler rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params
) {
  return EntryIndex();
});

// 404路由函数
Handler notFoundHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params
) {
  print("ROUTE WAS NOT FOUND !!!");
  return Container();
});