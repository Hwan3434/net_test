import 'dart:async';

import '../model/response/user_dres_model.dart';
import '../model/response/users_dres_model.dart';
import '../user_datasource.dart';

class LocalUserDataSourceImpl implements UserDataSource {
  final List<UserDResModel> mockData = [
    UserDResModel(id: 1, name: '홍길동', username: '', email: ''),
    UserDResModel(id: 2, name: '서힘찬', username: '', email: ''),
    UserDResModel(id: 3, name: '남궁수', username: '', email: ''),
    UserDResModel(id: 4, name: '이찬혁', username: '', email: ''),
    UserDResModel(id: 5, name: '김응수', username: '', email: ''),
    UserDResModel(id: 6, name: '조혁', username: '', email: ''),
    UserDResModel(id: 7, name: '김혁필', username: '', email: ''),
    UserDResModel(id: 8, name: '나상호', username: '', email: ''),
    UserDResModel(id: 9, name: '손흥민', username: '', email: ''),
    UserDResModel(id: 10, name: '황금빛', username: '', email: '')
  ];

  @override
  Future<UserDResModel> user(int userId) {
    assert(mockData.map((e) => e.id).contains(userId));
    final UserDResModel user =
        mockData.singleWhere((element) => element.id == userId);
    return Future.value(user);
  }

  @override
  Future<List<UsersDResModel>> users() {
    return Future.value(
        mockData.map((e) => UsersDResModel(id: e.id, name: e.name)).toList());
  }

  @override
  Future<void> delete(int userId) {
    mockData.removeWhere((element) => element.id == userId);
    return Future.value();
  }

  @override
  Future<void> insert(UserDResModel user) {
    mockData.add(user);
    return Future.value();
  }

  @override
  Future<void> update(UserDResModel user) {
    mockData.removeWhere((element) => element.id == user.id);
    mockData.add(user);
    return Future.value();
  }
}
