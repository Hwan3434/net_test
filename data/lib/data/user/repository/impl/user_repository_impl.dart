import 'package:data/data/user/datasource/user_datasource.dart';
import 'package:domain/repository/user_repository.dart';
import 'package:domain/usecase/login/res_model/login_user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;
  UserRepositoryImpl(this._dataSource);

  @override
  Future<List<LoginUserModel>> getUsers({required int memberNo}) async {
    return await _dataSource.users(memberNo: memberNo).then((value) {
      return value.map((e) => LoginUserModel(id: e.id, name: e.name)).toList();
    }).catchError((onError) {
      return (List.empty() as List<LoginUserModel>);
    });
  }
}
