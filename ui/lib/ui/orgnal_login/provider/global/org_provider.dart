import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/global/data/org_data_provider.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_model.dart';
import 'package:ui/ui/orgnal_login/widget/original_login_view.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final Ref ref;
  LoginNotifier(this.ref, super.state);

  void login(String userId, String userPw) async {
    state = LoginLoading(userId: userId, userPw: userPw);
    await Future.delayed(Duration(seconds: 1));

    /// LoginUseCase get Login
    /// Login Success
    /// LoginUsecase get LoginList;
    /// final orgName = LoginList.first;
    /// final userUseCase = UseCaseManager.i.getUserUseCase(orgName);
    ///

    /// useCase를 통해서 로그인에 성공한 사용자 데이터를 가져온다.
    final user = UserLoginModel(index: 1, userId: userId, userPw: userPw);

    /// UseCase를 통해서 모든 프로젝트를 다 가져옵니다.
    List<OrgModel> orgList = [
      OrgModel(id: 1, name: '조직1'),
      OrgModel(id: 2, name: '조직2'),
    ];

    final orgListProvider = GlobalDataManager.i.getOrgListProvider();
    ref.read(orgListProvider.notifier).addAllOrgModel(orgList);

    final currentOrg = orgList.first;

    ref.read(currentOrgProvider.notifier).update((state) => currentOrg);

    state = LoginSuccess(userInfo: user);
  }

  void logout() async {
    state = LoginLogout();

    /// 서버에 로그아웃 전달
    await Future.delayed(Duration(seconds: 1));
    // 성공시 none으로 실패시 기존 상태 유지
    state = LoginNone();
  }
}

sealed class LoginState {}

class LoginNone extends LoginState {}

class LoginLogout extends LoginState {}

class LoginLoading extends LoginState {
  final String userId;
  final String userPw;

  LoginLoading({
    required this.userId,
    required this.userPw,
  });
}

class LoginSuccess extends LoginState {
  final UserLoginModel userInfo;

  LoginSuccess({
    required this.userInfo,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginSuccess &&
          runtimeType == other.runtimeType &&
          userInfo.userId == other.userInfo.userId;

  @override
  int get hashCode => userInfo.userId.hashCode;
}

class UserLoginModel {
  final String userId;
  final String userPw;
  final int index;

  const UserLoginModel({
    required this.index,
    required this.userId,
    required this.userPw,
  });
}
