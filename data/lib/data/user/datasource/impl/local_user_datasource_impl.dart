import 'package:data/data/user/datasource/model/response/res_user_model.dart';
import 'package:data/data/user/datasource/user_datasource.dart';

class LocalUserDataSourceImpl implements UserDataSource {
  @override
  Future<List<ResUserModel>> users({required int memberNo}) async {
    return [
      ResUserModel(id: 1, name: 'John Doe 1'),
      ResUserModel(id: 2, name: 'John Doe 2'),
      ResUserModel(id: 3, name: 'John Doe 3'),
      ResUserModel(id: 4, name: 'John Doe 4'),
      ResUserModel(id: 5, name: 'John Doe 5'),
      ResUserModel(id: 6, name: 'John Doe 6'),
      ResUserModel(id: 7, name: 'John Doe 7'),
      ResUserModel(id: 8, name: 'John Doe 8'),
      ResUserModel(id: 9, name: 'John Doe 9'),
      ResUserModel(id: 10, name: 'John Doe 10'),
    ];
  }
}
