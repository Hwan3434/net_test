import 'package:domain/repository/user/model/request/user_rreq_model.dart';
import 'package:domain/repository/user/model/request/users_rreq_model.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:domain/usecase/user/user_usecase.dart';

class UserUseCaseImpl2 implements UserUseCase {
  final UserRepository _repository;
  UserUseCaseImpl2(this._repository);

  /// tree도 usecase가 뱉어내야하는 하나의 프로퍼티에 불과하다고 판단한다!
  /// 밖에서 관리할 필요도 캐시할 필요도없이 그냥 이 클래서에서 관리가 되어야한다.
  // final Tree<Data>? tree;
  // Future<Tree<Data>> getTreeUser() async {
  //   reutrn tree ??= _firstTree();
  // }
  //
  // Tree<Data> _firstTree() async {
  //   List<User> users = await getUsers();
  //   Tree<data> result = {};
  //   for(User u in users){
  //     result.add(u);
  //   }
  //   return result;
  // }

  @override
  Future<UserModel> getUser({
    required int userId,
  }) {
    return _repository
        .getUser(request: UserRReqModel(userId: userId))
        .then((value) {
      return UserModel.fromUser(value);
    }).catchError((error) {
      throw error;
    });
  }

  @override
  Future<List<UserModel>> getUsers() {
    return _repository.getUsers(request: UsersRReqModel()).then((value) {
      return value.map((e) => UserModel.fromUsers(e)).toList();
    }).catchError((error) {
      throw error;
    });
  }
}
