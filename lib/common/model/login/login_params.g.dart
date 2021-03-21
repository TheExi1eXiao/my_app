// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginParams _$LoginParamsFromJson(Map<String, dynamic> json) {
  return LoginParams(
    json['password'] as String,
    json['phone'] as String,
    json['platform'] as int,
    json['registrationId'] as String,
    json['uniqueId'] as String,
  );
}

Map<String, dynamic> _$LoginParamsToJson(LoginParams instance) =>
    <String, dynamic>{
      'password': instance.password,
      'phone': instance.phone,
      'platform': instance.platform,
      'registrationId': instance.registrationId,
      'uniqueId': instance.uniqueId,
    };
