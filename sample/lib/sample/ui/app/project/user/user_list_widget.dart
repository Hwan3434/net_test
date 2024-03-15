import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/ui/app/common/user_detail.dart';
import 'package:sample/sample/ui/app/project/user/user_widget.dart';

class UserListWidget extends StatelessWidget {
  final ProjectDataModel pm;
  final List<UserModel> userList;
  final UserEmailEditCallBack callBack;
  const UserListWidget({
    super.key,
    required this.pm,
    required this.userList,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: userList.length,
      itemBuilder: (context, index) {
        return Consumer(
          builder: (context, ref, child) {
            final user = ref.watch(
              userChildProvider(
                PUModel(
                  pm: pm,
                  index: index,
                ),
              ),
            );
            return UserWidget(
              user: user,
              callBack: callBack,
            );
          },
        );
      },
    );
  }
}
