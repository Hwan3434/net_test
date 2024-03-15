import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/data/domain/user/model/user_model.dart';
import 'package:sample/sample/ui/app/project/user/user_list_widget.dart';

class ProjectWidget extends ConsumerWidget {
  final ProjectDataModel project;
  const ProjectWidget({
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(
      GlobalStateStorage().userStateProvider(project).select(
            (value) => value.state,
          ),
    );
    switch (userState) {
      case UserListState.wait:
        return ElevatedButton(
            onPressed: () {
              ref
                  .read(
                      GlobalStateStorage().userStateProvider(project).notifier)
                  .fetch();
            },
            child: Text('${project.name} - 유저 가져오기'));
      case UserListState.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case UserListState.success:
        final data = ref.read(GlobalStateStorage()
            .userStateProvider(project)
            .select((value) => value.data));
        return UserListWidget(
          userList: data,
          pm: project,
          callBack: (model) {
            ref
                .read(GlobalStateStorage().userStateProvider(project).notifier)
                .update(model);
          },
        );
      case UserListState.error:
        return Center(
          child: Text('유제 에러'),
        );
    }
  }
}
