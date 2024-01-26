import 'package:data/data/user/datasource/model/response/res_user_model.dart';
import 'package:data/data/user/datasource/user_datasource.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'remote_user_datasource_impl.g.dart';

@RestApi()
abstract class RemoteUserDataSourceImpl implements UserDataSource {
  factory RemoteUserDataSourceImpl(Dio dio) = _RemoteUserDataSourceImpl;

  @GET('/users')
  @override
  Future<List<ResUserModel>> users({required int memberNo});
}
