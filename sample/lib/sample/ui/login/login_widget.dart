import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/common/usecase_manager.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/ui/app/content/content_widget.dart';
import 'package:sample/sample/ui/login/login_text_widget.dart';
import 'package:sample/sample/ui/login/login_view_model.dart';
import 'package:sample/sample/util/log.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';

class LoginWidget
    extends ProviderStatefulWidget<LoginStateNotifier, LoginViewModel> {
  static String get path => 'Login';
  static String get name => 'LoginWidget';
  const LoginWidget();

  static final loginViewModelProvider =
      StateNotifierProvider.autoDispose<LoginStateNotifier, LoginViewModel>(
          (ref) {
    final agentUseCase = ref.read(UseCaseManager().agentUseCaseProvider);
    return LoginStateNotifier(
        LoginViewModel(
          id: '',
          pw: '',
        ),
        agentUseCase);
  });

  @override
  ProviderState createState() => _LoginWidgetState();

  @override
  AutoDisposeStateNotifierProvider<LoginStateNotifier, LoginViewModel>
      get provider => loginViewModelProvider;
}

class _LoginWidgetState
    extends ProviderState<LoginWidget, LoginStateNotifier, LoginViewModel> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idController.addListener(() {
      ref.read(widget.provider.notifier).update(id: idController.text);
    });
    pwController.addListener(() {
      ref.read(widget.provider.notifier).update(pw: pwController.text);
    });
  }

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget pBuild(BuildContext context) {
    ref.listen(GlobalStateStorage().agentStateProvider, (previous, next) {
      if (next.state == AgentState.success) {
        context.goNamed(ContentWidget.name);
      }
    });

    final agent = ref.watch(GlobalStateStorage().agentStateProvider);
    Log.d('agent : ${agent.runtimeType}');
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: idController,
          ),
          Builder(
            builder: (context) {
              final id = ref.watch(widget.provider.select((value) => value.id));
              return Text('userID : $id');
            },
          ),
          TextField(
            controller: pwController,
          ),
          Consumer(
            builder: (context, ref, child) {
              final text =
                  ref.watch(widget.provider.select((value) => value.pw));
              return LoginTextWidget(
                text,
                validateFn: (text) {
                  if (text != 'dddd') {
                    return ValidateModel(
                      success: false,
                      color: Colors.red,
                      message: '비밀번호가 맞지않음',
                    );
                  } else {
                    return ValidateModel(
                      success: true,
                    );
                  }
                },
              );
            },
          ),
          SizedBox(
            height: 50,
          ),
          if (agent.state == AgentState.loading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (agent.state == AgentState.wait)
            ElevatedButton(
              onPressed: () {
                final validate =
                    ref.read(widget.provider.notifier).isValidate();
                if (validate) {
                  Log.d('삼번');
                  ref
                      .read(GlobalStateStorage().agentStateProvider.notifier)
                      .login(idController.text, pwController.text);
                  Log.d('사번');
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('에러')));
                }
              },
              child: Text('로그인(pw = "dddd")'),
            )
        ],
      ),
    );
  }
}
