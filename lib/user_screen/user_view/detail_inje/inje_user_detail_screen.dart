import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:net_test/common/inje_base/inje_screen.dart';
import 'package:net_test/common/inje_base/inje_view.dart';
import 'package:net_test/user_screen/user_view/detail/user_detail_screen_model.dart';
import 'package:net_test/user_screen/user_view/detail/user_detail_screen_provider.dart';
import 'package:riverpod/src/framework.dart';

import 'inje_user_detail_view_provider.dart';

class InjeUserDetailScreen extends InjeScreen {
  final int userId;

  const InjeUserDetailScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Screen에서 watch를 하게되면 모든 뷰가 갱신되기때문에 이러면 안됩니다.
    /// 관리는 여기서 하되 필요한데이터를 각 뷰가 select해서 UI를 갱신해야합니다.
    // final model = ref.watch(injeUserDetailViewProvider(userId));
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InjeUserDetailViewName(
            userId: userId,
          ),
          InjeUserDetailViewEmail(
            userId: userId,
          ),
          InjeUserDetailViewUserName(
            userId: userId,
          ),
          // InjeTempUserDetailViewName(
          //   userId: userId,
          // ),
        ],
      ),
    );
  }
}

class InjeTempUserDetailViewName extends InjeView<String> {
  final int userId;

  const InjeTempUserDetailViewName({
    super.key,
    required this.userId,
  });

  @override
  ProviderListenable<String> get viewProvider =>
      userDetailScreenProvider(userId).select((value) {
        assert(value is UserDetailScreenStateModelSuccess);
        return (value as UserDetailScreenStateModelSuccess).viewModel;
      }).select((value) => value.model.name);

  @override
  Widget build(BuildContext context, WidgetRef ref, String viewModel) {
    return Text('일반디테일에서 가져옴 : $viewModel');
  }
}

class InjeUserDetailViewName extends InjeView<String?> {
  final int userId;

  const InjeUserDetailViewName({
    super.key,
    required this.userId,
  });

  @override
  ProviderListenable<String?> get viewProvider =>
      injeUserDetailViewProvider(userId).select((value) {
        return value.name;
      });

  @override
  Widget build(BuildContext context, WidgetRef ref, String? viewModel) {
    return Text('name : ${viewModel ?? 'name null'}');
  }
}

class InjeUserDetailViewEmail extends InjeView<String?> {
  final int userId;

  const InjeUserDetailViewEmail({
    super.key,
    required this.userId,
  });

  @override
  ProviderListenable<String?> get viewProvider =>
      injeUserDetailViewProvider(userId).select((value) {
        return value.email;
      });

  @override
  Widget build(BuildContext context, WidgetRef ref, String? viewModel) {
    return Text('email : ${viewModel ?? 'email null'}');
  }
}

class InjeUserDetailViewUserName extends InjeView<String?> {
  final int userId;

  const InjeUserDetailViewUserName({
    super.key,
    required this.userId,
  });

  @override
  ProviderListenable<String?> get viewProvider =>
      injeUserDetailViewProvider(userId).select((value) {
        return value.userName;
      });

  @override
  Widget build(BuildContext context, WidgetRef ref, String? viewModel) {
    return Text('userName : ${viewModel ?? 'userName is null'}');
  }
}
