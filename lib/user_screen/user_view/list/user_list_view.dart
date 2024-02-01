import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/app_const.dart';
import 'package:net_test/common/base/base_state_view.dart';
import 'package:net_test/manager/data_manager.dart';
import 'package:net_test/user_screen/user_view/detail_inje/inje_user_detail_screen.dart';

import 'user_list_view_provider.dart';
import 'user_list_view_state.dart';

class UserListView extends BaseStateView<UserListViewStateModel> {
  UserListView({
    super.key,
  });

  @override
  ProviderListenable<UserListViewStateModel> get viewProvider =>
      userListViewProvider;

  @override
  void initializeWidgetMap(WidgetRef ref) {
    buildAll(
      'UserListViewStateWait',
      portraitFunc: (p0) {
        return _WaitWidget();
      },
      landscapeFunc: (p0) {
        return Center(
          child: Text('랜드'),
        );
      },
    );
    buildAll(
      'UserListViewStateLoading',
      portraitFunc: (p0) {
        return _LoadingWidget(testState: p0);
      },
    );
    buildAll(
      'UserListViewStateSuccess',
      portraitFunc: (p0) {
        return _SuccessPortraitWidget(state: p0 as UserListViewStateSuccess);
      },
      landscapeFunc: (p0) {
        return _SuccessLandscapeWidget(state: p0 as UserListViewStateSuccess);
      },
    );
    buildAll(
      'UserListViewStateError',
      portraitFunc: (p0) {
        return _ErrorWidget(state: p0 as UserListViewStateError);
      },
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  final UserListViewStateModel testState;

  const _LoadingWidget({
    required this.testState,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '사용자 데이터를 가져오는 중입니다.',
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}

class _WaitWidget extends ConsumerWidget {
  const _WaitWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '💥목표 : tree복사 → tree참조로 → 화면갱신까지💥\r\n플롯팅버튼을 눌러서 사용자데이터를 가져오세요.(${AppConst.delay.inSeconds}초 딜레이)\r\nProvider',
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(userListViewProvider.notifier).fetchData();
            },
            child: Text('데이터 가져오기'),
          ),
        ],
      ),
    );
  }
}

class _ErrorWidget extends ConsumerWidget {
  final UserListViewStateError state;

  const _ErrorWidget({
    required this.state,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            '데이터를 불러오는데 실패하였습니다.\ne : ${state.errorMessage}',
            textAlign: TextAlign.center,
          ),
        ),
        ElevatedButton(
          child: Text('서비스 변경'),
          onPressed: () {
            ref
                .read(DataManager().usecaseStateProvider.notifier)
                .update(service: 'typicode');
          },
        ),
      ],
    );
  }
}

class _SuccessPortraitWidget extends StatelessWidget {
  final UserListViewStateSuccess state;

  const _SuccessPortraitWidget({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: state.loginUserList.length,
        itemBuilder: (context, index) {
          final item = state.loginUserList[index];
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return InjeUserDetailScreen(
                      userId: item.id,
                    );
                  },
                ));
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '(id: ${item.id}) ${item.name} 세로',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SuccessLandscapeWidget extends StatelessWidget {
  final UserListViewStateSuccess state;

  const _SuccessLandscapeWidget({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: state.loginUserList.length,
        itemBuilder: (context, index) {
          final item = state.loginUserList[index];
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return InjeUserDetailScreen(
                      userId: item.id,
                    );
                  },
                ));
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '(id: ${item.id}) ${item.name} 가로',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
