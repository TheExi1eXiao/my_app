import 'package:flutter/cupertino.dart';
import 'package:my_app/utils/bundle.dart';
import 'package:my_app/utils/toast.dart';
import 'package:my_app/widget/layout/page_view.dart';

class About extends StatefulWidget {
  About({
    Key key,
    this.bundle,
  }) : super(key: key);
  final Bundle bundle;

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<About> {
  int _id;
  @override
  void initState() {
    super.initState();
    getData();
    if (mounted) {
      setState(() {
        _id = widget.bundle.getInt('id');
      });
    }
  }

  getData() {
    String inputTxt = '22.2';
    try {
      var inp = num.parse(inputTxt);
      print(inp is int && inp > 0);
    } catch (e) {
      $toast('请输入正整数');
    } finally {

    }
    
  }

  @override
  Widget build(BuildContext context) {
    return MyPage(
      title: '关于',
      child: Container(
        child: Text('this is about page${_id}'),
      )
    );
  }
}
