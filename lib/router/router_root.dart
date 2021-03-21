import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_app/router/route_builder.dart';
import 'package:my_app/view/index.dart';

enum RouteRootName { root }

final Map<dynamic, RouteBuilder> routeConfigRoot = {
  "root": RouteBuilder(builder: (bundle) => EntryIndex())
};

Handler rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params
) {
  return EntryIndex();
});

Handler notFoundHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params
) {
  print("ROUTE WAS NOT FOUND !!!");
  return Container();
});