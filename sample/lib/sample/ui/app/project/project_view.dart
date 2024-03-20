import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/domain/user/model/user_model.dart';
import 'package:sample/sample/ui/app/content/content_notifier.dart';
import 'package:sample/sample/ui/app/content/content_view.dart';
import 'package:sample/sample/ui/app/project/user/user_list_widget.dart';
import 'package:sample/sample/util/log.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';
import 'package:sample/sample/widget/common/b_button.dart';
import 'package:sample/sample/widget/common/b_text_widget.dart';

class ProjectView
    extends ProviderStatelessWidget<ContentNotifier, ContentViewModel> {
  const ProjectView();

  @override
  AutoDisposeStateNotifierProvider<ContentNotifier, ContentViewModel>
      get provider => ContentView.contentViewModelProvider;

  @override
  Widget pBuild(BuildContext context, WidgetRef ref) {
    final projectId =
        ref.watch(provider.select((value) => value.currentProjectId));

    Log.w('ProjectWidget Build - $projectId');

    ref.listen(GlobalStateStorage().currentProjectIdProvider, (previous, next) {
      ref.read(provider.notifier).update(currentProjectId: next);
    });

    ref.listen(
        GlobalStateStorage().projectProvider.select(
              (value) => value.projectStateModel.items
                  .singleWhere((element) => element.id == projectId)
                  .userStateModel,
            ), (previous, next) {
      Log.d('안녕하싱가.');
      ref.read(provider.notifier).updateUsers(
            projectId,
            next,
          );
    });

    final userState = ref.watch(
      provider.select(
        (value) {
          return value.project.projectStateModel.items
              .singleWhere((element) => element.id == projectId)
              .userStateModel
              .state;
        },
      ),
    );

    final projects = ref.read(provider.select((value) => value.project));
    final project = projects.projectStateModel.items
        .where((element) => element.id == projectId)
        .single;

    switch (userState) {
      case UserState.wait:
        return BButton(
            onPressed: () {
              ref
                  .read(GlobalStateStorage().projectProvider.notifier)
                  .fetchUser(project: project);
            },
            child: BTextWidget('${project.name} - 유저 가져오기'));
      case UserState.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case UserState.success:
        ref.watch(provider.select(
          (value) => value.project.projectStateModel.items
              .singleWhere((element) => element.id == projectId)
              .userStateModel
              .data
              .length,
        ));
        final data = ref.read(provider.select((value) => value
            .project.projectStateModel.items
            .singleWhere((element) => element.id == projectId)
            .userStateModel
            .data));
        return Column(
          children: [
            BButton(
              onPressed: () {
                ref.read(GlobalStateStorage().projectProvider.notifier).addUser(
                      project,
                      UserModel(
                        id: 33,
                        name: '정환',
                        email: 'abc',
                        userName: '구웃',
                      ),
                    );
              },
              child: BTextWidget('사용자 하나 추가'),
            ),
            Expanded(
              child: UserListWidget(
                userList: data,
                project: project,
              ),
            ),
          ],
        );
      case UserState.error:
        return Center(
          child: Text('유저 에러'),
        );
    }
  }
}
