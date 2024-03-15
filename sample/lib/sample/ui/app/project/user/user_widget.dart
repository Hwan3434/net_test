import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/ui/app/common/user_detail.dart';
import 'package:sample/sample/util/log.dart';
import 'package:sample/sample/widget/common/b_text_widget.dart';

class UserWidget extends ConsumerWidget {
  final UserModel user;
  final UserEmailEditCallBack callBack;
  const UserWidget({
    required this.user,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.d('UserWidget Build !! : ${user.name}');
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return UserDetail(
                  userModel: user,
                  callBack: (model) {
                    callBack.call(model);
                  },
                );
              },
            ),
          );
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
      ),
    );
  }
}
