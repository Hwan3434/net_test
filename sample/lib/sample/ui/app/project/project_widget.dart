import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/domain/user/model/user_model.dart';
import 'package:sample/sample/ui/app/content/content_view_model.dart';
import 'package:sample/sample/ui/app/content/content_widget.dart';
import 'package:sample/sample/ui/app/project/user/user_list_widget.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';
import 'package:sample/sample/widget/common/b_button.dart';
import 'package:sample/sample/widget/common/b_text_widget.dart';

class Project2Widget extends ProviderStatelessWidget<ContentViewModelNotifier,
    ContentViewModel> {
  const Project2Widget();

  @override
  AutoDisposeStateNotifierProvider<ContentViewModelNotifier, ContentViewModel>
      get provider => ContentWidget.contentViewModelProvider;

  @override
  Widget pBuild(BuildContext context, WidgetRef ref) {
    final projectId =
        ref.watch(provider.select((value) => value.currentProjectId));
    final projects = ref.watch(provider.select((value) => value.project));
    final project =
        projects.items.where((element) => element.id == projectId).single;
    final userState = ref.watch(
      provider.select(
        (value) => value.users.state,
      ),
    );

    ref.listen(GlobalStateStorage().userStateProvider(project),
        (previous, next) {
      ref.read(provider.notifier).update(users: next);
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

        /// 새로운 데이터 추가시 전체 새로그림
        final data = ref.watch(provider.select((value) => value.users));
        return UserListWidget(
          userList: data.data,
          searchProvider: provider,
          callBack: (model) {
            ref
                .read(GlobalStateStorage().userStateProvider(project).notifier)
                .update(model);
          },
        );
      case UserListState.error:
        return Center(
          child: Text('유저 에러'),
        );
    }
  }
}
