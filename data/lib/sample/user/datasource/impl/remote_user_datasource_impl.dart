import 'package:data/sample/user/datasource/base_user_datasource.dart';
import 'package:data/sample/user/datasource/model/response/res_user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'remote_user_datasource_impl.g.dart';

@RestApi()
abstract class RemoteUserDataSourceImpl implements BaseUserDataSource {
  factory RemoteUserDataSourceImpl(Dio dio) = _RemoteUserDataSourceImpl;

  @GET('/users')
  @override
  Future<List<ResUserModel>> users();
}
