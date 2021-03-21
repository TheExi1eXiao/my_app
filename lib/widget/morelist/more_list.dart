import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:my_app/style/common.dart';
import 'package:my_app/utils/tools.dart';
import 'package:my_app/widget/layout/airplane_header.dart';
import 'package:my_app/widget/layout/page_loading.dart';
import 'package:my_app/widget/morelist/my_empty.dart';
import 'package:my_app/widget/morelist/my_footer.dart';

///列表状态码
class ListStatus {
  ///初始状态
  static num before = 0;

  ///刷新中
  static num refreshing = 1;

  ///没有更多了
  static num noMore = 2;

  ///不显示
  static num noShow = 3;

  ///网络错误
  static num netError = 4;

  ///加载中
  static num loading = 5;
}

class MoreList<T> extends StatefulWidget {
  MoreList({
    Key key,
    this.api,
    this.itemBuilder,
    this.listHeadBuilder,
    this.firstRefresh = true,
    this.canPullRefresh = true,
    this.useScrollMask = true,
    this.firstAni = true,
    this.useMaterialRefresh = false,
    this.useScrollController = false,
    this.pageSize = 20,
    this.beforeRes,
    this.scrollController,
    this.easyRefreshController,
    this.noMoreText = '没有数据了',
    this.loadingText = '正在加载...'  
  }): super(key: key);

  ///"没有更多"文本内容
  String noMoreText;

  ///"加载中"文本内容
  String loadingText;
  //第一次开启自动刷新
  bool firstRefresh;
  //第一次开启自动刷新是否有动画
  bool firstAni;
  //能否使用下拉刷新
  bool canPullRefresh;
  //使用小球下拉
  bool useMaterialRefresh;
  //使用独立滚动控制器
  bool useScrollController;

  ///下拉刷新时是否使用滚动蒙层
  bool useScrollMask;

  ///每页数据量
  num pageSize;

  ///列表控制器
  EasyRefreshController easyRefreshController;
  ScrollController scrollController;

  ///在更新视图前处理网络数据返回值res
  dynamic Function(dynamic) beforeRes;

  ///列表项构造
  Widget Function(T, List<T>) itemBuilder;

  ///列表头部构造
  Widget Function(List<T>, num) listHeadBuilder;

  ///自制控制器
  // MoreListController moreListController;
  ///返回一个API函数
  Function api;
  @override
  State<StatefulWidget> createState() => MoreListState<T>(
    itemBuilder: itemBuilder,
    listHeadBuilder: listHeadBuilder,
    pageSize: pageSize,
    scrollController: scrollController,
  );
}

class MoreListState<T> extends State<MoreList> {
  MoreListState({
    this.itemBuilder,
    this.scrollController,
    this.listHeadBuilder,
    this.pageSize
  });

  ///当前页码
  num page = 1;

  ///每页数据量
  num pageSize;

  ///数据总量
  int _count = 0;
  Timer _timer1;
  Timer _timer2;

  ///数据
  List<T> listData = [];

  ///是否是首次渲染
  bool first = true;

  ///是否渲染底部
  bool showFoot = false;

  ///列表加载状态
  num loadStatus = ListStatus.before;

  ///列表项构造
  Widget Function(T, List<T>) itemBuilder;

  ///列表头部构造
  Widget Function(List<T>, num) listHeadBuilder;

  ///列表控制器
  EasyRefreshController easyRefreshController;

  ///滚动控制器
  ScrollController scrollController;

  ///遮罩层Key
  CancelFunc refreshModal;

  @override
  void initState() {
    easyRefreshController = widget.easyRefreshController ?? EasyRefreshController();
    if (widget.firstRefresh && !widget.firstAni) {
      this.getData(1);
    }
    super.initState();
  }

  @override
  void dispose() {
    this._timer1?.cancel();
    this._timer2?.cancel();

    super.dispose();
  }

  ///手动触发刷新
  startRefresh() {
    easyRefreshController.callRefresh(duration: Duration(milliseconds: 1));
  }

  ///刷新
  Future<void> onRefresh({callback}) async {
    setState(() {
      loadStatus = ListStatus.refreshing;
      showFoot = false;
    });
    if (!first && widget.useScrollMask != null && widget.useScrollMask)
      this.setRefreshModal();

    getData(1, callback: callback);
  }

