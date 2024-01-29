import '../model/response/user_dres_model.dart';
import '../model/response/users_dres_model.dart';
import '../user_datasource.dart';

class LocalUserDataSourceImpl implements UserDataSource {
  @override
  Future<UserDResModel> user(int userId) {
    // TODO: implement user
    return Future.value(UserDResModel(
      id: 1,
      name: 'n',
      username: '',
      email: '',
    ));
  }

  @override
  Future<List<UsersDResModel>> users() {
    // TODO: implement users
    return Future.value([
      UsersDResModel(id: 1, name: 'n'),
      UsersDResModel(id: 2, name: 'n'),
      UsersDResModel(id: 3, name: 'n'),
      UsersDResModel(id: 4, name: 'n'),
      UsersDResModel(id: 5, name: 'n'),
      UsersDResModel(id: 6, name: 'n'),
      UsersDResModel(id: 7, name: 'n'),
      UsersDResModel(id: 8, name: 'n'),
      UsersDResModel(id: 9, name: 'n'),
      UsersDResModel(id: 10, name: 'n')
    ]);
  }
}
