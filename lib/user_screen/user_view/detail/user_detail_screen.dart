import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/base/base_state_screen.dart';
import 'package:net_test/common/inje_base/orientation/inje_orientation_screen.dart';
import 'package:net_test/user_screen/user_view/detail/user_detail_screen_model.dart';
import 'package:net_test/user_screen/user_view/detail/user_detail_screen_provider.dart';

class TempInjeUserDetailScreen extends InjeOrientationScreen {
  final int userId;
  const TempInjeUserDetailScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget buildLandscape(BuildContext context, WidgetRef ref) {
    final model = ref.watch(userDetailScreenProvider(userId));
    return switch (model) {
      UserDetailScreenStateModelWait() => _UserDetailWaitView(),
      UserDetailScreenStateModelLoading() => _UserDetailLoadingView(),
      UserDetailScreenStateModelSuccess() => _UserDetailSuccessView(
          model: model.viewModel,
        ),
      UserDetailScreenStateModelError() => _UserDetailErrorView(),
    };
  }

  @override
  Widget buildPortrait(BuildContext context, WidgetRef ref) {
    final model = ref.watch(userDetailScreenProvider(userId));
    return switch (model) {
      UserDetailScreenStateModelWait() => _UserDetailWaitView(),
      UserDetailScreenStateModelLoading() => _UserDetailLoadingLandscapeView(),
      UserDetailScreenStateModelSuccess() => _UserDetailSuccessView(
          model: model.viewModel,
        ),
      UserDetailScreenStateModelError() => _UserDetailErrorView(),
    };
  }
}

class UserDetailScreen extends BaseStateScreen<UserDetailScreenStateModel> {
  final int userId;

  UserDetailScreen({
    super.key,
    required this.userId,
  });
  @override
  ProviderListenable<UserDetailScreenStateModel> get viewProvider =>
      userDetailScreenProvider(userId);

  @override
  void initializeWidgetMap(WidgetRef ref) {
    buildAll(
      'UserDetailErrorState',
      portraitFunc: (p0) {
        return _UserDetailErrorView();
      },
    );
    buildAll(
      'UserDetailSuccessState',
      portraitFunc: (p0) {
        return _UserDetailSuccessView(
            model: (p0 as UserDetailScreenStateModelSuccess).viewModel);
      },
    );
    buildAll(
      'UserDetailWaitState',
      portraitFunc: (p0) {
        return _UserDetailWaitView();
      },
    );
    buildAll(
      'UserDetailLoadingState',
      portraitFunc: (p0) {
        return _UserDetailLoadingView();
      },
      landscapeFunc: (p0) {
        return _UserDetailLoadingLandscapeView();
      },
    );
  }
}

class _UserDetailErrorView extends StatelessWidget {
  const _UserDetailErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('에러 스테이트'),
    );
  }
}

class _UserDetailLoadingView extends StatelessWidget {
  const _UserDetailLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _UserDetailLoadingLandscapeView extends StatelessWidget {
  const _UserDetailLoadingLandscapeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _UserDetailWaitView extends StatelessWidget {
  const _UserDetailWaitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('대 기 중'),
    );
  }
}

class _UserDetailSuccessView extends StatelessWidget {
  final UserDetailScreenDataModel model;

  const _UserDetailSuccessView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('id : ${model.model.id}'),
        Text('name : ${model.model.name}'),
        Text('userName : ${model.model.userName}'),
        Text('email : ${model.model.email}'),
      ],
    ));
  }
}
