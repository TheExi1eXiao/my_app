import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/utils/bundle.dart';

// typedef Widget HandlerFunc(
//   BuildContext context, 
//   Map<String, List<String>> params
// );
typedef HandlerFunc = Widget Function(BuildContext context, Map<String, List<String>>);
// typedef Widget Builder(Bundle bundle);
typedef Builder = Widget Function(Bundle bundle);
class RouteBuilder {
  final Builder builder;
  HandlerFunc handlerFunc;
  RouteBuilder({this.builder}) {
    this.handlerFunc = (context, _) {
      return this.builder(ModalRoute.of(context).settings.arguments as Bundle);
    };
  }
  Handler getHandler() {
    return new Handler(handlerFunc: this.handlerFunc);
  }
}
