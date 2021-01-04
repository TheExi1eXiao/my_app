import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;
final userStore = new UserStore();

abstract class _UserStore with Store {
  @observable
  String token;

  @action
  setToken(String payload) async {
    token = payload;
  }
}
