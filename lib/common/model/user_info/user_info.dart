import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo extends Object {
  @JsonKey(name: 'addressId')
  int addressId;

  @JsonKey(name: 'analystMarker')
  int analystMarker;

  @JsonKey(name: 'attention')
  int attention;

  @JsonKey(name: 'cstatus')
  int cstatus;

  @JsonKey(name: 'fans')
  int fans;

  @JsonKey(name: 'fidInvitationCode')
  String fidInvitationCode;

  @JsonKey(name: 'headPortrait')
  String headPortrait;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'isInternal')
  int isInternal;

  @JsonKey(name: 'isUpdate')
  String isUpdate;

  @JsonKey(name: 'levelName')
  String levelName;

  @JsonKey(name: 'msgCount')
  int msgCount;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'num')
  int num;

  @JsonKey(name: 'offHike')
  String offHike;

  @JsonKey(name: 'onHike')
  String onHike;

  @JsonKey(name: 'packageName')
  String packageName;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'promotionChannels')
  String promotionChannels;

  @JsonKey(name: 'province')
  Province province;

  @JsonKey(name: 'qq')
  int qq;

  @JsonKey(name: 'sex')
  int sex;

  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'totalHike')
  String totalHike;

  UserInfo(
    this.addressId,
    this.analystMarker,
    this.attention,
    this.cstatus,
    this.fans,
    this.fidInvitationCode,
    this.headPortrait,
    this.id,
    this.isInternal,
    this.isUpdate,
    this.levelName,
    this.msgCount,
    this.nickname,
    this.num,
    this.offHike,
    this.onHike,
    this.packageName,
    this.phone,
    this.promotionChannels,
    this.province,
    this.qq,
    this.sex,
    this.token,
    this.totalHike,
  );

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class Province extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  Province(
    this.id,
    this.name,
  );

  factory Province.fromJson(Map<String, dynamic> srcJson) =>
      _$ProvinceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProvinceToJson(this);
}
