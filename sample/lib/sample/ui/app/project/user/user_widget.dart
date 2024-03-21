import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/data/domain/user/model/user_model.dart';
import 'package:sample/sample/ui/app/common/user_detail_view.dart';
import 'package:sample/sample/util/log.dart';
import 'package:sample/sample/widget/common/b_text_widget.dart';

class UserWidget extends ConsumerWidget {
  final ProjectModel project;
  final UserModel user;
  const UserWidget({
    required this.project,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.w(
        'UserWidget :: ${user.id} - ${user.name} / ${user.email} / (${user.userName})');
    return Card(
      elevation: 3,
      child: Builder(builder: (context) {
        Log.w('UserWidget XXXX Build');
        return InkWell(
          onTap: () {
            context.pushNamed(
              UserDetailView.name,
              extra: user.id,
            );

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return UserDetail(
            //         project: project,
            //         userModel: user,
            //       );
            //     },
            //   ),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('${user.id} - ${user.name} / '),
                Expanded(
                  child: BTextWidget(
                    '${user.email}',
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
