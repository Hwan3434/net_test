import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/ui/app/common/user_detail_notifier.dart';
import 'package:sample/sample/util/log.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';
import 'package:sample/sample/widget/common/b_text_widget.dart';

class UserDetailView extends StatelessWidget {
  static String get path => 'UserDetailView';
  static String get name => 'UserDetailView';
  final int userId;
  const UserDetailView({required this.userId});

  static final userDetailViewModelProvider = StateNotifierProvider.autoDispose
      .family<UserDetailNotifier, UserDetailModel, int>((ref, userId) {
    final projectId = ref.read(GlobalStateStorage().currentProjectIdProvider);
    assert(projectId != 0);
    final project =
        ref.read(GlobalStateStorage().projectProvider.notifier).get(projectId);
    final user = ref
        .read(GlobalStateStorage().userStateProvider(project).notifier)
        .get(userId);

    return UserDetailNotifier(UserDetailModel(
      project: project,
      userModel: user,
    ));
  });

  @override
  Widget build(BuildContext context) {
    return UserDetailBody(
      userId: userId,
    );
  }
}

class UserDetailBody
    extends ProviderStatefulWidget<UserDetailNotifier, UserDetailModel> {
  final int userId;
  const UserDetailBody({
    required this.userId,
  });

  @override
  ProviderState<UserDetailBody, UserDetailNotifier, UserDetailModel>
      createState() => _UserDetailBodyState();

  @override
  AutoDisposeStateNotifierProvider<UserDetailNotifier, UserDetailModel>
      get provider => UserDetailView.userDetailViewModelProvider(userId);
}

class _UserDetailBodyState
    extends ProviderState<UserDetailBody, UserDetailNotifier, UserDetailModel> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    final viewModel = ref.read(widget.provider);
    controller = TextEditingController(text: viewModel.userModel.email);
    controller.addListener(() {
      final email = controller.text;
      ref.read(widget.provider.notifier).update(
            userModel: viewModel.userModel.copyWith(email: email),
          );
    });
  }

  @override
  Widget pBuild(BuildContext context) {
    final viewModel = ref.read(widget.provider);
    Log.i('UserDetailBody build');
    return Scaffold(
      appBar: AppBar(
        title: Text('디테일'),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: _WatchTestWidget(
                      userId: widget.userId,
                    ),
                  ),
                  TextField(
                    controller: controller,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(GlobalStateStorage()
                        .userStateProvider(viewModel.project)
                        .notifier)
                    .update(
                        viewModel.userModel.copyWith(email: controller.text));

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

class _WatchTestWidget extends ProviderStatelessWidget {
  final int userId;
  const _WatchTestWidget({
    required this.userId,
  });

  @override
  Widget pBuild(BuildContext context, WidgetRef ref) {
    Log.i('_WatchTestWidget build');
    final email = ref.watch(provider.select((value) => value.userModel.email));
    return BTextWidget(
      'email : $email',
      overflow: TextOverflow.visible,
      maxLines: null,
    );
  }

  @override
  AutoDisposeStateNotifierProvider<UserDetailNotifier, UserDetailModel>
      get provider => UserDetailView.userDetailViewModelProvider(userId);
}
