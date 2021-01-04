import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/router/route_builder.dart';

Future checkAuth(RouteBuilder after) async {}
void $routerBefore(RouteBuilder before, RouteBuilder after, next) async {
  await checkAuth(after);
  next();
}

class $Router {
  static push(
    BuildContext context, path,
    {
      bool replace = false,
      bool clearStack = false,
      Object params,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder
    }
  ) {
    return Navigator.pushNamed(context, path.toString(), arguments: params);
  }

  static back(BuildContext context, {init = false}) {
    Navigator.pop(context, init);
  }

  static backInit(BuildContext context) {
    Navigator.maybePop(context, true);
  }

  static popRoot(BuildContext context) {
    Navigator.popUntil(context, (route) {
      return route.settings.name == "root";
    });
  }

  static replace(
    BuildContext context, path,
    {
      bool replace = true,
      bool clearStack = false,
      Object params,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder
    }
  ) {
    Navigator.pushReplacementNamed(context, path.toString(), arguments: params);
  }
}
