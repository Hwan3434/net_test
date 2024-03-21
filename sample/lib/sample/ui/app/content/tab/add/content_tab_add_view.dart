import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/data/domain/project/model/project_state_model.dart';
import 'package:sample/sample/data/domain/user/model/user_state_model.dart';
import 'package:sample/sample/ui/app/content/content_notifier.dart';
import 'package:sample/sample/ui/app/content/content_view.dart';
import 'package:sample/sample/ui/app/project/project_view.dart';
import 'package:sample/sample/util/log.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';
import 'package:sample/sample/widget/common/b_button.dart';
import 'package:sample/sample/widget/common/b_text_widget.dart';
import 'package:sample/sample/widget/dialog/dialog_project_selector_body.dart';

class ContentTabAddView extends StatelessWidget {
  const ContentTabAddView();

  @override
  Widget build(BuildContext context) {
    Log.i('_CurrentADDWidget build');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CurrentAgentWidget(),
        Expanded(child: _CurrentProjectWidget()),
      ],
    );
  }
}

class _CurrentAgentWidget
    extends ProviderStatelessWidget<ContentNotifier, ContentViewModel> {
  const _CurrentAgentWidget();

  @override
  AutoDisposeStateNotifierProvider<ContentNotifier, ContentViewModel>
      get provider => ContentView.contentViewModelProvider;

  @override
  Widget pBuild(BuildContext context, WidgetRef ref) {
    final agent = ref.watch(provider.select((value) => value.agentModel));
    Log.w('_CurrentAgentWidget build {${agent.runtimeType}}');
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('id:[${agent.data?.id}]'),
          Text('pw:[${agent.data?.pw}]'),
          Text('name:[${agent.data?.name}]'),
          Text('AccessToken:[${agent.data?.accessToken}]'),
          Text('RefreshToken:[${agent.data?.refreshToken}]'),
        ],
      ),
    );
  }
}

class _CurrentProjectWidget
    extends ProviderStatelessWidget<ContentNotifier, ContentViewModel> {
  const _CurrentProjectWidget();

  @override
  AutoDisposeStateNotifierProvider<ContentNotifier, ContentViewModel>
      get provider => ContentView.contentViewModelProvider;

  @override
  Widget pBuild(BuildContext context, WidgetRef ref) {
    final projectId =
        ref.watch(provider.select((value) => value.currentProjectId));

    final projectState =
        ref.watch(provider.select((value) => value.project.state));

    Log.w('_CurrentProjectWidget build : $projectId / ${projectState.name}');

    ref.listen(GlobalStateStorage().projectProvider, (previous, next) {
      for (var project in next.items) {
        ref.read(provider.notifier).updateUsers(
              project.id,
              const UserStateModel(
                state: UserState.wait,
                data: [],
              ),
            );
      }
    });

    switch (projectState) {
      case ProjectState.wait:
        return Center(
          child: Column(
            children: [
              BButton(
                onPressed: () {
                  ref
                      .read(GlobalStateStorage().projectProvider.notifier)
                      .fetchProject();
                },
                child: BTextWidget('프로젝트 가져오기'),
              ),
            ],
          ),
        );
      case ProjectState.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case ProjectState.success:
        final myProjects =
            ref.read(provider.select((value) => value.project.items));
        final currentProject =
            myProjects.singleWhereOrNull((element) => projectId == element.id);

        ref.listen(GlobalStateStorage().currentProjectIdProvider,
            (previous, next) {
          ref.read(provider.notifier).update(
                currentProjectId: next,
              );
        });
        return Column(
          children: [
            DropdownButton(
              value: currentProject,
              items: [null, ...myProjects]
                  .map<DropdownMenuItem<ProjectModel?>>((e) {
                return DropdownMenuItem<ProjectModel?>(
                  value: e,
                  child: Text(e?.name ?? '미선택'),
                );
              }).toList(),
              onChanged: (value) {
                ref
                    .read(
                        GlobalStateStorage().currentProjectIdProvider.notifier)
                    .update((state) => value?.id ?? 0);
              },
            ),
            BButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
                  builder: ((context) {
                    return AlertDialog(
                      title: Text("프로젝트 변경"),
                      content: DialogProjectSelectorBody(
                        projects: myProjects,
                        onTab: (projectModel) {
                          ref
                              .read(GlobalStateStorage()
                                  .currentProjectIdProvider
                                  .notifier)
                              .update((state) => projectModel.id);
                        },
                      ),
                    );
                  }),
                );
              },
              child: Text('프로젝트 변경'),
            ),
            if (currentProject == null) Text('프로젝트 미선택'),
            if (currentProject != null)
              Flexible(
                child: ProjectView(),
              ),
          ],
        );
      case ProjectState.fail:
        return Center(
          child: Text('ProjectError'),
        );
    }
  }
}
