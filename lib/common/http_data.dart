import 'package:json_annotation/json_annotation.dart';

part 'http_data.g.dart';

@JsonSerializable()
class HttpData<T> {
  int code;
  int page;
  int pageSize;
  int pages;
  int total;
  String msg;
  dynamic data;
  HttpData(this.code,this.data,this.msg,this.page,this.pages,this.pageSize,this.total);
  factory HttpData.fromJson(Map<String, dynamic> json) =>
      _$HttpDataFromJson(json);
}