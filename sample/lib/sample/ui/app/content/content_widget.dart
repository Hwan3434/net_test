import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/data/domain/user/model/user_model.dart';
import 'package:sample/sample/data/shared/shared_data_manager.dart';
import 'package:sample/sample/ui/app/content/content_view_model.dart';
import 'package:sample/sample/util/log.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';

import 'tab/content_tab_widget.dart';

class ContentWidget extends StatelessWidget {
  static String get path => '/Content';
  static String get name => 'ContentWidget';
  const ContentWidget({super.key});

  static final contentViewModelProvider = StateNotifierProvider.autoDispose<
      ContentViewModelNotifier, ContentViewModel>((ref) {
    Log.i('contentViewModelPrvider CreateFn');
    final organization =
        ref.read(GlobalStateStorage().loginOrganizationProvider);
    final agent = ref.read(GlobalStateStorage().agentStateProvider);
    final project = ref.watch(GlobalStateStorage().projectProvider);

    // GlobalStateStorage에서 가져오는 데이터는 무조건 read이여야하며
    // 값이 존재한다고 판단 후 사용합니다.
    assert(organization.isNotEmpty);
    assert(agent.state == AgentState.success);
    final currentTab = SharedDataManger().getCurrentTab();
    return ContentViewModelNotifier(
      ContentViewModel(
        currentTabIndex: currentTab,
        organization: organization,
        agentModel: agent,
        project: project,
        currentProjectId: 0,
        users: {
          for (var element in project.items)
            element.id: const UserListModel(
              state: UserListState.wait,
              data: [],
            )
        },
      ),
    );
  });

  @override
  Widget build(BuildContext context) {
    Log.w('ContentWidget Build');
    return _ContentAgentCheckWidget(
      child: ContentTabWidget(),
    );
  }
}

class _ContentAgentCheckWidget extends ProviderStatelessWidget<
    ContentViewModelNotifier, ContentViewModel> {
  final Widget child;
  const _ContentAgentCheckWidget({required this.child});

  @override
  AutoDisposeStateNotifierProvider<ContentViewModelNotifier, ContentViewModel>
      get provider => ContentWidget.contentViewModelProvider;

  @override
  Widget pBuild(BuildContext context, WidgetRef ref) {
    Log.w('_ContentAgentCheckWidget Build');
    ref.listen(GlobalStateStorage().projectProvider, (previous, next) {
      ref.read(provider.notifier).update(project: next);
    });

    final projectId =
        ref.watch(provider.select((value) => value.currentProjectId));
    final projectState = ref.read(provider.select((value) => value.project));

    if (projectId != 0 && projectState.state == ProjectState.success) {
      final p = projectState.items.where((element) {
        return element.id == projectId;
      }).single;

      ref.listen(
        GlobalStateStorage().userStateProvider(p),
        (previous, next) {
          final users = ref.read(provider).users;
          Map<int, UserListModel> u = {p.id: next};
          u.addAll(users);
          ref.read(provider.notifier).update(
                users: u,
              );
        },
      );
    }

    return child;
  }
}