  ///设置遮罩
  setRefreshModal() {
    CancelFunc _refreshModal = BotToast.showEnhancedWidget(
      allowClick: false,
      warpWidget: (_, child) {
        return Container(
          width: maxWidth,
          margin: EdgeInsets.only(top: statusBarHeight + kToolbarHeight),
          child: child,
        );
      },
      crossPage: false,
      toastBuilder: (_) {
        return Container();
      },
    );
    setState(() {
      refreshModal = _refreshModal;
    });
  }

  ///等动画结束清除遮罩
  clearRefreshModal() {
    _timer2 = Timer(Duration(milliseconds: 1500), () {
      this?.setState(() {
        refreshModal?.call();
        refreshModal = null;
      });
    });
  }

  ///加载更多
  Future<void> onLoad() async {
    setState(() {
      loadStatus = ListStatus.loading;
    });
    getData(page);
  }

  ///没有更多了
  loadNoMore() async {
    easyRefreshController.finishRefresh();
    easyRefreshController.finishLoad(noMore: true);
    setState(() {
      loadStatus = ListStatus.noMore;
    });
    this.clearRefreshModal();
  }

  ///获取数据
  ///* [_page] 传入所需要获取数据的页码
  ///* [_callback] 回调，传入参数为是否成功
  getData(_page, {callback}) async {
    try {
      var res = await widget.api(_page, pageSize);

      if (widget.beforeRes != null) {
        res = widget.beforeRes(res);
      }

      var data = res.data;
      if (loadStatus == ListStatus.refreshing) {
        if (mounted) {
          setState(() {
            page = 1;
          });
        }

        easyRefreshController.resetLoadState();
      }

      ///更新数据
      List<T> _listData = [];
      if (loadStatus == ListStatus.refreshing) {
      } else {
        _listData = [...listData];
      }
      _listData.addAll((data ?? []));

      if (mounted) {
        setState(() {
          listData = _listData;
          _count = _listData.length;
          first = false;
        });
      }

      callback?.call(success: true);

      ///处理底部闪现BUG
      _timer1 = Timer(Duration(milliseconds: 1500), () {
        setState(() {
          showFoot = true;
        });
      });
      await delayHandler(10);
      if (data != null && data.length > 0) {
        if (res.total <= res.page * res.pageSize) {
          loadNoMore();
        } else {
          setState(() {
            loadStatus = ListStatus.before;
          });
          easyRefreshController.finishLoad();
          easyRefreshController.finishRefresh();
          this.clearRefreshModal();
        }

        setState(() {
          page = page + 1;
        });
      } else {
        loadNoMore();
      }
    } catch (e) {
      print("---列表错误----");
      print(e);
      easyRefreshController.finishLoad(success: false);
      easyRefreshController.finishRefresh(success: false);
      setState(() {
        loadStatus = ListStatus.netError;
      });
      callback?.call(success: false);
      this.clearRefreshModal();
    }
  }

  Widget _buildAniItem(BuildContext context, int index, animation, list) {
    return FadeTransition(
      opacity: animation,
      child: itemBuilder(list[index], list),
    );
  }

  @override
  Widget build(BuildContext context) {

    return EasyRefresh(
      header: widget.useMaterialRefresh ? MaterialHeader() : FlyHeader(),
      footer: MyClassicalFooter(
        noMoreText: widget.noMoreText,
        loadedText: widget.loadingText,
        infoText: "更新于 %T",
        showFooter: showFoot,
        enableHapticFeedback: false,
        enableInfiniteLoad: true,
        infoColor: mainColor,
        completeDuration: Duration(milliseconds: 10),
      ),
      onRefresh: widget.canPullRefresh ? onRefresh : null,
      topBouncing: false,
      onLoad: onLoad,
      firstRefresh: widget.firstRefresh && widget.firstAni,
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      controller: easyRefreshController,
      scrollController: widget.useScrollController ? ScrollController() : null,
      firstRefreshWidget: PageLoading(),
      emptyWidget: _count != 0 || first ? null : MyEmpty(),
      child: listData != null
        ? ListView(
            children: [
              listHeadBuilder != null
                ? listHeadBuilder(listData, loadStatus)
                : Container(),
              for (var item in listData) itemBuilder(item, listData)
            ],
          )
        : null
    );
  }
}

class MoreListController {
  MoreListState moreListState;
  // 绑定状态
  void _bindState(MoreListState state) {
    this.moreListState = state;
  }

  void dispose() {
    this.moreListState = null;
  }
}
