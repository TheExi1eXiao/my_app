import 'package:flutter/widgets.dart';
import 'package:my_app/style/common.dart';
import 'package:my_app/style/imgs.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      height: maxHeight,
      child: Image.asset(
        IMGs.SPLASH_IMG,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
