import 'package:domain/usecase/user/model/response/user_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/screen/base_screen.dart';
import 'package:net_test/user_screen/user_view/detail/user_detail_view_model.dart';
import 'package:net_test/user_screen/user_view/detail/user_detail_view_provider.dart';

class UserDetailView extends ConsumerWidget {
  final int userId;
  const UserDetailView({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(userDetailViewProvider(userId));
    return BaseScreen(
      appBar: AppBar(
        title: Text('Detail'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      view: _StateView(state: viewState),
    );
  }
}

class _StateView extends StatelessWidget {
  final UserDetailState state;
  const _StateView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case UserDetailWaitState():
        return Center(
          child: Text('wait'),
        );
      case UserDetailLoadingState():
        return Center(
          child: Text('loading'),
        );
      case UserDetailSuccessState(viewModel: final data):
        return _SuccessState(state: (state as UserDetailSuccessState));
      case UserDetailErrorState():
        return Center(
          child: Text('error'),
        );
    }
  }
}

class _SuccessState extends StatelessWidget {
  final UserDetailSuccessState state;
  const _SuccessState({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final user = state.viewModel.model;
    if (user is UserDetailModel) {
      return Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('id : ${user.id}'),
          Text('name : ${user.name}'),
          Text('userName : ${user.userName}'),
          Text('email : ${user.email}'),
        ],
      ));
    }

    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('id : ${user.id}'),
        Text('name : ${user.name}'),
      ],
    ));
  }
}
