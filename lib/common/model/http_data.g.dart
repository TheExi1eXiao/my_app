// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpData<T> _$HttpDataFromJson<T>(Map<String, dynamic> json) {
  return HttpData<T>(
    json['code'] as int,
    json['data'],
    json['msg'] as String,
    json['page'] as int,
    json['pages'] as int,
    json['pageSize'] as int,
    json['total'] as int,
  );
}

Map<String, dynamic> _$HttpDataToJson<T>(HttpData<T> instance) =>
    <String, dynamic>{
      'code': instance.code,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'pages': instance.pages,
      'total': instance.total,
      'msg': instance.msg,
      'data': instance.data,
    };
