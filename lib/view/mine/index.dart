import 'package:flutter/material.dart';
import 'package:my_app/router/routes/router.dart';
import 'package:my_app/store/user_store/user_store.dart';
import 'package:my_app/style/common.dart';
import 'package:my_app/utils/bundle.dart';
import 'package:my_app/utils/navigator_util.dart';
import 'package:my_app/utils/tools.dart';
import 'package:my_app/view/login/index.dart';
import 'package:my_app/widget/layout/page_view.dart';
import 'package:provider/provider.dart';

class Mine extends StatefulWidget {
  final Bundle bundle;
  Mine({
    Key key,
    this.bundle,
  }): super(key: key);
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<Mine> {
  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);
    return MyPage(
      enableAppBar: false,
      onRefresh: () async {
        await delayHandler(2000);
      },
      showNativeHeader: true,
      child: userStore.token == null ? LoginPage() : _Mine(),
    );
  }
}

class _Mine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: setWidth(200),
      child: Center(
        child: InkWell(
          onTap: () {
            $Router.push(
              context, 
              RouterName.about,
              params: Bundle()..putInt('id', 1111)
            );
          },
          child: Text('去关于页面'),
        ),
      ),
    );
  }
}