import 'package:data/sample/user/datasource/base_user_datasource.dart';
import 'package:data/sample/user/datasource/model/response/res_user_model.dart';
import 'package:data/sample/user/repository/base_user_repository.dart';
import 'package:flutter/widgets.dart';

class UserRepositoryImpl implements BaseUserRepository {
  final BaseUserDataSource _dataSource;
  UserRepositoryImpl(this._dataSource);

  @override
  Future<List<ResUserModel>> getUsers() async {
    return await _dataSource.users().then((value) {
      return value;
    }).catchError((onError) {
      debugPrint('니 와죽노 ? : ${onError}');
    });
  }
}
