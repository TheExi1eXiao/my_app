import 'package:my_app/router/route_builder.dart';
import 'package:my_app/view/about/index.dart';
import 'package:my_app/view/home/index.dart';

abstract class RouterName {
  static String home = "home";
  static String about = "about";
}

final Map<String, RouteBuilder> routeConfigName = {
  RouterName.home: RouteBuilder(builder: (bundle) => Home(bundle: bundle)),
  RouterName.about: RouteBuilder(builder: (bundle) => About(bundle: bundle))
};
