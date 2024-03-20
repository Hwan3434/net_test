import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/common/usecase_manager.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';
import 'package:sample/sample/data/domain/agent/notifier/agent_notifier.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/data/domain/project/notifier/project_notifier.dart';

class GlobalStateStorage {
  GlobalStateStorage._privateConstructor();

  static final GlobalStateStorage _instance =
      GlobalStateStorage._privateConstructor();

  factory GlobalStateStorage() {
    return _instance;
  }

  void clear(WidgetRef ref) {
    /// agentStateProvider는 로그인을 관리하는 상태라서
    /// 임의로 초기화 하지않습니다.
    // ref.invalidate(agentStateProvider);
    ref.invalidate(loginOrganizationProvider);
    ref.invalidate(currentProjectIdProvider);
    ref.invalidate(projectProvider);
  }

  final loginOrganizationProvider = StateProvider<String>((ref) => '');

  /// 로그인 상태
  final agentStateProvider =
      StateNotifierProvider<AgentNotifier, AgentModel>((ref) {
    final agentUseCase = ref.read(UseCaseManager().agentUseCaseProvider);
    return AgentNotifier(
      AgentModel(state: AgentState.wait),
      agentUseCase: agentUseCase,
    );
  });

  final currentProjectIdProvider = StateProvider<int>((ref) => 0);

  final projectProvider =
      StateNotifierProvider<ProjectStateNotifier, ProjectProviderModel>((ref) {
    final agentUseCase = ref.read(UseCaseManager().agentUseCaseProvider);

    return ProjectStateNotifier(
      ProjectProviderModel.init(),
      ref: ref,
      agentUseCase: agentUseCase,
    );
  });

// final userStateProvider = StateNotifierProvider.family<UserStateNotifier,
//     UserListModel, ProjectDataModel>((ref, project) {
//   final agentUseCase = ref.read(UseCaseManager().agentUseCaseProvider);
//   final userUseCase = ref.read(UseCaseManager().userUseCaseProvider(project));
//   return UserStateNotifier(
//     UserListModel(
//       state: UserListState.wait,
//       data: [],
//     ),
//     agentUseCase: agentUseCase,
//     userUseCase: userUseCase,
//   );
// });
}
