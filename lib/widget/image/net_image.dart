import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_app/style/common.dart';

class NetImage extends StatelessWidget {
  NetImage({
    Key key,
    @required this.img,
    this.width,
    this.height,
    this.fit = BoxFit.fill,
  }): super(key: key);

  ///图片地址
  final String img;

  ///宽度
  final num width;

  ///高度
  final num height;

  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != null ? setWidth(width) : null,
      height: height != null ? setWidth(height) : null,
      child: CachedNetworkImage(
        imageUrl: img ?? " ",
        width: width != null ? setWidth(width) : null,
        height: height != null ? setWidth(height) : null,
        fit: fit,
        placeholder: (context, url) => SpinKitCircle(
          color: mainColor,
          size: setFz(18),
        ),
        errorWidget: (context, url, error) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: setWidth(5)),
                child: Icon(
                  MaterialIcons.error,
                  color: grey6,
                  size: setFz(28),
                ),
              ),
              Flexible(
                child: Text("图片不见了", style: fz(color: grey6, fontSize: 12)),
              )
            ],
          );
        },
      ),
    );
  }
}
