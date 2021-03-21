// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$tokenAtom = Atom(name: '_UserStore.token');

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  final _$userinfoAtom = Atom(name: '_UserStore.userinfo');

  @override
  UserInfo get userinfo {
    _$userinfoAtom.reportRead();
    return super.userinfo;
  }

  @override
  set userinfo(UserInfo value) {
    _$userinfoAtom.reportWrite(value, super.userinfo, () {
      super.userinfo = value;
    });
  }

  final _$setTokenAsyncAction = AsyncAction('_UserStore.setToken');

  @override
  Future setToken(String payload) {
    return _$setTokenAsyncAction.run(() => super.setToken(payload));
  }

  final _$setUserinfoAsyncAction = AsyncAction('_UserStore.setUserinfo');

  @override
  Future setUserinfo(UserInfo payload) {
    return _$setUserinfoAsyncAction.run(() => super.setUserinfo(payload));
  }

  final _$loginAsyncAction = AsyncAction('_UserStore.login');

  @override
  Future login(String phone, String password) {
    return _$loginAsyncAction.run(() => super.login(phone, password));
  }

  @override
  String toString() {
    return '''
token: ${token},
userinfo: ${userinfo}
    ''';
  }
}
