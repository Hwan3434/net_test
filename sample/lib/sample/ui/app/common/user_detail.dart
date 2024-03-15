import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';

final userChildProvider =
    Provider.autoDispose.family<UserModel, PUModel>((ref, model) {
  final userState = ref.watch(
    GlobalStateStorage().userStateProvider(model.pm).select(
          (value) => value.data[model.index],
        ),
  );
  return userState;
});

class PUModel {
  final ProjectDataModel pm;
  final int index;

  const PUModel({
    required this.pm,
    required this.index,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PUModel &&
          runtimeType == other.runtimeType &&
          pm.id == other.pm.id &&
          index == other.index;

  @override
  int get hashCode => pm.id.hashCode ^ index.hashCode;
}

typedef UserEmailEditCallBack = void Function(UserModel model);

class UserDetail extends ConsumerStatefulWidget {
  final UserModel userModel;
  final UserEmailEditCallBack callBack;
  const UserDetail({
    super.key,
    required this.userModel,
    required this.callBack,
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
                widget.callBack(
                    widget.userModel.copyWith(email: controller.text));
                Navigator.pop(context);
              },
              child: Text('저장'),
            )
          ],
        ),
      ),
    );
  }
}
