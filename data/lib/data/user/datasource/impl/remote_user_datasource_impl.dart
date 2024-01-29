import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/response/user_dres_model.dart';
import '../model/response/users_dres_model.dart';
import '../user_datasource.dart';

part 'remote_user_datasource_impl.g.dart';

@RestApi()
abstract class RemoteUserDataSourceImpl implements UserDataSource {
  factory RemoteUserDataSourceImpl(Dio dio) = _RemoteUserDataSourceImpl;

  @GET('/users/{userId}')
  @override
  Future<UserDResModel> user(@Path() int userId);
  @GET('/users')
  @override
  Future<List<UsersDResModel>> users();
}
