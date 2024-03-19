import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/domain/user/model/user_model.dart';
import 'package:sample/sample/ui/app/content/content_view_model.dart';
import 'package:sample/sample/ui/app/content/content_widget.dart';
import 'package:sample/sample/ui/app/project/user/user_list_widget.dart';
import 'package:sample/sample/util/log.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';
import 'package:sample/sample/widget/common/b_button.dart';
import 'package:sample/sample/widget/common/b_text_widget.dart';

class ProjectWidget extends ProviderStatelessWidget<ContentViewModelNotifier,
    ContentViewModel> {
  const ProjectWidget();

  @override
  AutoDisposeStateNotifierProvider<ContentViewModelNotifier, ContentViewModel>
      get provider => ContentWidget.contentViewModelProvider;

  @override
  Widget pBuild(BuildContext context, WidgetRef ref) {
    final projectId =
        ref.read(provider.select((value) => value.currentProjectId));
    final projects = ref.read(provider.select((value) => value.project));
    final project =
        projects.items.where((element) => element.id == projectId).single;
    final userState = ref.watch(
      provider.select(
        (value) {
          return value.users[projectId]!.state;
        },
      ),
    );

    Log.w('ProjectWidget Build - $projectId');
    ref.listen(GlobalStateStorage().userStateProvider(project),
        (previous, next) {
      ref.read(provider.notifier).updateUsers(
            projectId,
            next,
          );
    });

    switch (userState) {
      case UserListState.wait:
        return BButton(
            onPressed: () {
              ref
                  .read(
                      GlobalStateStorage().userStateProvider(project).notifier)
                  .fetch();
            },
            child: BTextWidget('${project.name} - 유저 가져오기'));
      case UserListState.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case UserListState.success:
        final count = ref.watch(
            provider.select((value) => value.users[project.id]!.data.length));
        final data =
            ref.read(provider.select((value) => value.users[project.id]!.data));
        return Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  ref
                      .read(GlobalStateStorage()
                          .userStateProvider(project)
                          .notifier)
                      .addUser(
                        UserModel(
                          id: 33,
                          name: '정환',
                          email: 'abc',
                          userName: '구웃',
                        ),
                      );
                },
                child: BTextWidget('사용자 하나 추가')),
            Expanded(
              child: UserListWidget(
                userList: data,
                projectId: projectId,
                searchProvider: provider,
                callBack: (model) {
                  ref
                      .read(GlobalStateStorage()
                          .userStateProvider(project)
                          .notifier)
                      .update(model);
                },
              ),
            ),
          ],
        );
      case UserListState.error:
        return Center(
          child: Text('유저 에러'),
        );
    }
  }
}
