import 'package:domain/usecase/result/result.dart';
import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:domain/usecase/user/user_usecase.dart';

class MockUserCaseImpl3 implements UserUseCase {
  MockUserCaseImpl3();

  @override
  Future<Result<UserDataModel>> getUser({
    required int userId,
  }) {
    return Future.value(
      ResultSuccess(
        UserDataModel(
          id: userId,
          name: 'mock_s',
          email: 'mock_email',
          userName: 'mock_userName',
        ),
      ),
    );
  }

  @override
  Future<Result<List<UserDataModel>>> getUsers() {
    return Future.value(ResultSuccess([
      UserDataModel(
        id: 1,
        name: 'mock_s',
        email: 'mock_email',
        userName: 'mock_userName',
      ),
      UserDataModel(
        id: 2,
        name: 'mock_s2',
        email: 'mock_email2',
        userName: 'mock_userName2',
      ),
      UserDataModel(
        id: 3,
        name: 'mock_s3',
        email: 'mock_email3',
        userName: 'mock_userName3',
      ),
    ]));
  }

  @override
  Future<Result> delete(int userId) async {
    throw UnimplementedError();
  }

  @override
  Future<Result> insert() {
    throw UnimplementedError();
  }

  @override
  Future<Result> update() {
    throw UnimplementedError();
  }
}
