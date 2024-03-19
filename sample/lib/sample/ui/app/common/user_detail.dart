import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';

class UserDetail extends ConsumerStatefulWidget {
  static String get path => 'UserDetail';
  static String get name => 'UserDetail';

  final ProjectDataModel project;
  final UserModel userModel;
  const UserDetail({
    super.key,
    required this.project,
    required this.userModel,
  });

  @override
  ConsumerState<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends ConsumerState<UserDetail> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.userModel.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('디테일'),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Text('email : '),
            Expanded(
              child: TextField(
                controller: controller,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(GlobalStateStorage()
                        .userStateProvider(widget.project)
                        .notifier)
                    .update(widget.userModel.copyWith(email: controller.text));

                context.pop();
              },
              child: Text('저장'),
            )
          ],
        ),
      ),
    );
  }
}
