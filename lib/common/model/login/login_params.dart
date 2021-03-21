import 'package:json_annotation/json_annotation.dart'; 
  
part 'login_params.g.dart';


@JsonSerializable()
  class LoginParams extends Object {

  @JsonKey(name: 'password')
  String password;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'platform')
  int platform;

  @JsonKey(name: 'registrationId')
  String registrationId;

  @JsonKey(name: 'uniqueId')
  String uniqueId;

  LoginParams(this.password,this.phone,this.platform,this.registrationId,this.uniqueId,);

  factory LoginParams.fromJson(Map<String, dynamic> srcJson) => _$LoginParamsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LoginParamsToJson(this);

}

  
