import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/ui/app/content/content_view.dart';
import 'package:sample/sample/ui/app/project/user/user_widget.dart';
import 'package:sample/sample/util/log.dart';

class UserListWidget extends StatelessWidget {
  final ProjectModel project;
  final List<UserModel> userList;
  const UserListWidget({
    required this.project,
    required this.userList,
  });

  @override
  Widget build(BuildContext context) {
    Log.d('UserListWidget Build!');
    return ListView.builder(
      shrinkWrap: true,
      itemCount: userList.length,
      itemBuilder: (context, index) {
        return Consumer(
          builder: (context, ref, child) {
            Log.w('UserListWidget Consumer Build!');
            final user = ref.watch(
              ContentView.contentViewModelProvider.select((value) {
                return value.project.projectStateModel.items
                    .singleWhere((element) => element.id == project.id)
                    .userStateModel
                    .data[index];
              }),
            );
            return UserWidget(
              project: project,
              user: user,
            );
          },
        );
      },
    );
  }
}
