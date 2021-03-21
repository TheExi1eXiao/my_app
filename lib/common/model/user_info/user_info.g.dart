// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    json['addressId'] as int,
    json['analystMarker'] as int,
    json['attention'] as int,
    json['cstatus'] as int,
    json['fans'] as int,
    json['fidInvitationCode'] as String,
    json['headPortrait'] as String,
    json['id'] as int,
    json['isInternal'] as int,
    json['isUpdate'] as String,
    json['levelName'] as String,
    json['msgCount'] as int,
    json['nickname'] as String,
    json['num'] as int,
    json['offHike'] as String,
    json['onHike'] as String,
    json['packageName'] as String,
    json['phone'] as String,
    json['promotionChannels'] as String,
    json['province'] == null
        ? null
        : Province.fromJson(json['province'] as Map<String, dynamic>),
    json['qq'] as int,
    json['sex'] as int,
    json['token'] as String,
    json['totalHike'] as String,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'addressId': instance.addressId,
      'analystMarker': instance.analystMarker,
      'attention': instance.attention,
      'cstatus': instance.cstatus,
      'fans': instance.fans,
      'fidInvitationCode': instance.fidInvitationCode,
      'headPortrait': instance.headPortrait,
      'id': instance.id,
      'isInternal': instance.isInternal,
      'isUpdate': instance.isUpdate,
      'levelName': instance.levelName,
      'msgCount': instance.msgCount,
      'nickname': instance.nickname,
      'num': instance.num,
      'offHike': instance.offHike,
      'onHike': instance.onHike,
      'packageName': instance.packageName,
      'phone': instance.phone,
      'promotionChannels': instance.promotionChannels,
      'province': instance.province,
      'qq': instance.qq,
      'sex': instance.sex,
      'token': instance.token,
      'totalHike': instance.totalHike,
    };

Province _$ProvinceFromJson(Map<String, dynamic> json) {
  return Province(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$ProvinceToJson(Province instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
