import 'package:data/data/user/datasource/model/response/res_user_model.dart';
import 'package:data/data/user/datasource/user_datasource.dart';
import 'package:data/data/user/repository/user_repository.dart';
import 'package:flutter/widgets.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;
  UserRepositoryImpl(this._dataSource);

  @override
  Future<List<ResUserModel>> getUsers() async {
    return await _dataSource.users().then((value) {
      return value;
    }).catchError((onError) {
      debugPrint('니 와죽노 ? : ${onError}');
      return (List.empty() as List<ResUserModel>);
    });
  }
}