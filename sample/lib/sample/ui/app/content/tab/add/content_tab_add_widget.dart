import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/ui/app/content/content_view_model.dart';
import 'package:sample/sample/ui/app/content/content_widget.dart';
import 'package:sample/sample/ui/app/project/project_widget.dart';
import 'package:sample/sample/util/log.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';
import 'package:sample/sample/widget/common/b_button.dart';
import 'package:sample/sample/widget/common/b_text_widget.dart';

class ContentTabAddWidget extends StatelessWidget {
  const ContentTabAddWidget();

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

class _CurrentAgentWidget extends ProviderStatelessWidget<
    ContentViewModelNotifier, ContentViewModel> {
  const _CurrentAgentWidget();

  @override
  AutoDisposeStateNotifierProvider<ContentViewModelNotifier, ContentViewModel>
      get provider => ContentWidget.contentViewModelProvider;

  @override
  Widget pBuild(BuildContext context, WidgetRef ref) {
    final agent = ref.watch(provider.select((value) => value.agentModel));
    Log.e('_CurrentAgentWidget 11111 build {${agent.runtimeType}}');
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

class _CurrentProjectWidget extends ProviderStatelessWidget<
    ContentViewModelNotifier, ContentViewModel> {
  const _CurrentProjectWidget();

  @override
  AutoDisposeStateNotifierProvider<ContentViewModelNotifier, ContentViewModel>
      get provider => ContentWidget.contentViewModelProvider;

  @override
  Widget pBuild(BuildContext context, WidgetRef ref) {
    Log.i('_CurrentProjectWidget build');
    final projectId =
        ref.watch(provider.select((value) => value.currentProjectId));

    final projectState =
        ref.watch(provider.select((value) => value.project.state));

    switch (projectState) {
      case ProjectState.wait:
        return Center(
          child: Column(
            children: [
              BButton(
                  onPressed: () {
                    ref
                        .read(GlobalStateStorage().projectProvider.notifier)
                        .fetchData();
                  },
                  child: BTextWidget('프로젝트 가져오기')),
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
        return Column(
          children: [
            DropdownButton(
              value: currentProject,
              items: [null, ...myProjects]
                  .map<DropdownMenuItem<ProjectDataModel?>>((e) {
                return DropdownMenuItem<ProjectDataModel?>(
                  value: e,
                  child: Text(e?.name ?? '미선택'),
                );
              }).toList(),
              onChanged: (value) {
                ref.read(provider.notifier).update(
                      currentProjectId: value?.id ?? 0,
                    );
              },
            ),
            if (currentProject == null) Text('프로젝트 미선택'),
            if (currentProject != null)
              Flexible(
                child: Project2Widget(),
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
