import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:my_app/style/common.dart';

class HomeSwiper extends StatefulWidget {
  ///列表数据
  final List data;
  HomeSwiper({Key key, this.data}) : super(key: key);
  _HomeSwiperState createState() => _HomeSwiperState();
}

class _HomeSwiperState extends State<HomeSwiper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: setWidth(180),
      alignment: Alignment.center,
      child: Swiper(
        loop: widget.data != null && widget.data.length > 1,
        itemCount: widget.data?.length ?? 0,
        layout: SwiperLayout.DEFAULT,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: CachedNetworkImage(
              imageUrl: widget.data[index].imageURL,
              width: MediaQuery.of(context).size.width,
              height: setWidth(180),
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: widget.data != null && widget.data.length > 1
          ? SwiperPagination(
              builder: DotSwiperPaginationBuilder(size: 8, activeSize: 8)
            )
          : null
      )
    );
  }
}

class MySnapSwiper extends StatelessWidget {
  MySnapSwiper({Key key, this.data}) : super(key: key);

  ///列表数据
  final List data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: setWidth(190),
      alignment: Alignment.center,
      color: white,
      child: Swiper(
        loop: data != null && data.length > 1,
        itemCount: data?.length ?? 0,
        itemWidth: setWidth(340),
        itemHeight: setWidth(190),
        containerWidth: setWidth(340),
        containerHeight: setWidth(190),
        viewportFraction: 0.9,
        layout: SwiperLayout.DEFAULT,
        scale: 0.92,
        indicatorLayout: PageIndicatorLayout.SCALE,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(bottom: setWidth(20)),
            constraints: BoxConstraints(
              maxWidth: setWidth(340), 
              maxHeight: setWidth(170)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(setWidth(10)),
              child: CachedNetworkImage(
                imageUrl: data[index].imageURL,
                width: setWidth(340),
                height: setWidth(170),
                fit: BoxFit.fill,
              ),
            ),
          );
        },
        pagination: data != null && data.length > 1
          ? SwiperPagination(
              margin: EdgeInsets.only(bottom: setWidth(8)),
              builder: DotSwiperPaginationBuilder(
                size: setFz(8),
                activeSize: setFz(9),
                space: 5.0,
                activeColor: mainColor,
                color: Color.fromARGB(
                  Color.getAlphaFromOpacity(0.1), 229, 52, 57
                )
              )
            )
          : null
      )
    );
  }
}

class VerticalSwiper extends StatelessWidget {
  VerticalSwiper({
    Key key,
    this.itemBuilder,
    this.itemCount = 0,
    this.height,
    this.width = 375
  }): super(key: key);
  Widget Function(BuildContext, int) itemBuilder;
  num height;
  num itemCount;
  num width;
  @override
  Widget build(BuildContext context) {
    if (itemCount == null) {
      itemCount = 0;
    }
    return Swiper(
      loop: true,
      itemHeight: setWidth(height),
      itemWidth: setWidth(width),
      autoplay: true,
      autoplayDelay: 4000,
      scrollDirection: Axis.vertical,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
