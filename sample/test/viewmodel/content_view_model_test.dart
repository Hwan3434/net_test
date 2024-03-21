import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample/sample/data/domain/agent/model/agent_state_model.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/info/app_info_manager.dart';
import 'package:sample/sample/data/shared/shared_data_manager.dart';
import 'package:sample/sample/ui/app/content/content_notifier.dart';

import 'test_util.dart';

final contentViewModelTestProvider =
    StateNotifierProvider.autoDispose<ContentNotifier, ContentViewModel>((ref) {
  final organization = ref.read(GlobalStateStorage().loginOrganizationProvider);
  final agent = ref.read(GlobalStateStorage().agentStateProvider);
  final currentProjectId =
      ref.read(GlobalStateStorage().currentProjectIdProvider);
  final projects = ref.read(GlobalStateStorage().projectProvider);

  assert(organization.isNotEmpty);
  assert(agent.state == AgentState.success);
  final currentTab = SharedDataManger().getCurrentTab();
  return ContentNotifier(
    ContentViewModel(
      currentTabIndex: currentTab,
      organization: organization,
      agentModel: agent,
      project: projects,
      currentProjectId: currentProjectId,
    ),
  );
});

void main() {
  AppInfoManger().init();
  group('컨텐츠 뷰 모델 테스트', () {
    test('컨텐츠 뷰 모델 초기화 상태 파악', () {
      final lis = Listener<ContentViewModel>();
      final container =
          createContainer<ContentViewModel>(contentViewModelTestProvider, lis);
    });

    test('컨텐츠 뷰 모델 컨트롤', () {
      final lis = Listener<ContentViewModel>();
      final container =
          createContainer<ContentViewModel>(contentViewModelTestProvider, lis);
    });
  });
}
